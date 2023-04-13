//
//  CoreDataManager.swift
//  BoxOffice
//
//  Created by 리지, kokkilE on 2023/04/11.
//

import Foundation
import CoreData
import UIKit

final class CoreDataManager<Entity: NSManagedObject & EntityKeyProtocol , Element>: DataManager {
    private let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.newBackgroundContext()
    
    func create(key: String, value: [Element]) {
        guard let context = self.context,
              let entity = NSEntityDescription.entity(forEntityName: Entity.key, in: context),
              let storage = NSManagedObject(entity: entity, insertInto: context) as? Entity else { return }
        
        setValue(at: storage, key: key , data: value)
        save()
    }
    
    func read(key: String) -> Entity? {
        guard let context = self.context else { return nil }
        
        let filter = filteredDataRequest(entityType: Entity.self, key: key)
        
        do {
            let data = try context.fetch(filter)
            return data.first
        } catch {
            return nil
        }
    }
    
    func update(key: String, value: [Element]) {
        guard let fetchedData = read(key: key) else { return }
        
        setValue(at: fetchedData, key: key, data: value)
        save()
    }
    
    func delete() {
        guard let context = self.context else { return }
        
        let request: NSFetchRequest<NSFetchRequestResult> = Entity.fetchRequest()
        let delete = NSBatchDeleteRequest(fetchRequest: request)
        do {
            try context.execute(delete)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func deleteByTimeInterval() {
        guard let context = self.context else { return }
        
        let request: NSFetchRequest<NSFetchRequestResult> = Entity.fetchRequest()
        let olderThanDate = Date().addingTimeInterval(-1 * 24 * 60 * 60)
        request.predicate = NSPredicate(format: "createdAt < %@", argumentArray: [olderThanDate])
        
        let delete = NSBatchDeleteRequest(fetchRequest: request)
        do {
            try context.execute(delete)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    private func setValue(at target: Entity, key: String, data: [Element]) {
        guard let data = data.first else { return }
        let contents = data
        
        if target is DailyBoxOfficeData {
            target.setValue(Date.now, forKey: "createdAt")
            target.setValue(key, forKey: "selectedDate")
            target.setValue(contents, forKey: "movies")
        } else if target is MovieInformationData {
            target.setValue(Date.now, forKey: "createdAt")
            target.setValue(key, forKey: "movieCode")
            target.setValue(contents, forKey: "movieDetails")
        }
    }
    
    private func save() {
        guard let context = self.context else { return }
        
        do {
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    private func filteredDataRequest<T: NSManagedObject>(entityType: T.Type, key: String) -> NSFetchRequest<T> {
        let fetchRequest = NSFetchRequest<T>(entityName: String(describing: entityType))
        
        if entityType == DailyBoxOfficeData.self {
            fetchRequest.predicate = NSPredicate(format: "selectedDate == %@", key)
        } else if entityType == MovieInformationData.self {
            fetchRequest.predicate = NSPredicate(format: "movieCode == %@", key)
        }
        
        return fetchRequest
    }
}
