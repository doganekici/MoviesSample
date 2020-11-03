//
//  ParserHelper.swift
//  Movies
//
//  Created by Dogan Ekici on 3.11.2020.
//

import Foundation

final class ParserHelper {
    
    static func parse<T: Decodable>(data: Data, completion : (Result<[T], ErrorResult>) -> Void) {
        
        do {
            
            let result = try JSONDecoder().decode([T].self, from: data)
            completion(.success(result))

        } catch {
            completion(.failure(.parser(string: "Error while parsing json data")))
        }
    }
    
    static func parse<T: Decodable>(data: Data, completion : (Result<T, ErrorResult>) -> Void) {
        
        do {
            
            let result = try JSONDecoder().decode(T.self, from: data)
            completion(.success(result))
            
        } catch {
            completion(.failure(.parser(string: "Error while parsing json data")))
        }
    }
}
