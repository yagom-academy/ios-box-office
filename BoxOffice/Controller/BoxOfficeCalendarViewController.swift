//
//  BoxOfficeCalendarViewController.swift
//  BoxOffice
//
//  Created by EtialMoon, Minsup on 2023/08/14.
//

import UIKit

protocol BoxOfficeCalendarViewControllerDelegate: AnyObject {
    func didTapSelectedDate(_ date: Date)
}

final class BoxOfficeCalendarViewController: UIViewController {
    private let calendarView = UICalendarView()
    private let selectedDate: Date
    weak var delegate: BoxOfficeCalendarViewControllerDelegate?
    
    init(date: Date) {
        selectedDate = date
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = calendarView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpCalendar()
    }
    
    private func setUpCalendar() {
        calendarView.backgroundColor = .systemBackground
        calendarView.locale = Locale(identifier: "ko_KR")
        calendarView.availableDateRange = DateInterval(start: .distantPast, end: .now)
        
        let dateSelection = UICalendarSelectionSingleDate(delegate: self)
        calendarView.selectionBehavior = dateSelection
        
        dateSelection.selectedDate = Calendar.current.dateComponents([.year, .month, .day], from: selectedDate)
    }
}

extension BoxOfficeCalendarViewController: UICalendarSelectionSingleDateDelegate {
    func dateSelection(_ selection: UICalendarSelectionSingleDate, didSelectDate dateComponents: DateComponents?) {
        guard let dateComponents else { return }
        
        selection.setSelected(dateComponents, animated: true)
        
        guard let selectedDate = dateComponents.date else { return }
        delegate?.didTapSelectedDate(selectedDate)
        dismiss(animated: true)
    }
}
