//
//  SelectDateViewController.swift
//  BoxOffice
//
//  Created by 리지, kokkilE on 2023/04/03.
//

import UIKit

final class SelectDateViewController: UIViewController {
    private let calendarView = UICalendarView()
    weak var delegate: DateUpdatable?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        view.addSubview(calendarView)
        
        configureCalendarView()
        configureConstraintCalendarView()
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
    }
    
    private func configureConstraintCalendarView() {
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
            AlertManager.shared.showAlert(target: self,
                                          alertTitle: "알림",
                                          message: AlertManager.AlertMessage.updating,
                                          style: .alert,
                                          okActionTitle: "닫기",
                                          cancelActionTitle: nil,
                                          okActionHandler: nil)
            selection.selectedDate = nil
            
            return
        }

        delegate?.selectedDate = selectedDate
        delegate?.refreshData()
        
        dismiss(animated: true)
    }
}


