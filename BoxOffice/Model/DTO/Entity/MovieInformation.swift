//
//  MovieInformation.swift
//  BoxOffice
//
//  Created by kyungmin, Erick on 2023/08/05.
//

struct MovieInformation {
    let movieTitle: String
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
    enum PropertyName: String, CaseIterable {
        case movieTitle = "영화제목"
        case director = "감독"
        case productionYear = "제작년도"
        case openDate = "개봉일"
        case showTime = "상영시간"
        case watchGradeName = "관람등급"
        case nationName = "제작국가"
        case genreName = "장르"
        case actors = "배우"
    }
}
