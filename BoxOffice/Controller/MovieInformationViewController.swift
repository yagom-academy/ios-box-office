//
//  MovieInformationViewController.swift
//  BoxOffice
//
//  Created by 리지, kokkilE on 2023/03/29.
//

import UIKit

final class MovieInformationViewController: UIViewController {
    var movieInformationStackView = MovieInformationStackView()
    let movieInformationScrollView = UIScrollView()
    
    var movieName: String
    var movieCode: String
    
    lazy var boxOfficeEndPoint = BoxOfficeEndPoint.MovieInformation(movieCode: movieCode, httpMethod: .get)
    lazy var moviePosterImageEndPoint = BoxOfficeEndPoint.MoviePosterImage(query: movieName + " 영화 포스터", httpMethod: .get)
    let networkManager = NetworkManager()
    var movieInformation: MovieInformation?
    
    init(movieName: String, movieCode: String) {
        self.movieName = movieName
        self.movieCode = movieCode
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        self.title = movieName
        
        view.addSubview(movieInformationScrollView)
        configureScrollView()
        configureContentView()
        fetchMovieInformation()
        fetchMoviePosterImage()
    }
    
    private func configureScrollView() {
        movieInformationScrollView.addSubview(movieInformationStackView)
        
        movieInformationScrollView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            movieInformationScrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            movieInformationScrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            movieInformationScrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            movieInformationScrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
    
    private func configureContentView() {
        movieInformationStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            movieInformationStackView.topAnchor.constraint(equalTo: movieInformationScrollView.topAnchor),
            movieInformationStackView.leadingAnchor.constraint(equalTo: movieInformationScrollView.leadingAnchor),
            movieInformationStackView.bottomAnchor.constraint(equalTo: movieInformationScrollView.bottomAnchor),
            movieInformationStackView.trailingAnchor.constraint(equalTo: movieInformationScrollView.trailingAnchor),
            movieInformationStackView.widthAnchor.constraint(equalTo: movieInformationScrollView.widthAnchor, multiplier: 1)
        ])
    }
    
    private func fetchMovieInformation() {
        networkManager.request(endPoint: boxOfficeEndPoint, returnType: MovieInformation.self) { [weak self] in
            switch $0 {
            case .failure(let error):
                print(error)
            case .success(let result):
                DispatchQueue.main.async {
                    self?.movieInformationStackView.movie = result.movieInformationResult.movie
                    self?.movieInformationStackView.configure()
                }
            }
        }
    }
    
    private func fetchMoviePosterImage() {
        networkManager.request(endPoint: moviePosterImageEndPoint, returnType: MoviePosterImage.self) { [weak self] in
            switch $0 {
            case .failure(let error):
                print(error)
            case .success(let result):
                DispatchQueue.main.async {
                    guard let firstDocument = result.documents.first,
                          let imageURL = URL(string: firstDocument.imageURL) else { return }
                    self?.movieInformationStackView.moviePosterImageView.load(url: imageURL)
                }
            }
        }
    }
}

extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            guard let data = try? Data(contentsOf: url),
                  let image = UIImage(data: data) else { return }
            DispatchQueue.main.async {
                self?.image = image
            }
        }
    }
}


//func updateUI(_ url : String){
//
//        var tempImg : UIImage
//
//         DispatchQueue.global().async {
//
//             if let ImageData = try? Data(contentsOf: URL(string: url)!) {
//
//                tempImg = UIImage(data: ImageData)!
//            }
//            else{
//                tempImg = UIImage(named: "Asset 20.png")!
//            }
//
//             DispatchQueue.main.async {
//
//                        self.StoreImg.image = tempImg
//
//                    }
//
//         }
