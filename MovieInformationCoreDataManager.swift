//
//  MovieInformationCoreDataManager.swift
//  BoxOffice
//
//  Created by 리지, kokkilE on 2023/04/11.
//

import Foundation
import CoreData
import UIKit

class MovieInformationCoreDataManager: DataManager {
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
    
    private func setValue(at target: MovieInformationData, code: String, and movies: [Any]) {
        guard let movies = movies as? [MovieInformation.MovieInformationResult.Movie],
              let movie = movies.first else { return }
        
        var details = Details()
        details.movieCode = movie.movieCode
        details.movieKoreanName = movie.movieKoreanName
        details.movieEnglishName = movie.movieEnglishName
        details.movieOriginalName = movie.movieOriginalName
        details.showTime = movie.showTime
        details.productionYear = movie.productionYear
        details.openDate = movie.openDate
        details.productionStatus = movie.productionStatus
        details.typeName = movie.typeName
        details.nations = movie.nations
    
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
