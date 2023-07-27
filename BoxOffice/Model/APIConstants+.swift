//
//  APIConstants+.swift
//  BoxOffice
//
//  Created by Idinaloq, MARY on 2023/07/27.
//

extension APIConstants {
    enum QueryItem {
        static let targetDate: String = "targetDt"
        static let itemPerPage: String = "itemPerPage"
        static let multiMovie: String = "multiMovieYn"
        static let nationCode: String = "repNationCd"
        static let widewAreaCode: String = "wideAreaCd"
        static let movieCode: String = "movieCd"
        static let key: String = "key"
        static let value: String = "c824c74a1ff9ed62089a9a0bcc0d3211"
    }

    enum Components {
        static let scheme: String = "http"
        static let host: String = "www.kobis.or.kr"
        static let path: String = "/kobisopenapi/webservice/rest"
    }
}
