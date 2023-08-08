//
//  MovieInformationViewController.swift
//  BoxOffice
//
//  Created by Idinaloq, MARY on 2023/08/08.
//

import UIKit

final class MovieInformationViewController: UIViewController {
    private var kobisOpenAPI: KobisOpenAPI = KobisOpenAPI()
    private var networkService: NetworkService = NetworkService()
    private var dailyBoxOfficeData: DailyBoxOffice
    private var detailInformationData: DetailInformation?

    let scrollView: MovieInformationScrollView = {
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
        receiveData()
    }
    
    private func configureNavigationItem() {
        navigationItem.title = dailyBoxOfficeData.movieName
    }
    
    private func configureView() {
        view.backgroundColor = .systemBackground
        view.addSubview(scrollView)
    }
    
    private func setUpAutolayout() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func receiveData() {
        guard let url = receiveURL() else { return }
        
        NetworkService().fetchData(url: url) { result in
            switch result {
            case .success(let data):
                self.decodeData(data)
                self.updateScrollView()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func receiveURL() -> URL? {
        do {
            let url = try kobisOpenAPI.receiveURL(serviceType: .movieInformation, queryItems: ["movieCd": dailyBoxOfficeData.movieCode])
            return url
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
    
    private func decodeData(_ data: Data) {
        do {
            let decodedData = try JSONDecoder().decode(DetailInformation.self, from: data)
            detailInformationData = decodedData
        } catch let error as DecodingError {
            print(error)
        } catch {
            print(error)
        }
    }
    
    private func updateScrollView() {
        DispatchQueue.main.async { [weak self] in
            self?.scrollView.updateLabels(data: self?.detailInformationData?.movieInformationResult.movieInformation)
        }
    }
}
