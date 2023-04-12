//
//  MovieInformationData+CoreData.swift
//  BoxOffice
//
//  Created by 리지, kokkilE on 2023/04/11.
//
//

import Foundation
import CoreData

@objc(MovieInformationData)
public final class MovieInformationData: NSManagedObject {

}

extension MovieInformationData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MovieInformationData> {
        return NSFetchRequest<MovieInformationData>(entityName: "MovieInformationData")
    }

    @NSManaged var createdAt: Date?
    @NSManaged var movieCode: String?
    @NSManaged var details: Details?
}
