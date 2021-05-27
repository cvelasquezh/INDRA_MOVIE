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
        service?.successBlock = { [weak self] (response) in
            self?.setModel(response)
        }
        callService()
    }
    
    private func setModel(_ response: Any?) {
        guard let movies = response as? Movies else {
            return
        }
        self.getOutputDelegate()?.onSuccess(response: movies)
    }
}
