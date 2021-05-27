//
//  DetailViewModel.swift
//  IndraMovieApp
//
//  Created by Cesar Velasquez on 5/26/21.
//

import Foundation

protocol DetailViewModelOutput: BaseViewModelOutput {
    func onSuccessDetail(response:MovieDetail)
}

class DetailViewModel: BaseViewModel<DetailMovieApiManagerProtocol,DetailViewModelOutput> {
    
    var movieID: String?
    
    init(outputDelegate: DetailViewModelOutput, optionsService: DetailMovieApiManagerProtocol = DetailMovieApiManager()) {
        super.init()
        self.service = optionsService
        self.outputDelegate = outputDelegate
    }
    
 
    override func callService() {
        super.callService()
        getService()?.getDetailMovies(movieID: self.movieID!)
    }
    
    public func getDetailMovie(movieID: String) {
        self.movieID = movieID
        service?.successBlock = { [weak self] (response) in
            self?.setModel(response)
        }
        callService()
    }
    
    private func setModel(_ response: Any?) {
        guard let movie = response as? MovieDetail else {
            return
        }
        self.getOutputDelegate()?.onSuccessDetail(response: movie)
    }
    
    
}


