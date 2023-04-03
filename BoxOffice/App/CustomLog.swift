//
//  CustomLog.swift
//  BoxOffice
//
//  Created by Seoyeon Hong on 2023/03/31.
//

import Foundation

func DEBUG_LOG(_ msg: Any, file: String = #file, function: String = #function, line: Int = #line) {
    #if DEBUG
    let filename = file.split(separator: "/").last ?? ""
    let funcName = function.split(separator: "(").first ?? ""
    print("🥺[\(filename)] \(funcName) (\(line)): \(msg)")
    #endif
}
