//
//  MovieDetailViewController.swift
//  BoxOffice
//
//  Created by goat, songjun on 2023/03/30.
//

import UIKit

class MovieDetailViewController: UIViewController {
    let boxOfficeService = BoxOfficeService()
    private let imageSearchService = ImageSearchService()
    private let movieDetailView = MovieDetailView()
    private let provider = Provider()
    private let activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.style = UIActivityIndicatorView.Style.large
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        return activityIndicator
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = movieDetailView
        setActivityIndicator()
        fetchMoiveDetail()
        }
    
    private func setActivityIndicator() {
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    func fetchMoiveDetail() {
        boxOfficeService.fetchMovieDetailAPI {
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.setMovieDetailLabel()
                self.fetchImage()
                self.activityIndicator.stopAnimating()
            }
        }
    }
    
    private func setMovieDetailLabel() {
        self.movieDetailView.directorTitleLabel.text = "감독"
        self.movieDetailView.directorDataLabel.text = self.reformString(labelText: "감독")
        self.movieDetailView.productYearTitleLabel.text = "제작년도"
        self.movieDetailView.productYearDataLabel.text = boxOfficeService.movieDetail?.movieInformationResult.movieInformation.productYear
       
        self.movieDetailView.openDayTitleLabel.text = "개봉일"
        self.movieDetailView.openDayDataLabel.text =
        boxOfficeService.movieDetail?.movieInformationResult.movieInformation.openDate.insertDash()
        
        self.movieDetailView.showTimeTitleLabel.text = "상영시간"
        self.movieDetailView.showTimeDataLabel.text = boxOfficeService.movieDetail?.movieInformationResult.movieInformation.showTime
        
        self.movieDetailView.auditsTitleLabel.text = "관람등급"
        self.movieDetailView.auditsDataLabel.text = self.reformString(labelText: "관람등급")
        
        self.movieDetailView.nationTitleLabel.text = "제작국가"
        self.movieDetailView.nationDataLabel.text = self.reformString(labelText: "제작국가")
        
        self.movieDetailView.genreTitleLabel.text = "장르"
        self.movieDetailView.genreDataLabel.text = self.reformString(labelText: "장르")
        
        self.movieDetailView.actorTitleLabel.text = "배우"
        self.movieDetailView.actorDataLabel.text = self.reformString(labelText: "배우")
    }

    private func reformString(labelText: String) -> String {

        switch labelText {
        case "감독":
            return boxOfficeService.movieDetail?.movieInformationResult.movieInformation.directors.map{$0.peopleName}.joined(separator: ", ") ?? ""
        case "관람등급":
            return boxOfficeService.movieDetail?.movieInformationResult.movieInformation.audits.map{$0.watchGradeName}.joined(separator: ", ") ?? ""
        case "제작국가":
            return boxOfficeService.movieDetail?.movieInformationResult.movieInformation.nations.map{$0.nationName}.joined(separator: ", ") ?? ""
        case "장르":
            return boxOfficeService.movieDetail?.movieInformationResult.movieInformation.genres.map{$0.genreName}.joined(separator: ", ") ?? ""
        case "배우":
            return boxOfficeService.movieDetail?.movieInformationResult.movieInformation.actors.map{$0.peopleName}.joined(separator: ", ") ?? ""
        default:
            return ""
        }
    }
    
    private func fetchImage() {
        imageSearchService.fetchSearchedImage(boxOfficeService: boxOfficeService) { data in
            DispatchQueue.main.async {
                self.movieDetailView.imageView.image = UIImage(data: data)
            }
        }
    }
}
