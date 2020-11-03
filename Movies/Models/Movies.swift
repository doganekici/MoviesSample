//
//  Movies.swift
//  Movies
//
//  Created by Dogan Ekici on 3.11.2020.
//

import Foundation

struct Movies : Decodable{
    
    let page: Int
    let totalResult: Int
    let totalPages: Int
    let movies: [Movie]
    
    enum CodingKeys: String, CodingKey {
        case totalResult = "total_results"
        case totalPages = "total_pages"
        case movies = "results"
        case page
    }
}
