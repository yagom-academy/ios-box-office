//
//  MovieDetailEntity.swift
//  BoxOffice
//
//  Created by Yetti, Maxhyunm on 2023/07/26.
//

struct MovieDetailEntity: Decodable {
    struct MovieInformationResult: Decodable {
        struct MovieInformation: Decodable {
            struct Nation: Decodable {
                let name: String
                
                enum CodingKeys: String, CodingKey {
                    case name = "nationNm"
                }
            }
            
            struct Genre: Decodable {
                let name: String
                
                enum CodingKeys: String, CodingKey {
                    case name = "genreNm"
                }
            }
            
            struct Director: Decodable {
                let name: String
                let englishName: String
                
                enum CodingKeys: String, CodingKey {
                    case name = "peopleNm"
                    case englishName = "peopleNmEn"
                }
            }
            
            struct Actor: Decodable {
                let name: String
                let englishName: String
                let castName: String
                let englishCastName: String
                
                enum CodingKeys: String, CodingKey {
                    case name = "peopleNm"
                    case englishName = "peopleNmEn"
                    case castName = "cast"
                    case englishCastName = "castEn"
                }
            }
            
            struct ShowType: Decodable {
                let groupName: String
                let name: String
                
                enum CodingKeys: String, CodingKey {
                    case groupName = "showTypeGroupNm"
                    case name = "showTypeNm"
                }
            }
            
            struct Company: Decodable {
                let code: String
                let name: String
                let englishName: String
                let role: String
                
                enum CodingKeys: String, CodingKey {
                    case code = "companyCd"
                    case name = "companyNm"
                    case englishName = "companyNmEn"
                    case role = "companyPartNm"
                }
            }
            
            struct Audit: Decodable {
                let auditNumber: String
                let movieRating: String
                
                enum CodingKeys: String, CodingKey {
                    case auditNumber = "auditNo"
                    case movieRating = "watchGradeNm"
                }
            }
            
            struct Staff: Decodable {
                let name: String
                let englishName: String
                let role: String
                
                enum CodingKeys: String, CodingKey {
                    case name = "peopleNm"
                    case englishName = "peopleNmEn"
                    case role = "staffRoleNm"
                }
            }
            
            let movieCode: String
            let movieName: String
            let englishMovieName: String
            let originalMovieName: String
            let showTime: String
            let productionYear: String
            let openingDate: String
            let productionStatusName: String
            let typeName: String
            let nations: [Nation]
            let genres: [Genre]
            let directors: [Director]
            let actors: [Actor]
            let showTypes: [ShowType]
            let companies: [Company]
            let audits: [Audit]
            let staffs: [Staff]
            
            enum CodingKeys: String, CodingKey {
                case nations, genres, directors, actors, showTypes, audits, staffs
                
                case movieCode = "movieCd"
                case movieName = "movieNm"
                case englishMovieName = "movieNmEn"
                case originalMovieName = "movieNmOg"
                case showTime = "showTm"
                case productionYear = "prdtYear"
                case openingDate = "openDt"
                case productionStatusName = "prdtStatNm"
                case typeName = "typeNm"
                case companies = "companys"
            }
        }
        
        let movieInformation: MovieInformation
        let source: String
        
        enum CodingKeys: String, CodingKey {
            case source
            case movieInformation = "movieInfo"
        }
    }
    
    let movieInformationResult: MovieInformationResult
    
    enum CodingKeys: String, CodingKey {
        case movieInformationResult = "movieInfoResult"
    }
}
