//
//  CalendarViewController.swift
//  BoxOffice
//
//  Created by vetto, brody on 2023/04/04.
//

import UIKit

@available(iOS 16.0, *)
final class CalendarViewController: UIViewController {
    private let calendarView: UICalendarView = {
       
        let calendarView = UICalendarView()
        calendarView.fontDesign = .default
        let date = Date()
        calendarView.visibleDateComponents = DateComponents(calendar: Calendar(identifier: .gregorian), year: 2023, month: 4, day: 4)
        
        return calendarView
    }()
    
    override func viewDidLoad() {
        self.view.backgroundColor = .white
        
        self.calendarView.delegate = self
        let singleDateSelection = UICalendarSelectionSingleDate(delegate: self)
        self.calendarView.selectionBehavior = singleDateSelection
        self.calendarView.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(self.calendarView)
        
        NSLayoutConstraint.activate([
            self.calendarView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.calendarView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.calendarView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.calendarView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
    }
}

@available(iOS 16.0, *)
extension CalendarViewController: UICalendarViewDelegate {
    func calendarView(_ calendarView: UICalendarView, decorationFor dateComponents: DateComponents) -> UICalendarView.Decoration? {
        return .none
        
    }
}

@available(iOS 16.0, *)
extension CalendarViewController: UICalendarSelectionSingleDateDelegate {
    func dateSelection(_ selection: UICalendarSelectionSingleDate, didSelectDate dateComponents: DateComponents?) {
    }
}

