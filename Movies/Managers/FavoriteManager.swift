//
//  File.swift
//  Movies
//
//  Created by Dogan Ekici on 4.11.2020.
//

import Foundation

class FavoriteManager {
    static let shared = FavoriteManager()
    private let favoriteUserDefaultsKey = "Favorite"
    
    private var favoriteArray: [Int] = []
    
    init() {
        if let array = UserDefaults.standard.array(forKey: favoriteUserDefaultsKey) as? [Int]{
            favoriteArray = array
        }
    }
    
    func save(movie: Movie){
        favoriteArray.append(movie.id)
        commit()
    }
    
    func remove(movie: Movie) -> Bool{
        if let index = favoriteArray.firstIndex(of: movie.id){
            favoriteArray.remove(at: index)
            commit()
            return true
        }
        return false
    }
    
    func isFavorite(movie: Movie) -> Bool{
        return favoriteArray.contains(movie.id)
    }
    
    func commit(){
        UserDefaults.standard.setValue(favoriteArray, forKey: favoriteUserDefaultsKey)
    }
}
