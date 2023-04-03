//
//  CalendarViewController.swift
//  BoxOffice
//
//  Created by Seoyeon Hong on 2023/04/03.
//

import UIKit

class CalendarViewController: UIViewController {
    
    private let calendarView: UICalendarView = {
        let calendarView = UICalendarView()
        calendarView.translatesAutoresizingMaskIntoConstraints = false
        return calendarView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
    }
    
}
