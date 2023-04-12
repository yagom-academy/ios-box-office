//
//  AlertActionDelegate.swift
//  BoxOffice
//
//  Created by kaki, harry on 2023/04/12.
//

import Foundation

@objc protocol AlertActionDelegate {
    @objc optional func okAction()
    @objc optional func cancelAction()
    @objc optional func firstAction()
    @objc optional func secondAction()
}
