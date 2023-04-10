//
//  BoxOfficeData+CoreDataProperties.swift
//  BoxOffice
//
//  Created by 리지, kokkilE on 2023/04/10.
//
//

import Foundation
import CoreData

extension BoxOfficeData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<BoxOfficeData> {
        return NSFetchRequest<BoxOfficeData>(entityName: "BoxOfficeData")
    }

    @NSManaged public var audienceAccumulation: String?
    @NSManaged public var audienceChange: String?
    @NSManaged public var audienceCount: String?
    @NSManaged public var audienceVariance: String?
    @NSManaged public var code: String?
    @NSManaged public var name: String?
    @NSManaged public var openDate: String?
    @NSManaged public var order: String?
    @NSManaged public var rank: String?
    @NSManaged public var rankOldAndNew: String?
    @NSManaged public var rankVariance: String?
    @NSManaged public var salesAccumulation: String?
    @NSManaged public var salesAmount: String?
    @NSManaged public var salesChange: String?
    @NSManaged public var salesShare: String?
    @NSManaged public var salesVariance: String?
    @NSManaged public var screenCount: String?
    @NSManaged public var showCount: String?

}

extension BoxOfficeData: Identifiable {

}

extension BoxOfficeData: NSSecureCoding {
    public static var supportsSecureCoding: Bool {
        return true
    }
    
    public func encode(with coder: NSCoder) {
        coder.encode(audienceAccumulation, forKey: "audienceAccumulation")
        coder.encode(audienceChange, forKey: "audienceChange")
        coder.encode(audienceCount, forKey: "audienceCount")
        coder.encode(audienceVariance, forKey: "audienceVariance")
        coder.encode(code, forKey: "code")
        coder.encode(name, forKey: "name")
        coder.encode(openDate, forKey: "openDate")
        coder.encode(order, forKey: "order")
        coder.encode(rank, forKey: "rank")
        coder.encode(rankOldAndNew, forKey: "rankOldAndNew")
        coder.encode(rankVariance, forKey: "rankVariance")
        coder.encode(salesAccumulation, forKey: "salesAccumulation")
        coder.encode(salesAmount, forKey: "salesAmount")
        coder.encode(salesChange, forKey: "salesChange")
        coder.encode(salesShare, forKey: "salesShare")
        coder.encode(salesVariance, forKey: "salesVariance")
        coder.encode(screenCount, forKey: "screenCount")
        coder.encode(showCount, forKey: "showCount")

    }
}
