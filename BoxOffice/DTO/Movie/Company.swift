//
//  Company.swift
//  BoxOffice
//
//  Created by Serena, BMO on 2023/07/28.
//

struct Company: Decodable {
    let companyCode: String         // 참여 영화사 코드
    let companyName: String         // 참여 영화사 이름
    let companyEnglishName: String  // 참여 영화사 영문 이름
    let companyPartName: String     // 참여 영화사 분야 이름
    
    private enum CodingKeys: String, CodingKey {
        case companyCode = "companyCd"
        case companyName = "companyNm"
        case companyEnglishName = "companyNmEn"
        case companyPartName = "companyPartNm"
    }
}
