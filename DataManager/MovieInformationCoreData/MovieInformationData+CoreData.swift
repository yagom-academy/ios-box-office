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

extension MovieInformationData: EntityKeyProtocol {
    static let key = "MovieInformationData"
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<MovieInformationData> {
        return NSFetchRequest<MovieInformationData>(entityName: MovieInformationData.key)
    }

    @NSManaged var createdAt: Date?
    @NSManaged var movieCode: String?
    @NSManaged var movieDetails: MovieDetails?
}
