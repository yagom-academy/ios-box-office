//
//  MovieInformationCoreDataManager.swift
//  BoxOffice
//
//  Created by 리지, kokkilE on 2023/04/11.
//

import Foundation
import CoreData
import UIKit

final class MovieInformationCoreDataManager: DataManager {
    static let shared = MovieInformationCoreDataManager()
    private let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.newBackgroundContext()
    
    private init() {}
    
    func create(key: String, value: [Any]) {
        guard let context = self.context,
              let movieInformationEntity = NSEntityDescription.entity(forEntityName: "MovieInformationData", in: context),
              let movieInformationData = NSManagedObject(entity: movieInformationEntity, insertInto: context) as? MovieInformationData else { return }
        
        setValue(at: movieInformationData, code: key , and: value)
        save()
    }
    
    func read(key: String) -> Any? {
        fetchData(movieCode: key)
    }
    
    func update(key: String, value: [Any]) {
        guard let movieInformationData = fetchData(movieCode: key) else { return }
        
        setValue(at: movieInformationData, code: key, and: value)
        save()
    }
    
    func delete() {
        guard let context = self.context else { return }
        
        let request: NSFetchRequest<NSFetchRequestResult> = MovieInformationData.fetchRequest()
        let delete = NSBatchDeleteRequest(fetchRequest: request)
        do {
            try context.execute(delete)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func deleteByTimeInterval() {
        guard let context = self.context else { return }
        
        let request: NSFetchRequest<NSFetchRequestResult> = MovieInformationData.fetchRequest()
        let olderThanDate = Date().addingTimeInterval(-1 * 24 * 60 * 60)
        request.predicate = NSPredicate(format: "createdAt < %@", argumentArray: [olderThanDate])
        
        let delete = NSBatchDeleteRequest(fetchRequest: request)
        do {
            try context.execute(delete)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    private func setValue(at target: MovieInformationData, code: String, and movies: [Any]) {
        guard let movies = movies as? [MovieInformation.MovieInformationResult.Movie],
              let movie = movies.first else { return }
        
        let details = Details()
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
        
        target.setValue(Date.now, forKey: "createdAt")
        target.setValue(code, forKey: "movieCode")
        target.setValue(details, forKey: "details")
    }
    
    private func save() {
        guard let context = self.context else { return }
        
        do {
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    private func filteredDataRequest(movieCode: String) -> NSFetchRequest<MovieInformationData> {
        let fetchRequest = NSFetchRequest<MovieInformationData>(entityName: "MovieInformationData")
        fetchRequest.predicate = NSPredicate(format: "movieCode == %@", movieCode)
        return fetchRequest
    }
    
    private func fetchData(movieCode: String) -> MovieInformationData? {
        guard let context = self.context else { return nil }
        
        let filter = filteredDataRequest(movieCode: movieCode)
        
        do {
            let data = try context.fetch(filter)
            return data.first
        } catch {
            return nil
        }
    }
}
