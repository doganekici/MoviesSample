//
//  MoviesViewModel.swift
//  Movies
//
//  Created by Dogan Ekici on 3.11.2020.
//

import Foundation

class MoviesViewModel {
    let baseImageUrl = "https://image.tmdb.org/t/p/w200"
    
    weak var dataSource : GenericDataSource<Movie>?
    weak var service: MoviesServiceProtocol?
    
    var onErrorHandling : ((ErrorResult?) -> Void)?
    
    private var nextPage = 1
    private var movieList : [Movie] = [] {
        didSet {
            self.dataSource?.data.value = movieList
        }
    }
    
    init(service: MoviesServiceProtocol = MoviesService.shared, dataSource : GenericDataSource<Movie>?) {
        self.dataSource = dataSource
        self.service = service
    }
    
    func fetchMovies() {
        
        guard let service = service else {
            onErrorHandling?(ErrorResult.custom(string: "Missing service"))
            return
        }
        
        service.fetch(page: nextPage) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let movies) :
                    self?.processFetchedMovies(movies: movies)
                case .failure(let error) :
                    self?.onErrorHandling?(error)
                }
            }
        }
        
    }
    
    private func processFetchedMovies(movies: Movies ) {
        if nextPage == movies.page{
            nextPage += 1
            let newMovies = movies.movies.map { (movie) -> Movie in
                var mutableMovie = movie
                if let posterPath = movie.posterPath {
                    mutableMovie.posterPath = self.baseImageUrl + posterPath
                }
                return mutableMovie
            }
            movieList.append(contentsOf: newMovies)
        }
    }
}
