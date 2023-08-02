//
//  Company.swift
//  BoxOffice
//
//  Created by Zion, Hemg on 2023/07/31.
//

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
