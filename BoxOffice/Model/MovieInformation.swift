//
//  MovieInformation.swift
//  BoxOffice
//
//  Created by kyungmin, Erick on 2023/08/05.
//

struct MovieInformation {
    let director: String
    let productionYear: String
    let openDate: String
    let showTime: String
    let watchGradeName: String
    let nationName: String
    let genreName: String
    let actors: String
}

extension MovieInformation {
    enum PropertyName {
        static let director = "감독"
        static let productionYear = "제작년도"
        static let openDate = "개봉일"
        static let showTime = "상영시간"
        static let watchGradeName = "관람등급"
        static let nationName = "제작국가"
        static let genreName = "장르"
        static let actors = "배우"
    }
}
