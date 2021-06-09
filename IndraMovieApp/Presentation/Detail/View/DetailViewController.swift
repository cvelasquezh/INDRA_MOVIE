//
//  DetailViewController.swift
//  IndraMovieApp
//
//  Created by Cesar Velasquez on 5/26/21.
//

import UIKit

class DetailViewController: BaseViewController {

    @IBOutlet weak var titleHeader: UILabel!
    @IBOutlet weak var imageFilm: UIImageView!
    @IBOutlet weak var descriptionMovie: UILabel!
    @IBOutlet weak var releaseDate: UILabel!
    @IBOutlet weak var originalTitle: UILabel!
    @IBOutlet weak var voteAverage: UILabel!
    private var movie: MovieDetail?
    
    var viewModel: DetailViewModel?
    var movieID: String?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Detalle"
        setupViewModel()
    }
    
    func setupViewModel(){
        viewModel = DetailViewModel(outputDelegate: self)
        guard let movie = movieID else {
            return
        }
        viewModel?.getDetailMovie(movieID: movie)
    }
}

extension DetailViewController: DetailViewModelOutput {
    func onSuccessDetail(response: MovieDetail) {
        DispatchQueue.main.async {
            let movie = response
            self.titleHeader.text = movie.title
            self.descriptionMovie.text = movie.overview
            self.releaseDate.text = movie.releaseDate
            self.originalTitle.text = movie.originalTitle
            self.voteAverage.text = String(movie.voteAverage)
            self.imageFilm.imageFromServerURL(urlString: Constants.URL.urlImages+movie.posterPath, placeHolderImage: UIImage(named: "background")!)
            
            
        }
    }
}
