//
//  DailyBoxOfficeData+CoreDataProperties.swift
//  BoxOffice
//
//  Created by 리지, kokkilE on 2023/04/07.
//
//

import Foundation
import CoreData

extension DailyBoxOfficeData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DailyBoxOfficeData> {
        return NSFetchRequest<DailyBoxOfficeData>(entityName: "DailyBoxOfficeData")
    }

    @NSManaged public var audienceAccumulation: String?
    @NSManaged public var screenCount: String?
    @NSManaged public var showCount: String?
    @NSManaged public var rank: String?
    @NSManaged public var rankVariance: String?
    @NSManaged public var rankOldAndNew: String?
    @NSManaged public var code: String?
    @NSManaged public var name: String?
    @NSManaged public var openDate: String?
    @NSManaged public var salesAmount: String?
    @NSManaged public var salesShare: String?
    @NSManaged public var salesVariance: String?
    @NSManaged public var salesChange: String?
    @NSManaged public var salesAccumulation: String?
    @NSManaged public var audienceCount: String?
    @NSManaged public var audienceVariance: String?
    @NSManaged public var audienceChange: String?
    @NSManaged public var order: String?
}

extension DailyBoxOfficeData : Identifiable {

}

class CoreDataManager {
    private init() { }
    
    static let shared: CoreDataManager = CoreDataManager()
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "DailyBoxOfficeData")
        container.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Unable to load persistent sotres: \(error)")
            }
        }
        return container
    }()
    
    func saveData(with data: DailyBoxOffice.BoxOfficeResult.Movie) {
        let viewContext = persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "DailyBoxOfficeData", in: viewContext)
        
        guard let entity = entity else { return }
        let movie = NSManagedObject(entity: entity, insertInto: viewContext)
        movie.setValue(data.audienceAccumulation , forKey: "audienceAccumulation")
        movie.setValue(data.screenCount , forKey: "screenCount")
        movie.setValue(data.showCount , forKey: "showCount")
        movie.setValue(data.rank , forKey: "rank")
        movie.setValue(data.rankVariance , forKey: "rankVariance")
        movie.setValue(data.rankOldAndNew , forKey: "rankOldAndNew")
        movie.setValue(data.code , forKey: "code")
        movie.setValue(data.name , forKey: "name")
        movie.setValue(data.openDate , forKey: "openDate")
        movie.setValue(data.salesAmount , forKey: "salesAmount")
        movie.setValue(data.salesShare , forKey: "salesShare")
        movie.setValue(data.salesVariance , forKey: "salesVariance")
        movie.setValue(data.salesChange , forKey: "salesChange")
        movie.setValue(data.salesAccumulation , forKey: "salesAccumulation")
        movie.setValue(data.audienceCount , forKey: "audienceCount")
        movie.setValue(data.audienceVariance , forKey: "audienceVariance")
        movie.setValue(data.audienceChange , forKey: "audienceChange")
        movie.setValue(data.order , forKey: "order")
        
        do {
            try viewContext.save()
        } catch {
            print(error.localizedDescription)
        }
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
