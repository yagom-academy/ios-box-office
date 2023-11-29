//
//  NetworkManager.swift
//  BoxOffice
//
//  Created by hyunMac on 11/29/23.
//

import Foundation

struct NetworkManager {
    let kobisURL = "http://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json"
    let key = "19c7b9971c926c02ce807c0a86370091"
    let targetDate = fetchTodayDate()
    
    let requestURL = "\(kobisURL)?key=\(key)&targetDt=\(targetDate)"
    
}

func fetchTodayDate() -> String{
    let currentDate = Date()
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyyMMdd"
    let targetDate = dateFormatter.string(from: currentDate)
    
    return targetDate
}






