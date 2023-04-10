//
//  DailyBoxOfficeData+CoreDataProperties.swift
//  BoxOffice
//
//  Created by 리지, kokkilE on 2023/04/10.
//
//

import Foundation
import CoreData

extension DailyBoxOfficeData {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<DailyBoxOfficeData> {
        return NSFetchRequest<DailyBoxOfficeData>(entityName: "DailyBoxOfficeData")
    }

    @NSManaged public var selectedDate: String?
    @NSManaged public var movie: BoxOfficeDatas?
}

extension DailyBoxOfficeData : Identifiable {

}
