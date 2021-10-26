//
//  MovieListViewModel.swift
//  MoviesApp
//
//  Created by Taeeun Kim on 25.10.21.
//  Copyright © 2021 Mohammad Azam. All rights reserved.
//

import Foundation
import SwiftUI

class MovieListViewModel: ObservableObject {
    
    @Published var movies = [MovieViewModel]()
    let httpClient = HTTPClient()
    
    func searchByName(_ name: String) {
        
        httpClient.getMoviesBy(search: name) { result in
            switch result {
            case: .success(let movies):
                if let movies = movies {
                    self.movies = movies.map(MovieViewModel.init)
                }
            case: .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
}

struct MovieViewModel {
    
    let movie: Movie
    
    var imdbId: String {
        movie.imdbId
    }
    
    var title: String {
        movie.title
    }
    
    var poster: String {
        movie.poster
    }
    
    var year: String {
        movie.year
    }
}
