//
//  BoxOfficeCoreDataManager.swift
//  BoxOffice
//
//  Created by 리지, kokkilE on 2023/04/10.
//

import Foundation
import CoreData

class BoxOfficeCoreDataManager {
    private init() { }
    
    static let shared: BoxOfficeCoreDataManager = BoxOfficeCoreDataManager()
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "BoxOfficeCoreData")
        container.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Unable to load persistent sotres: \(error)")
            }
        }
        return container
    }()
    
    func saveData(date: String, with movie: DailyBoxOffice.BoxOfficeResult.Movie) {
        let viewContext = persistentContainer.viewContext
        let dailyBoxOfficeEntity = NSEntityDescription.entity(forEntityName: "DailyBoxOfficeData", in: viewContext)
        let boxOfficeEntity = NSEntityDescription.entity(forEntityName: "BoxOfficeData", in: viewContext)
        let filter = filteredDataRequest(date: date)
        
        guard let entity = dailyBoxOfficeEntity,
              let movieInfoEntity = boxOfficeEntity else { return }
    
        do {
            let data = try viewContext.fetch(filter) as! [NSManagedObject]
            
            var movieInfo: BoxOfficeData! = nil
            var value: DailyBoxOfficeData! = nil
            
            if data.count == 0 {
                movieInfo = NSManagedObject(entity: movieInfoEntity, insertInto: viewContext) as? BoxOfficeData
                value = NSManagedObject(entity: entity, insertInto: viewContext) as? DailyBoxOfficeData
            } else {
                value = data.first as? DailyBoxOfficeData
                movieInfo = value.movie.first
            }
            movieInfo.setValue(movie.audienceAccumulation , forKey: "audienceAccumulation")
            movieInfo.setValue(movie.screenCount , forKey: "screenCount")
            movieInfo.setValue(movie.showCount , forKey: "showCount")
            movieInfo.setValue(movie.rank , forKey: "rank")
            movieInfo.setValue(movie.rankVariance , forKey: "rankVariance")
            movieInfo.setValue(movie.rankOldAndNew , forKey: "rankOldAndNew")
            movieInfo.setValue(movie.code , forKey: "code")
            movieInfo.setValue(movie.name , forKey: "name")
            movieInfo.setValue(movie.openDate , forKey: "openDate")
            movieInfo.setValue(movie.salesAmount , forKey: "salesAmount")
            movieInfo.setValue(movie.salesShare , forKey: "salesShare")
            movieInfo.setValue(movie.salesVariance , forKey: "salesVariance")
            movieInfo.setValue(movie.salesChange , forKey: "salesChange")
            movieInfo.setValue(movie.salesAccumulation , forKey: "salesAccumulation")
            movieInfo.setValue(movie.audienceCount , forKey: "audienceCount")
            movieInfo.setValue(movie.audienceVariance , forKey: "audienceVariance")
            movieInfo.setValue(movie.audienceChange , forKey: "audienceChange")
            movieInfo.setValue(movie.order , forKey: "order")
            
            value.setValue(date, forKey: "selectedDate")
            value.setValue(movieInfo, forKey: "movie")
            print("")
        } catch {
            print(error.localizedDescription)
        }
        
        do {
            try viewContext.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func filteredDataRequest(date: String) -> NSFetchRequest<NSFetchRequestResult> {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest<NSFetchRequestResult>(entityName: "DailyBoxOfficeData")
        fetchRequest.predicate = NSPredicate(format: "selectedDate == %@", date)
               return fetchRequest
    }
    
    func fetchData() -> [DailyBoxOfficeData] {
        let context = self.persistentContainer.viewContext
        
        do {
            let data = try context.fetch(DailyBoxOfficeData.fetchRequest())
            return data
        } catch {
            print(error.localizedDescription)
            return [DailyBoxOfficeData]()
        }
    }
}

