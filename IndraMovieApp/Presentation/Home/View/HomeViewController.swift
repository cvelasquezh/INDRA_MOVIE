//
//  HomeViewController.swift
//  IndraMovieApp
//
//  Created by Cesar Velasquez on 5/26/21.
//

import UIKit

class HomeViewController: BaseViewController {

    @IBOutlet weak var tableView: UITableView!
    var viewModel: HomeViewModel?
    private var movies = [Movie]()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureTableView()
        self.setupView()
        self.title = "Home"
        
    }
    
    private func configureTableView() {
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(UINib(nibName: "CustomMovieCell", bundle: nil), forCellReuseIdentifier: "CustomMovieCell")
    }
    
    func setupView(){
        viewModel = HomeViewModel(outputDelegate: self)
        viewModel?.getMovies()
    }
    
    private func reloadTableView() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomMovieCell") as! CustomMovieCell
        cell.imageMovie.imageFromServerURL(urlString: "\(Constants.URL.urlImages+self.movies[indexPath.row].image)", placeHolderImage: UIImage(named: "background_starwars")!)
        cell.titleMovie.text = movies[indexPath.row].title
        cell.descriptionMovie.text = movies[indexPath.row].sinopsis
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
               
        //viewModel.makeDetailView(movieID: String(self.movies[indexPath.row].movieID))
        let storyboard = UIStoryboard(name: "Home", bundle: nil)
        guard let controller = storyboard.instantiateViewController(identifier: "DetailViewController") as? DetailViewController else {
            return
        }
        controller.barNavigationIsHidden = false
        controller.movieID = String(self.movies[indexPath.row].movieID)
        self.navigationController?.pushViewController(controller, animated: true)
        

    }
}

extension HomeViewController: HomeViewModelOutput{
    func onSuccess(response: Movies) {
        
        DispatchQueue.main.async {
            self.movies = response.listOfMovies
            self.reloadTableView()
        }
    }
}
