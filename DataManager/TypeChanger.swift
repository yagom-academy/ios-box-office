//
//  TypeChanger.swift
//  BoxOffice
//
//  Created by 리지, kokkilE on 2023/04/13.
//

import Foundation
import CoreData

final class TypeChanger {
    
    func changeToEntity(_ movie: MovieInformation.MovieInformationResult.Movie) -> MovieDetails {
        let details = MovieDetails()
        
        details.movieCode = movie.movieCode
        details.movieKoreanName = movie.movieKoreanName
        details.movieEnglishName = movie.movieEnglishName
        details.movieOriginalName = movie.movieOriginalName
        details.showTime = movie.showTime
        details.productionYear = movie.productionYear
        details.openDate = movie.openDate
        details.productionStatus = movie.productionStatus
        details.typeName = movie.typeName

        for index in 0..<movie.nations.count {
            if details.nationsName == nil { details.nationsName = [String]() }
            
            details.nationsName?.append(movie.nations[index].name)
        }

        for index in 0..<movie.genres.count {
            if details.genresName == nil { details.genresName = [String]() }
            
            details.genresName?.append(movie.genres[index].name)
        }

        for index in 0..<movie.directors.count {
            if details.directorsName == nil { details.directorsName = [String]() }
            if details.directorsEnglishName == nil { details.directorsEnglishName = [String]() }
            
            details.directorsName?.append(movie.directors[index].name)
            details.directorsEnglishName?.append(movie.directors[index].englishName)
        }

        for index in 0..<movie.actors.count {
            if details.actorsName == nil { details.actorsName = [String]() }
            if details.actorsEnglishName == nil { details.actorsEnglishName = [String]() }
            if details.actorsCast == nil { details.actorsCast = [String]() }
            if details.actorsCastEnglish == nil { details.actorsCastEnglish = [String]() }
            
            details.actorsName?.append(movie.actors[index].name)
            details.actorsEnglishName?.append(movie.actors[index].englishName)
            details.actorsCast?.append(movie.actors[index].cast)
            details.actorsCastEnglish?.append(movie.actors[index].castEnglish)
        }

        for index in 0..<movie.showTypes.count {
            if details.showTypesGroupName == nil { details.showTypesGroupName = [String]() }
            if details.showTypesName == nil { details.showTypesName = [String]() }
            
            details.showTypesGroupName?.append(movie.showTypes[index].groupName)
            details.showTypesName?.append(movie.showTypes[index].name)
        }

        for index in 0..<movie.companys.count {
            if details.companysCode == nil { details.companysCode = [String]() }
            if details.companysName == nil { details.companysName = [String]() }
            if details.companysEnglishName == nil { details.companysEnglishName = [String]() }
            if details.companysPart == nil { details.companysPart = [String]() }
            
            details.companysCode?.append(movie.companys[index].code)
            details.companysName?.append(movie.companys[index].name)
            details.companysEnglishName?.append(movie.companys[index].englishName)
            details.companysPart?.append(movie.companys[index].part)
        }

        for index in 0..<movie.audits.count {
            if details.auditsNumber == nil { details.auditsNumber = [String]() }
            if details.auditsWatchGrade == nil { details.auditsWatchGrade = [String]() }
            
            details.auditsNumber?.append(movie.audits[index].number)
            details.auditsWatchGrade?.append(movie.audits[index].watchGrade)
        }

        for index in 0..<movie.staffs.count {
            if details.staffsName == nil { details.staffsName = [String]() }
            if details.staffEnglishName == nil { details.staffEnglishName = [String]() }
            if details.staffRoleName == nil { details.staffRoleName = [String]() }
            
            details.staffsName?.append(movie.staffs[index].name)
            details.staffEnglishName?.append(movie.staffs[index].englishName)
            details.staffRoleName?.append(movie.staffs[index].roleName)
        }
    
        return details
    }
    
    func changeToEntity(_ movies: [DailyBoxOffice.BoxOfficeResult.Movie]) -> Movies {
        var movieList = [Movie]()
        movies.forEach {
            let movie = Movie()
            
            movie.audienceAccumulation = $0.audienceAccumulation
            movie.screenCount = $0.screenCount
            movie.showCount = $0.showCount
            movie.rank = $0.rank
            movie.rankVariance = $0.rankVariance
            movie.rankOldAndNew = $0.rankOldAndNew
            movie.code = $0.code
            movie.name = $0.name
            movie.openDate = $0.openDate
            movie.salesAmount = $0.salesAmount
            movie.salesShare = $0.salesShare
            movie.salesVariance = $0.salesVariance
            movie.salesChange = $0.salesChange
            movie.salesAccumulation = $0.salesAccumulation
            movie.audienceCount = $0.audienceCount
            movie.audienceVariance = $0.audienceVariance
            movie.audienceChange = $0.audienceChange
            movie.order = $0.order
            
            movieList.append(movie)
        }
        
        let movieData = Movies(movieList: movieList)
        return movieData
    }
}
