//
//  MovieInformation.swift
//  BoxOffice
//
//  Created by 리지, kokkilE on 2023/03/21.
//

import UIKit

struct MovieInformation: Decodable {
    let movieInformationResult: MovieInformationResult

    enum CodingKeys: String, CodingKey {
        case movieInformationResult = "movieInfoResult"
    }
    
    struct MovieInformationResult: Decodable {
        let movie: Movie
        let source: String

        enum CodingKeys: String, CodingKey {
            case movie = "movieInfo"
            case source
        }
        
        struct Movie: Decodable {
            let movieCode: String
            let movieKoreanName: String
            let movieEnglishName: String
            let movieOriginalName: String
            let showTime: String
            let productionYear: String
            let openDate: String
            let productionStatus: String
            let typeName: String
            let nations: [Nation]
            let genres: [Genre]
            let directors: [Director]
            let actors: [Actor]
            let showTypes: [ShowType]
            let companys: [Company]
            let audits: [Audit]
            let staffs: [Staff]

            enum CodingKeys: String, CodingKey {
                case movieCode = "movieCd"
                case movieKoreanName = "movieNm"
                case movieEnglishName = "movieNmEn"
                case movieOriginalName = "movieNmOg"
                case showTime = "showTm"
                case productionYear = "prdtYear"
                case openDate = "openDt"
                case productionStatus = "prdtStatNm"
                case typeName = "typeNm"
                case nations
                case genres
                case directors
                case actors
                case showTypes
                case companys
                case audits
                case staffs
            }
            
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
                let cast: String
                let castEnglish: String

                enum CodingKeys: String, CodingKey {
                    case cast
                    case name = "peopleNm"
                    case englishName = "peopleNmEn"
                    case castEnglish = "castEn"
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
                let part: String

                enum CodingKeys: String, CodingKey {
                    case code = "companyCd"
                    case name = "companyNm"
                    case englishName = "companyNmEn"
                    case part = "companyPartNm"
                }
            }

            struct Audit: Decodable {
                let number: String
                let watchGrade: String

                enum CodingKeys: String, CodingKey {
                    case number = "auditNo"
                    case watchGrade = "watchGradeNm"
                }
            }

            struct Staff: Decodable {
                let name: String
                let englishName: String
                let roleName: String

                enum CodingKeys: String, CodingKey {
                    case name = "peopleNm"
                    case englishName = "peopleNmEn"
                    case roleName = "staffRoleNm"
                }
            }
        }
    }
}


