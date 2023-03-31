//
//  MovieInformationDTO.swift
//  BoxOffice
//
//  Created by vetto, brody on 23/03/21.
//

struct MovieInformationDTO: Decodable {
    let movieInfoResult: MovieInformationResult
    
    struct MovieInformationResult: Decodable {
        let movieInformation: MovieDetailInformation
        let source: String
        
        enum CodingKeys: String, CodingKey {
            case movieInformation = "movieInfo"
            case source
        }
    }
}

extension MovieInformationDTO {
    func toDomain() -> MovieDetailInformationItem {
        return MovieDetailInformationItem(productYear: movieInfoResult.movieInformation.productYear,
                                          directors: movieInfoResult.movieInformation.directors,
                                          openDate: movieInfoResult.movieInformation.openDate,
                                          showingTime: movieInfoResult.movieInformation.showingTime,
                                          audits: movieInfoResult.movieInformation.audits,
                                          nations: movieInfoResult.movieInformation.nations,
                                          genres: movieInfoResult.movieInformation.genres,
                                          actors: movieInfoResult.movieInformation.actors)
    }
}
