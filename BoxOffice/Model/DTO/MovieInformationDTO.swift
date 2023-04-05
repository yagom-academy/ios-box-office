//
//  MovieInformationDTO.swift
//  BoxOffice
//
//  Created by vetto, brody on 23/03/21.
//

struct MovieInformationDTO: Decodable {
    private let movieInfoResult: MovieInformationResult
    
    private struct MovieInformationResult: Decodable {
        let movieDetailInformation: MovieDetailInformation
        let source: String
        
        private enum CodingKeys: String, CodingKey {
            case movieDetailInformation = "movieInfo"
            case source
        }
    }
}

extension MovieInformationDTO {
    func convertToMovieDetailInformationItem() -> MovieDetailInformationItem {
        return MovieDetailInformationItem(productYear: movieInfoResult.movieDetailInformation.productYear,
                                          directors: movieInfoResult.movieDetailInformation.directors,
                                          openDate: movieInfoResult.movieDetailInformation.openDate,
                                          showingTime: movieInfoResult.movieDetailInformation.showingTime,
                                          audits: movieInfoResult.movieDetailInformation.audits,
                                          nations: movieInfoResult.movieDetailInformation.nations,
                                          genres: movieInfoResult.movieDetailInformation.genres,
                                          actors: movieInfoResult.movieDetailInformation.actors)
    }
}
