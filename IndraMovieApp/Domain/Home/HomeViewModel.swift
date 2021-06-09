//
//  HomeViewModel.swift
//  IndraMovieApp
//
//  Created by Cesar Velasquez on 5/26/21.
//

import Foundation

protocol HomeViewModelOutput: BaseViewModelOutput {
    func onSuccess(response:Movies)
}

class HomeViewModel: BaseViewModel<HomeApiManagerProtocol,HomeViewModelOutput> {

    private let movieDAO: HomeDAOProtocol = HomeDAO()
    init(outputDelegate: HomeViewModelOutput, optionsService: HomeApiManagerProtocol = HomeApiManager()) {
        super.init()
        self.service = optionsService
        self.outputDelegate = outputDelegate
    }
    
    override func callService() {
        super.callService()
        getService()?.getPopularMovies()
    }
    
    public func getMovies() {
        if(Connectivity.isConnectedToInternet() ?? false) {
            service?.successBlock = { [weak self] (response) in
                self?.setModel(response)
            }
            callService()
        } else {
            if movieDAO.getAllMovies().count > 0 {
                let movies = Movies(listOfMovies: movieDAO.getAllMovies())
                self.getOutputDelegate()?.onSuccess(response: movies)
            }
            self.setInternetConnectionErrorBlock()
        }
    
    }
    
    private func setModel(_ response: Any?) {
        guard let movies = response as? Movies else {
            return
        }
        var array = [MovieBD]()
        for movie in movies.listOfMovies {
            let movieBD = MovieBD(movieID: movie.movieID,
                                  title: movie.title,
                                  popularity: movie.popularity,
                                  voteCount: movie.voteCount,
                                  originalTitle: movie.originalTitle,
                                  voteAverage: movie.voteAverage,
                                  sinopsis: movie.sinopsis,
                                  releaseDate: movie.releaseDate,
                                  image: movie.image)
            array.append(movieBD)
        }
        movieDAO.deleteAllMovies()
        movieDAO.saveMovies(items: array)
        self.getOutputDelegate()?.onSuccess(response: movies)
    }
}
