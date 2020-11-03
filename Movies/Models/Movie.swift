//
//  Movie.swift
//  Movies
//
//  Created by Dogan Ekici on 3.11.2020.
//

import Foundation

struct Movie : Decodable{
    
    let id: Int
    var posterPath: String?
    let title: String?
    let overview: String?
    
    enum CodingKeys: String, CodingKey {
        case posterPath = "poster_path"
        case title
        case overview
        case id
    }
}
