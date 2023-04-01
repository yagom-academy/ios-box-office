//
//  DetailMovieViewController.swift
//  BoxOffice
//
//  Created by Rhode, Rilla on 2023/03/31.
//

import UIKit

final class DetailMovieViewController: UIViewController {
    private let server = NetworkManager()
    private let urlMaker = URLRequestMaker()
    private var movieCode: String
    private var detailMovieInformation: DetailMovieInformation?
    private var moviePoster: MoviePoster?
    
    private let scrollView: UIScrollView = {
        let scrollview = UIScrollView()
        scrollview.translatesAutoresizingMaskIntoConstraints = false
        
        return scrollview
    }()
    private let contentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    init(movieCode: String) {
        self.movieCode = movieCode
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private func configureMainView() {
        view.backgroundColor = .white
        title = detailMovieInformation?.movieInformationResult.movieInformation.movieName
    }
    
    private func fetchMovieInformationData(movieCode: String, completion: @escaping () -> Void) {
        guard let request = urlMaker.makeMovieInformationURLRequest(movieCode: movieCode) else { return }
        
        server.startLoad(request: request, mime: "json") { result in
            let decoder = DecodeManager()
            do {
                guard let verifiedFetchingResult = try self.verifyResult(result: result) else { return }
                let decodedFile = decoder.decodeJSON(data: verifiedFetchingResult, type: DetailMovieInformation.self)
                let verifiedDecodingResult = try self.verifyResult(result: decodedFile)
                
                self.detailMovieInformation = verifiedDecodingResult
                completion()
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    private func fetchMoviePosterData(movieName: String, completionHandler: @escaping () -> Void) {
        guard let posterRequest = urlMaker.makeMoviePosterURLRequest(movieName: movieName) else { return }
        server.startLoad(request: posterRequest, mime: "json") { result in
            let decoder = DecodeManager()
            do {
                guard let verifiedFetchingResult = try self.verifyResult(result: result) else { return }
                let decodedFile = decoder.decodeJSON(data: verifiedFetchingResult, type: MoviePoster.self)
                let verifiedDecodingResult = try self.verifyResult(result: decodedFile)
                
                self.moviePoster = verifiedDecodingResult
                completionHandler()
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    private func fetchPosterImageData() {
        guard let urlString = moviePoster?.documents[0].imageURL,
              let url = URL(string: urlString)  else { return }
        let request = URLRequest(url: url)
        server.startLoad(request: request, mime: "image") { result in
            do {
                guard let verifiedFetchingResult = try self.verifyResult(result: result) else { return }
                let image = UIImage(data: verifiedFetchingResult)
                
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    private func verifyResult<T, E: Error>(result: Result<T, E>) throws -> T? {
        switch result {
        case .success(let data):
            return data
        case .failure(let error):
            throw error
        }
    }
    
    private func configureScrollView() {
        view.addSubview(scrollView)
        
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    private func configureStackView() {
        scrollView.addSubview(contentStackView)
        
        NSLayoutConstraint.activate([
            contentStackView.leadingAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.leadingAnchor),
            contentStackView.trailingAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.trailingAnchor),
            contentStackView.topAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.topAnchor),
            contentStackView.bottomAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    private func makeInfoStackView(title: String, context: String?) -> UIStackView  {
        let titleLabel: UILabel = {
            let label = UILabel()
            label.text = title
            label.font = .preferredFont(forTextStyle: .title2)
            label.textAlignment = .center
            
            return label
        }()
        
        let contextLabel: UILabel = {
            let label = UILabel()
            label.text = context
            label.font = .preferredFont(forTextStyle: .body)
            label.textAlignment = .center
            label.numberOfLines = 0
            
            return label
        }()
        
        let stackView: UIStackView = {
            let stackView = UIStackView(arrangedSubviews: [titleLabel, contextLabel])
            stackView.axis = .horizontal
            stackView.alignment = .leading
            stackView.distribution = .fill
            
            return stackView
        }()
        
        return stackView
    }
}
