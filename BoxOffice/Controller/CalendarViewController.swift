//
//  CalendarViewController.swift
//  BoxOffice
//
//  Created by goat, songjun on 2023/04/04.
//

import UIKit

class CalendarViewController: UIViewController {
    private var calendarView = CalendarView()
    var choosenDate = ""
    weak var delegate: CalendarDateDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = calendarView
        let selection = UICalendarSelectionSingleDate(delegate: self)
        calendarView.selectionBehavior = selection
    }
}

extension CalendarViewController: UICalendarSelectionSingleDateDelegate {
    func dateSelection(_ selection: UICalendarSelectionSingleDate, didSelectDate dateComponents: DateComponents?) {
        guard let year = dateComponents?.year?.convertIntToString() else { return }
        guard let month = dateComponents?.month?.convertIntToString() else { return }
        guard let day = dateComponents?.day?.convertIntToString() else { return }
        choosenDate += year + month + day
        delegate?.receiveDate(date: choosenDate)
        choosenDate = ""
        self.dismiss(animated: true)
        return
    }
}
