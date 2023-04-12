//
//  AlertActionDelegate.swift
//  BoxOffice
//
//  Created by kaki, harry on 2023/04/12.
//

protocol AlertActionDelegate: AnyObject {
    func okAction(_ key: AlertActionKeys)
    func cancelAction(_ key: AlertActionKeys)
}
