//
//  MovieInfoDescription.swift
//  BoxOffice
//
//  Created by karen on 2023/08/06.
//

import Foundation

struct MovieInfoDescription: Decodable {
    let movieCode: String
    let movieName: String
    let movieNameEnglish: String
    let movieNameOriginal: String
    let showTime: String
    let productionYear: String
    let releaseDate: String
    let productionStateName: String
    let typeName: String
    let nations: [Nations]
    let genres: [Genres]
    let directors: [Directors]
    let actors: [Actors]
    let showTypes: [ShowTypes]
    let companys: [Companys]
    let audits: [Audits]
    let staffs: [Staffs]
    
    private enum CodingKeys: String, CodingKey {
        case movieCode = "movieCd"
        case movieName = "movieNm"
        case movieNameEnglish = "movieNmEn"
        case movieNameOriginal = "movieNmOg"
        case showTime = "showTm"
        case productionYear = "prdtYear"
        case releaseDate = "openDt"
        case productionStateName = "prdtStatNm"
        case typeName = "typeNm"
        case nations, genres, directors, actors, showTypes, companys, audits, staffs
    }
    
    struct Actors: Decodable {
        let peopleName: String
        let peopleNameEnglish: String
        let cast: String
        let castEnglish: String
        
        private enum CodingKeys: String, CodingKey {
            case peopleName = "peopleNm"
            case peopleNameEnglish = "peopleNmEn"
            case cast
            case castEnglish = "castEn"
        }
    }
    
    struct Audits: Decodable {
        let auditNumber: String
        let watchGradeName: String
        
        private enum CodingKeys: String, CodingKey {
            case auditNumber = "auditNo"
            case watchGradeName = "watchGradeNm"
        }
    }
    
    struct Companys: Decodable {
        let companyCode: String
        let companyName: String
        let companyEnglishName: String
        let companyPartName: String
        
        private enum CodingKeys: String, CodingKey {
            case companyCode = "companyCd"
            case companyName = "companyNm"
            case companyEnglishName = "companyNmEn"
            case companyPartName = "companyPartNm"
        }
    }
    
    struct Directors: Decodable {
        let peopleName: String
        let peopleEnglishName: String
        
        private enum CodingKeys: String, CodingKey {
            case peopleName = "peopleNm"
            case peopleEnglishName = "peopleNmEn"
        }
    }
    
    struct Genres: Decodable {
        let genreName: String
        
        private enum CodingKeys: String, CodingKey {
            case genreName = "genreNm"
        }
    }
    
    struct Nations: Decodable {
        let nationName: String
        
        private enum CodingKeys: String, CodingKey {
            case nationName = "nationNm"
        }
    }
    
    struct ShowTypes: Decodable {
        let showTypeGroupName: String
        let showTypeName: String
        
        private enum CodingKeys: String, CodingKey {
            case showTypeGroupName = "showTypeGroupNm"
            case showTypeName = "showTypeNm"
        }
    }
    
    struct Staffs: Decodable {
        let peopleName: String
        let peopleEnglishName: String
        let staffRoleName: String
        
        private  enum CodingKeys: String, CodingKey {
            case peopleName = "peopleNm"
            case peopleEnglishName = "peopleNmEn"
            case staffRoleName = "staffRoleNm"
        }
    }
}
