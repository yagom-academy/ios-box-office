//
//  MovieDetailViewController.swift
//  BoxOffice
//
//  Created by goat, songjun on 2023/03/30.
//

import UIKit

class MovieDetailViewController: UIViewController {
    
    private var movieDetailView = MovieDetailView()
    private var movieDetail: MovieDetail?
    private var searchedImage: ImageSearch?
    private var provider = Provider()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = movieDetailView
    }
    
    func fetchMoiveDetailAPI(movieCode: String) {
        var movieDetailEndpoint = MovieDetailEndpoint()
        movieDetailEndpoint.queryItems.append(URLQueryItem(name: QueryItem.movieDetailKey, value: movieCode))
        
        provider.loadBoxOfficeAPI(endpoint: movieDetailEndpoint,
                                  parser: Parser<MovieDetail>()) { parsedData in
            self.movieDetail = parsedData
            self.fetchImage()
            
            DispatchQueue.main.async {
                self.movieDetailView.directorTitleLabel.text = "감독"
                self.movieDetailView.directorDataLabel.text = self.reformDirectorString()
                self.movieDetailView.productYearTitleLabel.text = "제작년도"
                self.movieDetailView.productYearDataLabel.text = self.movieDetail?.movieInformationResult.movieInformation.productYear
               
                self.movieDetailView.openDayTitleLabel.text = "개봉일"
                self.movieDetailView.openDayDataLabel.text =
                self.movieDetail?.movieInformationResult.movieInformation.openDate
                
                self.movieDetailView.showTimeTitleLabel.text = "상영시간"
                self.movieDetailView.showTimeDataLabel.text = self.movieDetail?.movieInformationResult.movieInformation.showTime
                
                self.movieDetailView.auditsTitleLabel.text = "관람등급"
                self.movieDetailView.auditsDataLabel.text = self.reformAuditString()
                
                self.movieDetailView.nationTitleLabel.text = "제작국가"
                self.movieDetailView.nationDataLabel.text = self.reformNationString()
                
                self.movieDetailView.genreTitleLabel.text = "장르"
                self.movieDetailView.genreDataLabel.text = self.reformGenreString()
                
                self.movieDetailView.actorTitleLabel.text = "배우"
                self.movieDetailView.actorDataLabel.text = self.reformActorString()
            }
        }
    }

    private func reformDirectorString() -> String {
        var directorName: String = ""
        movieDetail?.movieInformationResult.movieInformation.directors.forEach{ directorName += $0.peopleName + ", " }
    
        return directorName.trimmingCharacters(in: [","," "])
    }
    
    private func reformAuditString() -> String {
        var audits: String = ""
        movieDetail?.movieInformationResult.movieInformation.audits.forEach{ audits += $0.watchGradeName + ", " }
    
        return audits.trimmingCharacters(in: [","," "])
    }
    
    private func reformNationString() -> String {
        var nations: String = ""
        movieDetail?.movieInformationResult.movieInformation.nations.forEach{ nations += $0.nationName + ", " }
    
        return nations.trimmingCharacters(in: [","," "])
    }
    
    private func reformGenreString() -> String {
        var genres: String = ""
        movieDetail?.movieInformationResult.movieInformation.genres.forEach{ genres += $0.genreName + ", " }
    
        return genres.trimmingCharacters(in: [","," "])
    }
    
    private func reformActorString() -> String {
        var actors: String = ""
        movieDetail?.movieInformationResult.movieInformation.actors.forEach{ actors += $0.peopleName + ", "}
    
        return actors.trimmingCharacters(in: [","," "])
    }
    
    private func fetchImage() {
        guard let movieName = self.movieDetail?.movieInformationResult.movieInformation.movieName else { return }

        var imageSearchEndpoint = ImageSearchEndpoint()
        imageSearchEndpoint.queryItems.append(URLQueryItem(name: QueryItem.searchImageKey, value: "\(movieName) 영화 포스터"))
        
        imageSearchEndpoint.header = ["Authorization" : "KakaoAK d74b0fb8fab7919ee21f04ca3f12ef75"]
        
        provider.loadBoxOfficeAPI(endpoint: imageSearchEndpoint, parser: Parser<ImageSearch>()) {
            parsedData in
            
            guard let url = URL(string: parsedData.documents[0].imageURL) else { return }
            guard let data = try? Data(contentsOf: url) else { return }

            DispatchQueue.main.async {
                self.movieDetailView.imageView.image = UIImage(data: data)
            }
        }
       
    }
}
