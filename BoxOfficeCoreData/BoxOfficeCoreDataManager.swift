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
    
    func saveData(date: String, with movies: [DailyBoxOffice.BoxOfficeResult.Movie]) {
        let context = persistentContainer.newBackgroundContext()
        guard let dailyBoxOfficeEntity = NSEntityDescription.entity(forEntityName: "DailyBoxOfficeData", in: context) else { return }
        
        var dailyBoxOfficeData = fetchData(date: date)
        
        if dailyBoxOfficeData == nil {
            dailyBoxOfficeData = NSManagedObject(entity: dailyBoxOfficeEntity, insertInto: context) as? DailyBoxOfficeData
        }
        
        var movieList: [Movie] = []
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
        
        let movieData: Movies = Movies(boxOfficeDatas: movieList)
        
        dailyBoxOfficeData?.setValue(date, forKey: "selectedDate")
        dailyBoxOfficeData?.setValue(movieData, forKey: "movies")
        
        do {
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func filteredDataRequest(date: String) -> NSFetchRequest<DailyBoxOfficeData> {
        let fetchRequest: NSFetchRequest<DailyBoxOfficeData> = NSFetchRequest<DailyBoxOfficeData>(entityName: "DailyBoxOfficeData")
        fetchRequest.predicate = NSPredicate(format: "selectedDate == %@", date)
        return fetchRequest
    }
    
    func fetchData(date: String) -> DailyBoxOfficeData? {
        let context = self.persistentContainer.newBackgroundContext()
        let filter = filteredDataRequest(date: date)
        
        do {
            let data = try context.fetch(filter)
            return data.first
        } catch {
            return nil
        }
    }
}

