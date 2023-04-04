//
//  CalendarViewController.swift
//  BoxOffice
//
//  Created by Rhode, Rilla on 2023/04/04.
//

import UIKit

final class CalendarViewController: UIViewController {
    private let calendarView: UICalendarView = {
        let calendarView = UICalendarView()
        let gregorianCalendar = Calendar(identifier: .gregorian)
        calendarView.calendar = gregorianCalendar
        calendarView.locale = Locale(identifier: "ko_KR")
        calendarView.translatesAutoresizingMaskIntoConstraints = false
        
        calendarView.fontDesign = .rounded
        return calendarView
    }()
    
    override func viewDidLoad() {
        configureMainView()
    }
    
    private func configureMainView() {
        view.backgroundColor = .white
        
        configureCalendarView()
    }
    
    private func configureCalendarView() {
        view.addSubview(calendarView)
        
        NSLayoutConstraint.activate([
            calendarView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            calendarView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            calendarView.topAnchor.constraint(equalTo: view.topAnchor),
            calendarView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
}
