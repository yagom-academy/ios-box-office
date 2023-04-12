//
//  Details.swift
//  BoxOffice
//
//  Created by 리지, kokkilE on 2023/04/11.
//

import Foundation

final class Details: NSObject {
    var movieCode: String?
    var movieKoreanName: String?
    var movieEnglishName: String?
    var movieOriginalName: String?
    var showTime: String?
    var productionYear: String?
    var openDate: String?
    var productionStatus: String?
    var typeName: String?
    var nationsName: [String]?
    var genresName: [String]?
    var directorsName: [String]?
    var directorsEnglishName: [String]?
    var actorsName: [String]?
    var actorsEnglishName: [String]?
    var actorsCast: [String]?
    var actorsCastEnglish: [String]?
    var showTypesGroupName: [String]?
    var showTypesName: [String]?
    var companysCode: [String]?
    var companysName: [String]?
    var companysEnglishName: [String]?
    var companysPart: [String]?
    var auditsNumber: [String]?
    var auditsWatchGrade: [String]?
    var staffsName: [String]?
    var staffEnglishName: [String]?
    var staffRoleName: [String]?
    
    required convenience init?(coder: NSCoder) {
        self.init()
        
        self.movieCode = coder.decodeObject(forKey: "movieCode") as? String
        self.movieKoreanName = coder.decodeObject(forKey: "movieKoreanName") as? String
        self.movieEnglishName = coder.decodeObject(forKey: "movieEnglishName") as? String
        self.movieOriginalName = coder.decodeObject(forKey: "movieOriginalName") as? String
        self.showTime = coder.decodeObject(forKey: "showTime") as? String
        self.productionYear = coder.decodeObject(forKey: "productionYear") as? String
        self.openDate = coder.decodeObject(forKey: "openDate") as? String
        self.productionStatus = coder.decodeObject(forKey: "productionStatus") as? String
        self.typeName = coder.decodeObject(forKey: "typeName") as? String
        self.nationsName = coder.decodeObject(of: [NSArray.self, NSString.self], forKey: "nationsName") as? [String]
        self.genresName = coder.decodeObject(of: [NSArray.self, NSString.self], forKey: "genresName") as? [String]
        self.directorsName = coder.decodeObject(of: [NSArray.self, NSString.self], forKey: "directorsName") as? [String]
        self.directorsEnglishName = coder.decodeObject(of: [NSArray.self, NSString.self], forKey: "directorsEnglishName") as? [String]
        self.actorsName = coder.decodeObject(of: [NSArray.self, NSString.self], forKey: "actorsName") as? [String]
        self.actorsEnglishName = coder.decodeObject(of: [NSArray.self, NSString.self], forKey: "actorsEnglishName") as? [String]
        self.actorsCast = coder.decodeObject(of: [NSArray.self, NSString.self], forKey: "actorsCast") as? [String]
        self.actorsCastEnglish = coder.decodeObject(of: [NSArray.self, NSString.self], forKey: "actorsCastEnglish") as? [String]
        self.showTypesGroupName = coder.decodeObject(of: [NSArray.self, NSString.self], forKey: "showTypesGroupName") as? [String]
        self.showTypesName = coder.decodeObject(of: [NSArray.self, NSString.self], forKey: "showTypesName") as? [String]
        self.companysCode = coder.decodeObject(of: [NSArray.self, NSString.self], forKey: "companysCode") as? [String]
        self.companysName = coder.decodeObject(of: [NSArray.self, NSString.self], forKey: "companysName") as? [String]
        self.companysEnglishName = coder.decodeObject(of: [NSArray.self, NSString.self], forKey: "companysEnglishName") as? [String]
        self.companysPart = coder.decodeObject(of: [NSArray.self, NSString.self], forKey: "companysPart") as? [String]
        self.auditsNumber = coder.decodeObject(of: [NSArray.self, NSString.self], forKey: "auditsNumber") as? [String]
        self.auditsWatchGrade = coder.decodeObject(of: [NSArray.self, NSString.self], forKey: "auditsWatchGrade") as? [String]
        self.staffsName = coder.decodeObject(of: [NSArray.self, NSString.self], forKey: "staffsName") as? [String]
        self.staffEnglishName = coder.decodeObject(of: [NSArray.self, NSString.self], forKey: "staffEnglishName") as? [String]
        self.staffRoleName = coder.decodeObject(of: [NSArray.self, NSString.self], forKey: "staffRoleName") as? [String]
    }
}

extension Details: NSSecureCoding {
    static var supportsSecureCoding: Bool {
        return true
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(movieCode, forKey: "movieCode")
        coder.encode(movieKoreanName, forKey: "movieKoreanName")
        coder.encode(movieEnglishName, forKey: "movieEnglishName")
        coder.encode(movieOriginalName, forKey: "movieOriginalName")
        coder.encode(showTime, forKey: "showTime")
        coder.encode(productionYear, forKey: "productionYear")
        coder.encode(openDate, forKey: "openDate")
        coder.encode(productionStatus, forKey: "productionStatus")
        coder.encode(typeName, forKey: "typeName")
        coder.encode(nationsName, forKey: "nationsName")
        coder.encode(genresName, forKey: "genresName")
        coder.encode(directorsName, forKey: "directorsName")
        coder.encode(directorsEnglishName, forKey: "directorsEnglishName")
        coder.encode(actorsName, forKey: "actorsName")
        coder.encode(actorsEnglishName, forKey: "actorsEnglishName")
        coder.encode(actorsCast, forKey: "actorsCast")
        coder.encode(actorsCastEnglish, forKey: "actorsCastEnglish")
        coder.encode(showTypesGroupName, forKey: "showTypesGroupName")
        coder.encode(showTypesName, forKey: "showTypesName")
        coder.encode(companysCode, forKey: "companysCode")
        coder.encode(companysName, forKey: "companysName")
        coder.encode(companysEnglishName, forKey: "companysEnglishName")
        coder.encode(companysPart, forKey: "companysPart")
        coder.encode(auditsNumber, forKey: "auditsNumber")
        coder.encode(auditsWatchGrade, forKey: "auditsWatchGrade")
        coder.encode(staffsName, forKey: "staffsName")
        coder.encode(staffEnglishName, forKey: "staffEnglishName")
        coder.encode(staffRoleName, forKey: "staffRoleName")
    }
}
