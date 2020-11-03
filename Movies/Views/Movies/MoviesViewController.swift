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
        collectionView.register(FooterUCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: FooterUCollectionReusableView.ReuseIdentifier)
        
        return collectionView
    }()
    
    private lazy var barButtonItem : UIBarButtonItem = {
        let layout = UIBarButtonItem(image: UIImage(named: "ListIcon"), style: .plain, target: self, action: #selector(changeCollectionViewDisplay))
            return layout
    }()
    
    private lazy var searchController : UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Movies"
        return searchController
    }()
    
    private let moviesDataSource = MoviesDataSource()
    
    private lazy var viewModel : MoviesViewModel = {
        let viewModel = MoviesViewModel(dataSource: moviesDataSource)
        return viewModel
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Movies"
        
        setupViews()
        
        self.moviesDataSource.data.addObserver(self) { [weak self] _ in
            self?.activityIndicator.stopAnimating()
            self?.collectionView.reloadData()
        }
        
        self.viewModel.onErrorHandling = { [weak self] error in
            let controller = UIAlertController(title: "Error", message: "Unexpected error occurred!!", preferredStyle: .alert)
            controller.addAction(UIAlertAction(title: "Try Again", style: .default, handler: {_ in
                self?.fetch()
            }))
            self?.present(controller, animated: true, completion: nil)
        }
        
        fetch()
    }
    
    //protocol LoadMoreAction - FooterUCollectionReusableView.swift
    @objc func tapLoadMore(){
        fetch()
    }
    
    func fetch(){
        self.viewModel.fetchMovies()
    }
    
    func setupViews(){
        navigationItem.rightBarButtonItem = barButtonItem
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = true
        definesPresentationContext = true
        
        view.addSubview(collectionView)
        collectionView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        collectionView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        collectionView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        
        view.addSubview(activityIndicator)
        activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        activityIndicator.startAnimating()
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

extension MoviesViewController: UISearchResultsUpdating {
    var isSearchBarEmpty: Bool {
      return searchController.searchBar.text?.isEmpty ?? true
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        filterContentForSearchText(searchBar.text!)
    }

    
    func filterContentForSearchText(_ searchText: String) {
        var filteredMovies : [Movie]
        
        if isSearchBarEmpty {
            filteredMovies = self.moviesDataSource.data.value
        }else{
            filteredMovies = self.moviesDataSource.data.value.filter { (movie: Movie) -> Bool in
                 return movie.title!.lowercased().contains(searchText.lowercased())
             }
        }
        
        self.moviesDataSource.filteredData.value = filteredMovies
        collectionView.reloadData()
    }
}

extension MoviesViewController: UISearchControllerDelegate {
    func didDismissSearchController(_ searchController: UISearchController){
        self.moviesDataSource.isFiltering = false
        collectionView.reloadData()
    }
    func willPresentSearchController(_ searchController: UISearchController){
        self.moviesDataSource.isFiltering = true
    }
}
