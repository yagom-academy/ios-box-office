//
//  CalendarViewController.swift
//  BoxOffice
//
//  Created by Serena, BMO on 2023/08/10.
//

import UIKit

final class CalendarViewController: UIViewController {
    weak var delegate: CalendarViewControllerDelegate?
    
    private var year, month, day: Int
    
    private lazy var calendarView: UICalendarView = {
        let view = UICalendarView()
        
        return view
    }()
    
    init(year: Int, month: Int, day: Int) {
        self.year = year
        self.month = month
        self.day = day
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        let dateSelection = UICalendarSelectionSingleDate(delegate: self)
        
        calendarView.selectionBehavior = dateSelection
        calendarView.availableDateRange = DateInterval(start: .distantPast, end: .now - (24 * 60 * 60))
        calendarView.visibleDateComponents = DateComponents(year: year, month: month, day: day)
        
        dateSelection.selectedDate = DateComponents(year: year, month: month, day: day)
        
        view = calendarView
    }
    
    override func viewDidLoad() {
        view.backgroundColor = .systemBackground
    }
}

extension CalendarViewController: UICalendarSelectionSingleDateDelegate {
    func dateSelection(_ selection: UICalendarSelectionSingleDate, didSelectDate dateComponents: DateComponents?) {
        delegate?.updateDate(dateComponents: dateComponents)
        self.dismiss(animated: true)
    }
}
