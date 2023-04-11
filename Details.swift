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
    var nations: [MovieInformation.MovieInformationResult.Movie.Nation]?
    var genres: [MovieInformation.MovieInformationResult.Movie.Genre]?
    var directors: [MovieInformation.MovieInformationResult.Movie.Director]?
    var actors: [MovieInformation.MovieInformationResult.Movie.Actor]?
    var showTypes: [MovieInformation.MovieInformationResult.Movie.ShowType]?
    var companys: [MovieInformation.MovieInformationResult.Movie.Company]?
    var audits: [MovieInformation.MovieInformationResult.Movie.Audit]?
    var staffs: [MovieInformation.MovieInformationResult.Movie.Staff]?

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
        self.nations = coder.decodeObject(forKey: "nations") as? [MovieInformation.MovieInformationResult.Movie.Nation]
        self.genres = coder.decodeObject(forKey: "genres") as? [MovieInformation.MovieInformationResult.Movie.Genre]
        self.directors = coder.decodeObject(forKey: "directors") as? [MovieInformation.MovieInformationResult.Movie.Director]
        self.actors = coder.decodeObject(forKey: "actors") as? [MovieInformation.MovieInformationResult.Movie.Actor]
        self.showTypes = coder.decodeObject(forKey: "showTypes") as? [MovieInformation.MovieInformationResult.Movie.ShowType]
        self.companys = coder.decodeObject(forKey: "companys") as? [MovieInformation.MovieInformationResult.Movie.Company]
        self.audits = coder.decodeObject(forKey: "audits") as? [MovieInformation.MovieInformationResult.Movie.Audit]
        self.staffs = coder.decodeObject(forKey: "staffs") as? [MovieInformation.MovieInformationResult.Movie.Staff]
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
        coder.encode(nations, forKey: "nations")
        coder.encode(genres, forKey: "genres")
        coder.encode(directors, forKey: "directors")
        coder.encode(actors, forKey: "actors")
        coder.encode(showTypes, forKey: "showTypes")
        coder.encode(companys, forKey: "companys")
        coder.encode(audits, forKey: "audits")
        coder.encode(staffs, forKey: "staffs")
    }
}

