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
        let viewContext = persistentContainer.newBackgroundContext()
        let dailyBoxOfficeEntity = NSEntityDescription.entity(forEntityName: "DailyBoxOfficeData", in: viewContext)
        
        guard let dailyBoxOfficeEntity = dailyBoxOfficeEntity else { return }
    
        do {
            let filter = filteredDataRequest(date: date)
            let data = try viewContext.fetch(filter) as! [NSManagedObject]
            var dailyBoxOfficeData: DailyBoxOfficeData! = nil
            
            if data.count == 0 {
                dailyBoxOfficeData = NSManagedObject(entity: dailyBoxOfficeEntity, insertInto: viewContext) as? DailyBoxOfficeData
            } else {
                dailyBoxOfficeData = data.first as? DailyBoxOfficeData
            }
            
            let boxOfficeData = BoxOfficeData()
            
            boxOfficeData.audienceAccumulation = movie.audienceAccumulation
            boxOfficeData.screenCount = movie.screenCount
            boxOfficeData.showCount = movie.showCount
            boxOfficeData.rank = movie.rank
            boxOfficeData.rankVariance = movie.rankVariance
            boxOfficeData.rankOldAndNew = movie.rankOldAndNew
            boxOfficeData.code = movie.code
            boxOfficeData.name = movie.name
            boxOfficeData.openDate = movie.openDate
            boxOfficeData.salesAmount = movie.salesAmount
            boxOfficeData.salesShare = movie.salesShare
            boxOfficeData.salesVariance = movie.salesVariance
            boxOfficeData.salesChange = movie.salesChange
            boxOfficeData.salesAccumulation = movie.salesAccumulation
            boxOfficeData.audienceCount = movie.audienceCount
            boxOfficeData.audienceVariance = movie.audienceVariance
            boxOfficeData.audienceChange = movie.audienceChange
            boxOfficeData.order = movie.order
            
            let boxOfficeDatas = BoxOfficeDatas(boxOfficeDatas: [boxOfficeData])
            
            dailyBoxOfficeData.setValue(date, forKey: "selectedDate")
            dailyBoxOfficeData.setValue(boxOfficeDatas, forKey: "movie")
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
        let request = DailyBoxOfficeData.fetchRequest()
        
        do {
            let data = try context.fetch(request)
            return data
        } catch {
            print(error.localizedDescription)
            return [DailyBoxOfficeData]()
        }
    }
}

