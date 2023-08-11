//
//  MovieInformationViewController.swift
//  BoxOffice
//
//  Created by Idinaloq, MARY on 2023/08/08.
//

import UIKit

final class MovieInformationViewController: UIViewController {
    private var kobisOpenAPI: KobisOpenAPI = KobisOpenAPI()
    private var kakaoAPI: KakaoAPI = KakaoAPI()
    private var networkService: NetworkService = NetworkService()
    private var dailyBoxOfficeData: DailyBoxOffice
    private var detailInformationData: DetailInformation?
    private var imageSearch: ImageSearch?
    private let loadingView: LoadingView = LoadingView()
    private var completionCount: Int = 0 {
        didSet {
            if completionCount == 2 {
                loadingView.hide()
            }
        }
    }
    
    private let scrollView: MovieInformationScrollView = {
        let scrollView: MovieInformationScrollView = MovieInformationScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        return scrollView
    }()
    
    init(data: DailyBoxOffice) {
        self.dailyBoxOfficeData = data
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigationItem()
        configureView()
        setUpAutolayout()
        receiveBoxOfficeData()
        receiveImageData()
    }
    
    private func configureNavigationItem() {
        navigationItem.title = dailyBoxOfficeData.movieName
    }
    
    private func configureView() {
        view.backgroundColor = .systemBackground
        view.addSubview(loadingView)
        view.addSubview(scrollView)
    }
    
    private func setUpAutolayout() {
        NSLayoutConstraint.activate([
            loadingView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            loadingView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            loadingView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            loadingView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func receiveBoxOfficeData() {
        guard let urlRequest = receiveBoxOfficeURLRequest() else { return }
        
        networkService.fetchData(urlRequest: urlRequest) { result in
            switch result {
            case .success(let data):
                self.decodeBoxOfficeData(data)
                self.updateScrollView()
                self.completionCount += 1
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func receiveBoxOfficeURLRequest() -> URLRequest? {
        do {
            let urlRequest = try kobisOpenAPI.receiveURLRequest(serviceType: .movieInformation, queryItems: ["movieCd": dailyBoxOfficeData.movieCode])
            
            return urlRequest
        } catch {
            print(error.localizedDescription)
            
            return nil
        }
    }
    
    private func decodeBoxOfficeData(_ data: Data) {
        do {
            let decodedData = try JSONDecoder().decode(DetailInformation.self, from: data)
            detailInformationData = decodedData
        } catch {
            print(error.localizedDescription)
        }
    }
    
    private func updateScrollView() {
        DispatchQueue.main.async { [weak self] in
            self?.scrollView.updateLabels(data: self?.detailInformationData?.movieInformationResult.movieInformation)
        }
    }
    
    private func receiveImageData() {
        guard let urlRequest = receiveImageURLRequest() else { return }
        
        networkService.fetchData(urlRequest: urlRequest) { result in
            switch result {
            case .success(let data):
                self.decodeImageData(data)
                self.updateImageView()
                self.completionCount += 1
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func receiveImageURLRequest() -> URLRequest? {
        do {
            let urlRequest = try kakaoAPI.receiveURLRequest(queryItems: ["query": "\(dailyBoxOfficeData.movieName) 영화 포스터", "size": "1"])
            
            return urlRequest
        } catch {
            print(error.localizedDescription)
            
            return nil
        }
    }
    
    private func decodeImageData(_ data: Data) {
        do {
            let decodedData = try JSONDecoder().decode(ImageSearch.self, from: data)
            imageSearch = decodedData
        } catch {
            print(error.localizedDescription)
        }
    }
    
    private func updateImageView() {
        do {
            let image = try downloadImage()
            DispatchQueue.main.async { [weak self] in
                self?.scrollView.updateImage(image: image)
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    private func downloadImage() throws -> UIImage {
        guard let imageURL = imageSearch?.documents.first?.imageURL,
              let url = URL(string: imageURL),
              let data = try? Data(contentsOf: url),
              let image = UIImage(data: data) else {
            throw URLError.urlIsNil
        }
        
        return image
    }
}
