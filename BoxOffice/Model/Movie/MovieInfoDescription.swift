//
//  MovieInfoDescription.swift
//  BoxOffice
//
//  Created by karen on 2023/08/06.
//

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
        let name: String
        let nameEnglish: String
        let cast: String
        let castEnglish: String
        
        private enum CodingKeys: String, CodingKey {
            case name = "peopleNm"
            case nameEnglish = "peopleNmEn"
            case cast
            case castEnglish = "castEn"
        }
    }
    
    struct Audits: Decodable {
        let number: String
        let watchGradeName: String
        
        private enum CodingKeys: String, CodingKey {
            case number = "auditNo"
            case watchGradeName = "watchGradeNm"
        }
    }
    
    struct Companys: Decodable {
        let code: String
        let name: String
        let englishName: String
        let partName: String
        
        private enum CodingKeys: String, CodingKey {
            case code = "companyCd"
            case name = "companyNm"
            case englishName = "companyNmEn"
            case partName = "companyPartNm"
        }
    }
    
    struct Directors: Decodable {
        let name: String
        let englishName: String
        
        private enum CodingKeys: String, CodingKey {
            case name = "peopleNm"
            case englishName = "peopleNmEn"
        }
    }
    
    struct Genres: Decodable {
        let name: String
        
        private enum CodingKeys: String, CodingKey {
            case name = "genreNm"
        }
    }
    
    struct Nations: Decodable {
        let name: String
        
        private enum CodingKeys: String, CodingKey {
            case name = "nationNm"
        }
    }
    
    struct ShowTypes: Decodable {
        let groupName: String
        let name: String
        
        private enum CodingKeys: String, CodingKey {
            case groupName = "showTypeGroupNm"
            case name = "showTypeNm"
        }
    }
    
    struct Staffs: Decodable {
        let name: String
        let englishName: String
        let staffRoleName: String
        
        private  enum CodingKeys: String, CodingKey {
            case name = "peopleNm"
            case englishName = "peopleNmEn"
            case staffRoleName = "staffRoleNm"
        }
    }
}
