//
//  DailyBoxOfficeData+CoreDataClass.swift
//  BoxOffice
//
//  Created by 리지, kokkilE on 2023/04/10.
//
//

import Foundation
import CoreData

@objc(DailyBoxOfficeData)
public class BoxOfficeData: NSManagedObject {
    
    public required convenience init?(coder: NSCoder) {
        self.init()
        self.audienceAccumulation = coder.decodeObject(forKey: "audienceAccumulation") as? String
        self.audienceChange = coder.decodeObject(forKey: "audienceChange") as? String
        self.audienceCount = coder.decodeObject(forKey: "audienceCount") as? String
        self.audienceVariance = coder.decodeObject(forKey: "audienceVariance") as? String
        self.code = coder.decodeObject(forKey: "code") as? String
        self.name = coder.decodeObject(forKey: "name") as? String
        self.openDate = coder.decodeObject(forKey: "openDate") as? String
        self.order = coder.decodeObject(forKey: "order") as? String
        self.rank = coder.decodeObject( forKey: "rank") as? String
        self.rankOldAndNew = coder.decodeObject(forKey: "rankOldAndNew") as? String
        self.rankVariance = coder.decodeObject(forKey: "rankVariance") as? String
        self.salesAccumulation = coder.decodeObject(forKey: "salesAccumulation") as? String
        self.salesAmount = coder.decodeObject(forKey: "salesAmount") as? String
        self.salesChange = coder.decodeObject(forKey: "salesChange") as? String
        self.salesShare = coder.decodeObject(forKey: "salesShare") as? String
        self.salesVariance = coder.decodeObject(forKey: "salesVariance") as? String
        self.screenCount = coder.decodeObject(forKey: "screenCount") as? String
        self.showCount = coder.decodeObject(forKey: "showCount") as? String
    }
}
