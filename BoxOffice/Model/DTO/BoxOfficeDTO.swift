//
//  BoxOfficeDTO.swift
//  BoxOffice
//
//  Created by vetto, brody on 23/03/20.
//

struct BoxOfficeDTO: Decodable {
    private let boxOfficeResult: BoxOfficeResult
    
    private struct BoxOfficeResult: Decodable {
        private let boxOfficeType: String
        private let showingDuration: String
        let dailyBoxOfficeList: [DailyBoxOffice]
        
        private enum CodingKeys: String, CodingKey {
            case boxOfficeType = "boxofficeType"
            case showingDuration = "showRange"
            case dailyBoxOfficeList
        }
    }
}

extension BoxOfficeDTO {
    func convertToBoxOfficeItems() -> [BoxOfficeItem] {
        return boxOfficeResult.dailyBoxOfficeList.map { movie in
            return BoxOfficeItem(code: movie.movieCode,
                                 rank: movie.rank,
                                 rankIncrement: movie.rankIncrement,
                                 rankOldAndNew: movie.rankOldAndNew,
                                 title: movie.movieName,
                                 audienceCount: movie.audienceCount,
                                 audienceAccumulationCount: movie.audienceAccumulation)
        }
    }
}
