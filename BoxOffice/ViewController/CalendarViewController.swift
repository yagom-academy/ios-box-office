//
//  CalendarViewController.swift
//  BoxOffice
//
//  Created by Serena, BMO on 2023/08/10.
//

import UIKit

final class CalendarViewController: UIViewController {
    weak var delegate: CalendarViewControllerDelegate?
    
    private lazy var calendarView: UICalendarView = {
        let view = UICalendarView()
        
        return view
    }()
    
    override func loadView() {
        view = calendarView
    }
    
    override func viewDidLoad() {
        configureBackgroundColor()
        limitCalendarRange()
        showSelectedDate()
    }
    
    private func configureBackgroundColor() {
        view.backgroundColor = .systemBackground
    }
    
    private func limitCalendarRange() {
        calendarView.availableDateRange = DateInterval(start: .distantPast, end: DateManager.yesterday)
    }
    
    private func showSelectedDate() {
        guard let year = Int(DateManager.year),
              let month = Int(DateManager.month),
              let day = Int(DateManager.day)
        else { return }
        
        let dateSelection = UICalendarSelectionSingleDate(delegate: self)
        
        calendarView.selectionBehavior = dateSelection
        dateSelection.selectedDate = DateComponents(year: year, month: month, day: day)
        
        calendarView.visibleDateComponents = DateComponents(year: year, month: month, day: day)
    }
    
    private func updateDate(_ dateComponents: DateComponents?) {
        guard let date = dateComponents?.date else { return }
        DateManager.selectedDate = date
    }
}

// MARK: - Delegate
extension CalendarViewController: UICalendarSelectionSingleDateDelegate {
    func dateSelection(_ selection: UICalendarSelectionSingleDate, didSelectDate dateComponents: DateComponents?) {
        updateDate(dateComponents)
        delegate?.updateBoxOfficeDate()
        
        self.dismiss(animated: true)
    }
}
