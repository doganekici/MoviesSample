//
//  MoviesService.swift
//  Movies
//
//  Created by Dogan Ekici on 3.11.2020.
//

import Foundation

protocol MoviesServiceProtocol : class {
    func fetch(page: Int, _ completion: @escaping ((Result<Movies, ErrorResult>) -> Void))
}

final class MoviesService : RequestHandler, MoviesServiceProtocol {
    
    static let shared = MoviesService()
    static let APIKey = "03e07836af250558e7ef9a3365aa88a5"
    
    let endpoint = "https://api.themoviedb.org/3/movie/popular?api_key=\(MoviesService.APIKey)&language=en-US"
    
    var task : URLSessionTask?
    
    func fetch(page: Int, _ completion: @escaping ((Result<Movies, ErrorResult>) -> Void)) {
        
        self.cancelFetchMovies()
        
        task = RequestService().loadData(urlString: endpoint + "&page=\(page)", completion: self.networkResult(completion: completion))
    }
    
    func cancelFetchMovies() {
        
        if let task = task {
            task.cancel()
        }
        task = nil
    }
}
