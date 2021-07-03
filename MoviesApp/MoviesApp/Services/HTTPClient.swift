//
//  HTTPClient.swift
//  MoviesApp
//
//  Created by Taeeun Kim on 28.06.21.
//  Copyright © 2021 Mohammad Azam. All rights reserved.
//

import Foundation

enum NetworkError: Error {
    case badURL
    case noData
    case decodingError
}

class HTTPClient {
    
    // @frozen enum Result<Success, Failure> where Failure : Error
    func getMoviesBy(search: String, completion: @escaping (Result<[Movie]?, NetworkError>) -> Void) {
        
        guard let url = URL.forMoviesByName(search) else {
            return completion(.failure(.badURL))
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            guard let data = data, error == nil else {
                return completion(.failure(.noData))
            }
            
            guard let movieResponse = try? JSONDecoder().decode(MovieResponse.self, from: data)
            else {
                return completion(.failure(.decodingError))
            }
            
            completion(.success(movieResponse.movies))
        }
        .resume()
    }
}
