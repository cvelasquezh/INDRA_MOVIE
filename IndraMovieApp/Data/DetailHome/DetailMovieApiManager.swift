//
//  DetailMovieApiManager.swift
//  IndraMovieApp
//
//  Created by Cesar Velasquez on 5/26/21.
//

import Foundation

protocol DetailMovieApiManagerProtocol: BaseApiManagerProtocol {
    func getDetailMovies(movieID: String)
}

class DetailMovieApiManager: BaseApiManager<MovieDetail,ErrorResult> , DetailMovieApiManagerProtocol{
    func getDetailMovies(movieID: String) {
        config.path = Constants.URL.main+Constants.Endpoints.urlDetailMovie+movieID+Constants.apiKey
        get()
    }
}
