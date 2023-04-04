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
        movieDetailEndpoint.insertMovieCodeQueryValue(movieCode: movieCode)
        
        provider.loadBoxOfficeAPI(endpoint: movieDetailEndpoint,
                                  parser: Parser<MovieDetail>()) { parsedData in
            self.movieDetail = parsedData
            self.fetchImage()
            
            DispatchQueue.main.async {
                self.movieDetailView.directorTitleLabel.text = "감독"
                self.movieDetailView.directorDataLabel.text = self.reformString(labelText: "감독")
                self.movieDetailView.productYearTitleLabel.text = "제작년도"
                self.movieDetailView.productYearDataLabel.text = self.movieDetail?.movieInformationResult.movieInformation.productYear
               
                self.movieDetailView.openDayTitleLabel.text = "개봉일"
                self.movieDetailView.openDayDataLabel.text =
                self.movieDetail?.movieInformationResult.movieInformation.openDate
                
                self.movieDetailView.showTimeTitleLabel.text = "상영시간"
                self.movieDetailView.showTimeDataLabel.text = self.movieDetail?.movieInformationResult.movieInformation.showTime
                
                self.movieDetailView.auditsTitleLabel.text = "관람등급"
                self.movieDetailView.auditsDataLabel.text = self.reformString(labelText: "관람등급")
                
                self.movieDetailView.nationTitleLabel.text = "제작국가"
                self.movieDetailView.nationDataLabel.text = self.reformString(labelText: "제작국가")
                
                self.movieDetailView.genreTitleLabel.text = "장르"
                self.movieDetailView.genreDataLabel.text = self.reformString(labelText: "장르")
                
                self.movieDetailView.actorTitleLabel.text = "배우"
                self.movieDetailView.actorDataLabel.text = self.reformString(labelText: "배우")
            }
        }
    }

    private func reformString(labelText: String) -> String {
        var result = ""
        
        switch labelText {
        case "감독":
            movieDetail?.movieInformationResult.movieInformation.directors.forEach{ result += $0.peopleName + ", " }
        case "관람등급":
            movieDetail?.movieInformationResult.movieInformation.audits.forEach{ result += $0.watchGradeName + ", " }
        case "제작국가":
            movieDetail?.movieInformationResult.movieInformation.nations.forEach{ result += $0.nationName + ", " }
        case "장르":
            movieDetail?.movieInformationResult.movieInformation.genres.forEach{ result += $0.genreName + ", " }
        case "배우":
            movieDetail?.movieInformationResult.movieInformation.actors.forEach{ result += $0.peopleName + ", "}
        default:
            return ""
        }
    
        result = result.trimmingCharacters(in: [","," "])
        
        return result
    }
    
    private func fetchImage() {
        guard let movieName = self.movieDetail?.movieInformationResult.movieInformation.movieName else { return }

        var imageSearchEndpoint = ImageSearchEndpoint()
        imageSearchEndpoint.insertImageQueryValue(imageName: movieName)
        
        imageSearchEndpoint.header = ["Authorization" : "KakaoAK d74b0fb8fab7919ee21f04ca3f12ef75"]
        
        provider.loadBoxOfficeAPI(endpoint: imageSearchEndpoint, parser: Parser<ImageSearch>()) {
            parsedData in
            
            guard let url = URL(string: parsedData.imageDatas[0].imageURL) else { return }
            guard let data = try? Data(contentsOf: url) else { return }

            DispatchQueue.main.async {
                self.movieDetailView.imageView.image = UIImage(data: data)
            }
        }
       
    }
}
