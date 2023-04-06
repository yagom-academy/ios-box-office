//
//  AlertMessage.swift
//  BoxOffice
//
//  Created by 리지, kokkilE on 2023/04/06.
//

enum AlertMessage {
    case updating
    
    var description: String {
        switch self {
        case .updating:
            return "오늘 날짜는 집계중입니다.\n다시 선택해주세요."
        }
    }
}
