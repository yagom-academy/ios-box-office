//
//  CalendarViewController.swift
//  BoxOffice
//
//  Created by redmango, Jusbug on 2023/08/08.
//

import UIKit

final class CalendarViewController: UIViewController {
    var calendarView: UICalendarView?
    var selectedDate: Date?
    weak var delegate: CalendarViewControllerDelegate?
    
    init(selectedDate: Date?, delegate: CalendarViewControllerDelegate?) {
        self.selectedDate = selectedDate
        self.delegate = delegate
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCalendar()
        showCalendarView()
        addInitAndView()
    }
    
    private func showCalendarView() {
        let currentDate = Date()
        guard let pastDate = Calendar.current.date(byAdding: .year, value: -10, to: currentDate),
              let yesterday = Calendar.current.date(byAdding: .day, value: -1, to: currentDate) else {
            return
        }
        
        let selectedDateComponent = getDateComponent(selectedDate ?? yesterday)
        let dateSelection = UICalendarSelectionSingleDate(delegate: self)
        dateSelection.selectedDate = selectedDateComponent
        calendarView?.selectionBehavior = dateSelection
        calendarView?.availableDateRange = DateInterval(start: pastDate, end: currentDate)
    }
    
    private func configureCalendar() {
        calendarView = UICalendarView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height))
        calendarView?.backgroundColor = .white
        calendarView?.calendar = .current
        calendarView?.locale = Locale(identifier: "ko_KR")
        calendarView?.timeZone = TimeZone(identifier: "Asia/Seoul")
    }
    
    private func addInitAndView() {
        calendarView?.delegate = self
        view.addSubview(calendarView ?? UICalendarView())
    }
    
    private func getDateComponent(_ date: Date) -> DateComponents {
        let components: Set<Calendar.Component> = [.year, .month, .day]
        return Calendar.current.dateComponents(components, from: date)
    }
}

extension CalendarViewController: UICalendarSelectionSingleDateDelegate, UICalendarViewDelegate {
    func dateSelection(_ selection: UICalendarSelectionSingleDate, didSelectDate dateComponents: DateComponents?) {
        if let date = dateComponents?.date {
            delegate?.didSelectDate(date)
            dismiss(animated: true, completion: nil)
        } else {
            print("unselected Error")
        }
    }
}
