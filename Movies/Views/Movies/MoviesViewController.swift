//
//  MoviesViewController.swift
//  Movies
//
//  Created by Dogan Ekici on 2.11.2020.
//

import UIKit

class MoviesViewController: UIViewController {
 
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .medium)
        indicator.color = .systemGray
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    
    private lazy var collectionViewFlowLayout : MoviesCollectionViewFlowLayout = {
            let layout = MoviesCollectionViewFlowLayout(display: .grid)
            return layout
    }()
    
    private lazy var collectionView : UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewFlowLayout)
        collectionView.backgroundColor = .systemBackground
        collectionView.translatesAutoresizingMaskIntoConstraints = false
//        collectionView.delegate = self
        collectionView.dataSource = moviesDataSource
        
        collectionView.register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: MovieCollectionViewCell.ReuseIdentifier)
        return collectionView
    }()
    
    private lazy var barButtonItem : UIBarButtonItem = {
        let layout = UIBarButtonItem(image: UIImage(named: "ListIcon"), style: .plain, target: self, action: #selector(changeCollectionViewDisplay))
            return layout
    }()
    
    private let moviesDataSource = MoviesDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Movies"
        
        setupViews()
    }
    
    func setupViews(){
        navigationItem.rightBarButtonItem = barButtonItem
        navigationItem.searchController = UISearchController(searchResultsController: nil)
        navigationItem.hidesSearchBarWhenScrolling = true
        
        view.addSubview(collectionView)
        collectionView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        collectionView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        collectionView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        
        view.addSubview(activityIndicator)
        activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true

    }
    
    @objc public func changeCollectionViewDisplay() {
        if self.collectionViewFlowLayout.display == .list{
            barButtonItem.image = UIImage(named: "ListIcon")
            self.collectionViewFlowLayout.display = .grid
        }else{
            barButtonItem.image = UIImage(named: "GridIcon")
            self.collectionViewFlowLayout.display = .list
        }
        
    }
}
