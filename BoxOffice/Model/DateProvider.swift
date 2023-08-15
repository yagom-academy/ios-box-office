//
//  DateProvider.swift
//  BoxOffice
//
//  Created by redmango, Jusbug on 2023/08/02.
//

import Foundation

struct DateProvider {
    typealias NumberOfDays = Int
    
    func updateDate(with date: Date = Date(), to numberOfDays: NumberOfDays, by form: DateForm) -> String? {
        do {
            let reciveDate = try reciveDate(to: numberOfDays, from: date)
            return formatDate(with: reciveDate, by: form)
        } catch DateProviderError.wrongDate {
            print("wrongDateError")
        } catch {
            print("unknown Error in reciveDate()")
        }
        
        return nil
    }
    
    func formatDate(with date: Date, by form: DateForm) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = form.formet
        
        return dateFormatter.string(from: date)
    }
    
    private func reciveDate(to numberOfDays: NumberOfDays, from date: Date) throws -> Date {
        guard let reciveDate = Calendar.current.date(byAdding: .day, value: numberOfDays, to: date) else {
            throw DateProviderError.wrongDate
        }
        
        return reciveDate
    }
}

enum DateForm {
    case urlDate
    case viewTitle
    
    var formet: String {
        switch self {
        case .urlDate:
            return "YYYYMMdd"
        case .viewTitle:
            return "YYYY-MM-dd"
        }
    }
}

