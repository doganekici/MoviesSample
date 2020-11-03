//
//  Result.swift
//  Movies
//
//  Created by Dogan Ekici on 3.11.2020.
//

import Foundation

enum Result<T, E: Error> {
    case success(T)
    case failure(E)
}
