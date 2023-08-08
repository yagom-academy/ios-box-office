//
//  CalendarViewController.swift
//  BoxOffice
//
//  Created by 박종화 on 2023/08/08.
//

import UIKit

class CalendarViewController: UIViewController {
    var calendarView: UICalendarView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showCalendarView()
    }
    
    private func showCalendarView() {
        calendarView = UICalendarView(frame: CGRect(x: 0, y: 0,
                                                    width: view.bounds.width,
                                                    height: view.bounds.height))
        calendarView.backgroundColor = .white
        view.addSubview(calendarView)
    }
}
