//
//  MovieCollectionViewCell.swift
//  Movies
//
//  Created by Dogan Ekici on 2.11.2020.
//

import UIKit

class MovieCollectionViewCell: UICollectionViewCell {
    static let ReuseIdentifier = "MovieCell"

    private lazy var imgMovie: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .yellow
        return imageView
    }()
    
    private lazy var lblTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .red
        label.numberOfLines = 3
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(imgMovie)
        imgMovie.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        imgMovie.topAnchor.constraint(equalTo: topAnchor).isActive = true
        imgMovie.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        imgMovie.heightAnchor.constraint(equalTo: heightAnchor).isActive = true
        
        addSubview(lblTitle)
        lblTitle.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        lblTitle.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        lblTitle.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
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
