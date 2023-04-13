//
//  DescStackView.swift
//  BoxOffice
//
//  Created by 강민수 on 2023/04/03.
//

import UIKit

final class DescStackView: UIStackView {
    
    private let directorStackView = ContentStackView(categoryText: "감독")
    private let productedYearStackView = ContentStackView(categoryText: "제작년도")
    private let openDateStackView = ContentStackView(categoryText: "개봉일")
    private let showTimeStackView = ContentStackView(categoryText: "상영시간")
    private let auditStackView = ContentStackView(categoryText: "관람등급")
    private let nationStackView = ContentStackView(categoryText: "제작국가")
    private let genreStackView = ContentStackView(categoryText: "장르")
    private let actorsStackView = ContentStackView(categoryText: "배우")

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        addArrangedSubviews()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    func updateTextLabel(_ data: MovieInfoUIModel) {
        directorStackView.updateLabelText(data.directors)
        productedYearStackView.updateLabelText(data.productedYear)
        openDateStackView.updateLabelText(data.openDate)
        showTimeStackView.updateLabelText(data.showTime)
        auditStackView.updateLabelText(data.audits)
        nationStackView.updateLabelText(data.nations)
        genreStackView.updateLabelText(data.genre)
        actorsStackView.updateLabelText(data.actors)
    }
}

// MARK: UI
extension DescStackView {
    private func configure() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.axis = .vertical
        self.spacing = 3
    }
    
    private func addArrangedSubviews() {
        self.addArrangedSubview(directorStackView)
        self.addArrangedSubview(productedYearStackView)
        self.addArrangedSubview(openDateStackView)
        self.addArrangedSubview(showTimeStackView)
        self.addArrangedSubview(auditStackView)
        self.addArrangedSubview(nationStackView)
        self.addArrangedSubview(genreStackView)
        self.addArrangedSubview(actorsStackView)
    }
}
