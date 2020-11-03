//
//  FooterUCollectionReusableView.swift
//  Movies
//
//  Created by Dogan Ekici on 3.11.2020.
//

import UIKit

@objc protocol LoadMoreAction: AnyObject {
  func tapLoadMore()
}

class FooterUCollectionReusableView: UICollectionReusableView {
    static let ReuseIdentifier = "Footer"
    
    private lazy var btnMore: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize:18)
        button.setTitle("Load More", for: .normal)
        return button
    }()
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .medium)
        indicator.color = .systemGray
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        addSubview(btnMore)
        btnMore.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        btnMore.topAnchor.constraint(equalTo: topAnchor).isActive = true
        btnMore.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        btnMore.heightAnchor.constraint(equalTo: heightAnchor).isActive = true
        btnMore.addTarget(self, action: #selector(tapMore), for: .touchUpInside)
        
        addSubview(activityIndicator)
        activityIndicator.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        activityIndicator.topAnchor.constraint(equalTo: topAnchor).isActive = true
        activityIndicator.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        activityIndicator.heightAnchor.constraint(equalTo: heightAnchor).isActive = true
    }
    
    @objc func tapMore(){
        btnMore.isHidden = true
        activityIndicator.startAnimating()
        UIApplication.shared.sendAction(
            #selector(LoadMoreAction.tapLoadMore),
             to: nil, from: self, for: nil)
    }
    
    func finishLoading(){
        activityIndicator.stopAnimating()
        btnMore.isHidden = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
