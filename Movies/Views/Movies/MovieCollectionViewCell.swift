//
//  MovieCollectionViewCell.swift
//  Movies
//
//  Created by Dogan Ekici on 2.11.2020.
//

import UIKit

class MovieCollectionViewCell: UICollectionViewCell {
    static let ReuseIdentifier = "MovieCell"

    lazy var imgMovie: CacheImageView = {
        let imageView = CacheImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .systemGray6
        imageView.layer.cornerRadius = 10.0
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    lazy var lblTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.numberOfLines = 3
        label.font = UIFont.boldSystemFont(ofSize:15)
        return label
    }()
    
    lazy var imgFavorite: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "FilledStarIcon")
        imageView.layer.shadowColor = UIColor.white.cgColor
        imageView.layer.shadowOpacity = 1
        imageView.layer.shadowOffset = .zero
        imageView.layer.shadowRadius = 8
        imageView.layer.shouldRasterize = true
        imageView.layer.rasterizationScale = UIScreen.main.scale
        return imageView
    }()
    
    private lazy var titleOverlay: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .black
        view.alpha = 0.8
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        addSubview(imgMovie)
        imgMovie.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        imgMovie.topAnchor.constraint(equalTo: topAnchor).isActive = true
        imgMovie.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        imgMovie.heightAnchor.constraint(equalTo: heightAnchor).isActive = true
        
        addSubview(titleOverlay)
        titleOverlay.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        titleOverlay.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        titleOverlay.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        
        titleOverlay.addSubview(lblTitle)
        lblTitle.bottomAnchor.constraint(equalTo: titleOverlay.bottomAnchor, constant: -10).isActive = true
        lblTitle.leadingAnchor.constraint(equalTo: titleOverlay.leadingAnchor, constant: 10).isActive = true
        lblTitle.trailingAnchor.constraint(equalTo: titleOverlay.trailingAnchor, constant: -10).isActive = true
        
        titleOverlay.topAnchor.constraint(equalTo: lblTitle.topAnchor, constant: -10).isActive = true
        
        addSubview(imgFavorite)
        imgFavorite.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
        imgFavorite.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imgMovie.image = nil
        lblTitle.text = ""
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
