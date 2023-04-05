//
//  SelectDateViewController.swift
//  BoxOffice
//
//  Created by 리지, kokkilE on 2023/04/03.
//

import UIKit

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
        calendarView.calendar = Calendar(identifier: .gregorian)
        calendarView.locale = Locale(identifier: "ko-KR")
        calendarView.fontDesign = .rounded
        calendarView.availableDateRange = DateInterval(start: .distantPast, end: .now)
        
        guard let selectedDate = delegate?.selectedDate else { return }
        
        let dateSelection = UICalendarSelectionSingleDate(delegate: self)
        let dataComponent = calendarView.calendar.dateComponents([.year, .month, .day], from: selectedDate)
        dateSelection.setSelected(dataComponent, animated: true)
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

extension SelectDateViewController: UICalendarSelectionSingleDateDelegate {
    func dateSelection(_ selection: UICalendarSelectionSingleDate, didSelectDate dateComponents: DateComponents?) {
        guard let selectedDate = dateComponents?.date else { return }
        
        if calendarView.calendar.dateComponents([.year, .month, .day], from: selectedDate) ==
            calendarView.calendar.dateComponents([.year, .month, .day], from: calendarView.availableDateRange.end) {
            let message = "오늘 날짜는 집계중입니다.\n다시 선택해주세요."
            let alert = UIAlertController(title: "알림", message: message, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "닫기", style: .default)
            alert.addAction(okAction)
            
            present(alert, animated: true)
            
            return
        }
        
        delegate?.selectedDate = selectedDate
        delegate?.refreshData()
        
        self.dismiss(animated: true)
    }
}
