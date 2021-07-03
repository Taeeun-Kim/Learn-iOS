//
//  URL+Extensions.swift
//  MoviesApp
//
//  Created by Taeeun Kim on 03.07.21.
//  Copyright © 2021 Mohammad Azam. All rights reserved.
//

import Foundation

extension URL {
    
    static func forMoviesByName(_ name: String) -> URL? {
        return URL(string: "http://www.omdbapi.com/?s=\(name)&apikey=\(Constants.API_KEY)")
    }
}
