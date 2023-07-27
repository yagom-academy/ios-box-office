//
//  MovieDetailInformation.swift
//  BoxOffice
//
//  Created by Zion, Hemg on 2023/07/27.
//

protocol People {
    var peopleName: String { get }
    var peopleNameEnglish: String { get }
}

struct MovieDetailResult: Decodable {
    let movieInformationResult: MovieDetailInformation
    
    private enum CodingKeys: String, CodingKey {
        case movieInformationResult = "movieInfoResult"
    }
    
    struct MovieDetailInformation: Decodable {
        let movieInformation: MovieDetail
        let source: String
        
        private enum CodingKeys: String, CodingKey {
            case movieInformation = "movieInfo"
            case source
        }
        
        struct MovieDetail: Decodable {
            let movieCode: String
            let movieName: String
            let movieNameEnglish: String
            let movieNameOriginal: String
            let showTime: String
            let productYear: String
            let openDate: String
            let productStatusName: String
            let typeName: String
            let nations: [Nation]
            let genres: [Genre]
            let directors: [Director]
            let actors: [Actor]
            let showTypes: [ShowType]
            let companys: [Company]
            let audits: [Audit]
            let staffs: [Staff]
            
            private enum CodingKeys: String, CodingKey {
                case movieCode = "movieCd"
                case movieName = "movieNm"
                case movieNameEnglish = "movieNmEn"
                case movieNameOriginal = "movieNmOg"
                case showTime = "showTm"
                case productYear = "prdtYear"
                case openDate = "openDt"
                case productStatusName = "prdtStatNm"
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
                let nationName: String
                
                
                private enum CodingKeys: String, CodingKey {
                    case nationName = "nationNm"
                }
            }
            
            struct Genre: Decodable {
                let genreName: String
                
                private enum CodingKeys: String, CodingKey {
                    case genreName = "genreNm"
                }
            }
            
            struct Director: People, Decodable {
                let peopleName: String
                let peopleNameEnglish: String
                
                private enum CodingKeys: String, CodingKey {
                    case peopleName = "peopleNm"
                    case peopleNameEnglish = "peopleNmEn"
                }
            }
            
            struct Actor: People, Decodable {
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
            
            struct Staff: People, Decodable {
                let peopleName: String
                let peopleNameEnglish: String
                let staffRoleName: String
                
                private enum CodingKeys: String, CodingKey {
                    case peopleName = "peopleNm"
                    case peopleNameEnglish = "peopleNmEn"
                    case staffRoleName = "staffRoleNm"
                }
            }
            
            struct ShowType: Decodable {
                let showTypeGroupName: String
                let showTypeName: String
                
                private enum CodingKeys: String, CodingKey {
                    case showTypeGroupName = "showTypeGroupNm"
                    case showTypeName = "showTypeNm"
                }
            }
            
            struct Company: Decodable {
                let companyCode: String
                let companyName: String
                let companyNameEnglish: String
                let companyPartName: String
                
                private enum CodingKeys: String, CodingKey {
                    case companyCode = "companyCd"
                    case companyName = "companyNm"
                    case companyNameEnglish = "companyNmEn"
                    case companyPartName = "companyPartNm"
                }
            }
            
            struct Audit: Decodable {
                let auditNo: String
                let watchGradeName: String
                
                private enum CodingKeys: String, CodingKey {
                    case auditNo
                    case watchGradeName = "watchGradeNm"
                }
            }
        }
    }
}
