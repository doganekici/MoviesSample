//
//  MovieDetailViewController.swift
//  Movies
//
//  Created by Dogan Ekici on 4.11.2020.
//

import UIKit

class MovieDetailViewController: UIViewController {
    var movie: Movie!
    let posterHeight: CGFloat = 300
    
    private lazy var imgPoster : CacheImageView = {
        let imageView = CacheImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .systemGray6
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var scrollView : UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.contentInset = UIEdgeInsets(top: posterHeight, left: 0, bottom: 0, right: 0)
        scrollView.alwaysBounceVertical = true
        scrollView.delegate = self
        return scrollView
    }()
    
    private lazy var contentView : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemBackground
        return view
    }()
    
    private lazy var lblTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize:30)
        return label
    }()
    
    private lazy var lblVote: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        return label
    }()
    
    private lazy var lblOverview: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Movie Details"
        view.backgroundColor = .systemBackground
        navigationItem.largeTitleDisplayMode = .never
        
        setupViews()
        fillViews()
    }
    
    var imgPosterHeightConstraint : NSLayoutConstraint?
    
    func setupViews(){
        view.addSubview(imgPoster)
        imgPoster.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        imgPoster.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        imgPoster.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor).isActive = true
        imgPosterHeightConstraint = imgPoster.heightAnchor.constraint(equalToConstant: posterHeight)
        imgPosterHeightConstraint?.isActive = true
        
        view.addSubview(scrollView)
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        scrollView.addSubview(contentView)
        contentView.leftAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leftAnchor).isActive = true;
        contentView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor).isActive = true;
        contentView.rightAnchor.constraint(equalTo: scrollView.contentLayoutGuide.rightAnchor).isActive = true;
        contentView.heightAnchor.constraint(equalTo: scrollView.contentLayoutGuide.heightAnchor).isActive = true;
        
        contentView.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor).isActive = true
        
        contentView.addSubview(lblTitle)
        lblTitle.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        lblTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10).isActive = true
        lblTitle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10).isActive = true
        
        contentView.addSubview(lblVote)
        lblVote.topAnchor.constraint(equalTo: lblTitle.bottomAnchor, constant: 10).isActive = true
        lblVote.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10).isActive = true
        lblVote.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10).isActive = true
        
        contentView.addSubview(lblOverview)
        lblOverview.topAnchor.constraint(equalTo: lblVote.bottomAnchor, constant: 10).isActive = true
        lblOverview.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10).isActive = true
        lblOverview.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10).isActive = true
        
        lblOverview.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10).isActive = true
    }
    
    func fillViews(){
        imgPoster.loadImage(witUrlString: movie.posterPath)
        lblTitle.text = movie.title
        lblOverview.text = movie.overview
        if let voteCount = movie.voteCount, voteCount > 0{
            lblVote.text = "\(movie.voteAverage ?? 0)/10 (\(voteCount))"
        }
    }
}

extension MovieDetailViewController: UIScrollViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        imgPosterHeightConstraint?.constant = -scrollView.contentOffset.y
    }
}
