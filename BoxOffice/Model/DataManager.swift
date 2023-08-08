//
//  DataManager.swift
//  BoxOffice
//
//  Created by kyungmin, Erick on 2023/08/02.
//

import Foundation

enum DataManager {
    static func boxOfficeTransferDailyBoxOffice(boxOffice: BoxOffice) -> [DailyBoxOffice] {
        return boxOffice.boxOfficeResult.dailyBoxOfficeList.map {
            let decimalAudienceCount = NumberFormatter().decimalString($0.audienceCount)
            let decimalaudienceAccumulation = NumberFormatter().decimalString($0.audienceAccumulation)
            let dailyAndTotalAudience = String(format: NameSpace.dailyAndTotalAudience, decimalAudienceCount, decimalaudienceAccumulation)
            
            var rankState = NameSpace.empty
            var rankStateColor: RankStateColor
            
            if $0.rankOldAndNew == NameSpace.new {
                rankState = NameSpace.newMovie
                rankStateColor = (NameSpace.newMovie, .systemRed)
            } else if $0.rankIntensity == NameSpace.zero {
                rankState = NameSpace.minus
                rankStateColor = (NameSpace.minus, .black)
            } else if $0.rankIntensity.contains(NameSpace.minus) {
                rankState = $0.rankIntensity.replacingOccurrences(of: NameSpace.minus, with: NameSpace.downTriangle)
                rankStateColor = (NameSpace.downTriangle, .systemBlue)
            } else {
                rankState = NameSpace.upTriangle + $0.rankIntensity
                rankStateColor = (NameSpace.upTriangle, .systemRed)
            }
            
            return DailyBoxOffice(movieCode: $0.movieCode, rank: $0.rank, rankState: rankState, movieTitle: $0.movieName, dailyAndTotalAudience: dailyAndTotalAudience, rankStateColor: rankStateColor)
        }
    }
    
    static func movieTransferMoiveInformation(movie: Movie) -> MovieInformation {
        let movieTitle = movie.movieInfoResult.movieInfo.movieName
        let director = movie.movieInfoResult.movieInfo.directors.reduce(NameSpace.empty) {
            $0 == NameSpace.empty ? $0 + $1.peopleName : String(format: NameSpace.commaFormat, $0, $1.peopleName)
        }
        let productionYear = movie.movieInfoResult.movieInfo.productionYear
        let openDate = DateFormatter().dateString(from: movie.movieInfoResult.movieInfo.openDate, with: DateFormatter.FormatCase.hyphen)
        let showTime = movie.movieInfoResult.movieInfo.showTime
        let watchGradeName = movie.movieInfoResult.movieInfo.audits.reduce(NameSpace.empty) {
            $0 == NameSpace.empty ? $0 + $1.watchGradeName : String(format: NameSpace.commaFormat, $0, $1.watchGradeName)
        }
        let nationName = movie.movieInfoResult.movieInfo.nations.reduce(NameSpace.empty) {
            $0 == NameSpace.empty ? $0 + $1.nationName : String(format: NameSpace.commaFormat, $0, $1.nationName)
        }
        let genreName = movie.movieInfoResult.movieInfo.genres.reduce(NameSpace.empty) {
            $0 == NameSpace.empty ? $0 + $1.genreName : String(format: NameSpace.commaFormat, $0, $1.genreName)
        }
        let actors = movie.movieInfoResult.movieInfo.actors.reduce(NameSpace.empty) {
            $0 == NameSpace.empty ? $0 + $1.peopleName : String(format: NameSpace.commaFormat, $0, $1.peopleName)
        }
        
        return MovieInformation(movieTitle: movieTitle, director: director, productionYear: productionYear, openDate: openDate, showTime: showTime, watchGradeName: watchGradeName, nationName: nationName, genreName: genreName, actors: actors)
    }
}

extension DataManager {
    private enum NameSpace {
        static let dailyAndTotalAudience = "오늘 %@ / 총 %@"
        static let empty = ""
        static let new = "NEW"
        static let old = "OLD"
        static let newMovie = "신작"
        static let zero = "0"
        static let minus = "-"
        static let upTriangle = "▲"
        static let downTriangle = "▼"
        static let commaFormat = "%@, %@"
    }
}
