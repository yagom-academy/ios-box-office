//
//  DescStackView.swift
//  BoxOffice
//
//  Created by 강민수 on 2023/04/03.
//

import UIKit

final class DescStackView: UIStackView {
    
    let directorStackView = ContentStackView(categoryText: "감독")
    let productedYearStackView = ContentStackView(categoryText: "제작년도")
    let openDateStackView = ContentStackView(categoryText: "개봉일")
    let showTimeStackView = ContentStackView(categoryText: "상영시간")
    let auditStackView = ContentStackView(categoryText: "관람등급")
    let nationStackView = ContentStackView(categoryText: "제작국가")
    let genreStackView = ContentStackView(categoryText: "장르")
    let actorsStackView = ContentStackView(categoryText: "배우")

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        addArrangedSubviews()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
    
    private func configure() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.axis = .vertical
        self.spacing = 3
    }
    
    func updateTextLabel(_ data: MovieInfoDescObject) {
        directorStackView.updateLabelText(data.directors[0].name)
        productedYearStackView.updateLabelText(data.productedYear)
        openDateStackView.updateLabelText(data.openDate)
        showTimeStackView.updateLabelText(data.showTime)
        auditStackView.updateLabelText(data.audits[0].watchGradeNm)
        nationStackView.updateLabelText(data.nations[0].name)
        genreStackView.updateLabelText(data.genre[0].name)
        actorsStackView.updateLabelText(data.actors[0].name)
    }
}
