//
//  DailyBoxOfficeData+CoreDataClass.swift
//  BoxOffice
//
//  Created by 리지, kokkilE on 2023/04/10.
//
//

import Foundation

public class BoxOfficeData: NSObject {
    public var audienceAccumulation: String?
    public var audienceChange: String?
    public var audienceCount: String?
    public var audienceVariance: String?
    public var code: String?
    public var name: String?
    public var openDate: String?
    public var order: String?
    public var rank: String?
    public var rankOldAndNew: String?
    public var rankVariance: String?
    public var salesAccumulation: String?
    public var salesAmount: String?
    public var salesChange: String?
    public var salesShare: String?
    public var salesVariance: String?
    public var screenCount: String?
    public var showCount: String?
    
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
