//
//  HomeApiManager.swift
//  IndraMovieApp
//
//  Created by Cesar Velasquez on 5/26/21.
//

import Foundation

protocol HomeApiManagerProtocol: BaseApiManagerProtocol {
    func getPopularMovies()
}

class HomeApiManager: BaseApiManager<Movies,ErrorResult> , HomeApiManagerProtocol{
    func getPopularMovies() {
        config.path = Constants.URL.main+Constants.Endpoints.urlListPopularMovies+Constants.apiKey
        get()
    }
}
