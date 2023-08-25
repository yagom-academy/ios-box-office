//
//  DescriptionStackView.swift
//  BoxOffice
//
//  Created by karen on 2023/08/19.
//

import UIKit

final class DescriptionStackView: UIStackView {
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
        configureInit()
        addArrangedSubviews()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    func update(_ data: MovieDetailUIModel) {
        directorStackView.updateContentText(data.directors)
        productedYearStackView.updateContentText(data.productedYear)
        openDateStackView.updateContentText(data.releaseDate)
        showTimeStackView.updateContentText(data.showTime)
        auditStackView.updateContentText(data.audits)
        nationStackView.updateContentText(data.nations)
        genreStackView.updateContentText(data.genre)
        actorsStackView.updateContentText(data.actors)
    }
}

// MARK: UI
private extension DescriptionStackView {
    func configureInit() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.axis = .vertical
        self.spacing = 3
    }
    
    func addArrangedSubviews() {
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
