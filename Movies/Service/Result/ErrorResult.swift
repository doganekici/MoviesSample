//
//  ErrorResult.swift
//  Movies
//
//  Created by Dogan Ekici on 3.11.2020.
//

import Foundation

enum ErrorResult: Error {
    case network(string: String)
    case parser(string: String)
    case custom(string: String)
}
