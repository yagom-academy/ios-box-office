//
//  DailyBoxOfficeData+CoreData.swift
//  BoxOffice
//
//  Created by 리지, kokkilE on 2023/04/10.
//
//

import Foundation
import CoreData

@objc(DailyBoxOfficeData)
public final class DailyBoxOfficeData: NSManagedObject {

}

extension DailyBoxOfficeData: EntityKeyProtocol {
    static let key = "DailyBoxOfficeData"
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<DailyBoxOfficeData> {
        return NSFetchRequest<DailyBoxOfficeData>(entityName: DailyBoxOfficeData.key)
    }

    @NSManaged var createdAt: Date?
    @NSManaged var selectedDate: String?
    @NSManaged var movies: Movies?
}
