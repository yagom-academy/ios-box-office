//
//  SelectDateViewController.swift
//  BoxOffice
//
//  Created by 리지, kokkilE on 2023/04/03.
//

import UIKit

@available(iOS 16.0, *)
final class SelectDateViewController: UIViewController {
    private let calendarView = UICalendarView()
    var delegate: DateUpdatable?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(calendarView)
        
        configureCalendarView()
    }
    
    private func configureCalendarView() {
        let gregorianCalendar = Calendar(identifier: .gregorian)
        calendarView.calendar = gregorianCalendar
        calendarView.locale = Locale(identifier: "ko-KR")
        calendarView.fontDesign = .rounded
        calendarView.availableDateRange = DateInterval(start: .distantPast, end: .now)
        
        let dateSelection = UICalendarSelectionSingleDate(delegate: self)
        calendarView.selectionBehavior = dateSelection
        
        calendarView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            calendarView.topAnchor.constraint(equalTo: view.topAnchor),
            calendarView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            calendarView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            calendarView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}

@available(iOS 16.0, *)
extension SelectDateViewController: UICalendarViewDelegate, UICalendarSelectionSingleDateDelegate {
    func dateSelection(_ selection: UICalendarSelectionSingleDate, didSelectDate dateComponents: DateComponents?) {
        guard let selectedDate = dateComponents?.date else { return }
    
        delegate?.selectedDate = selectedDate
        delegate?.refreshData()
        
        self.dismiss(animated: true)
    }
}


