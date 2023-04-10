//
//  BoxOfficeDatas+CoreDataClass.swift
//  BoxOffice
//
//  Created by 리지, kokkilE on 2023/04/10.
//
//

import Foundation

public class BoxOfficeDatas: NSObject, NSSecureCoding {
    
    public var boxOfficeDatas: [BoxOfficeData] = []
    
    public static var supportsSecureCoding: Bool {
        return true
    }
    
    public func encode(with coder: NSCoder) {
        coder.encode(boxOfficeDatas, forKey: "boxOfficeDatas")
    }
    
    init(boxOfficeDatas: [BoxOfficeData]) {
        self.boxOfficeDatas = boxOfficeDatas
    }
    
    public convenience required init?(coder: NSCoder) {
        let boxOfficeDatas = coder.decodeObject(of: [NSArray.self, BoxOfficeData.self], forKey: "boxOfficeDatas")
        
        self.init(boxOfficeDatas: boxOfficeDatas as! [BoxOfficeData])
    }
}
