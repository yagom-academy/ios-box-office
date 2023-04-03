//
//  MovieInformationStackView.swift
//  BoxOffice
//
//  Created by vetto, brody on 2023/04/03.
//

import UIKit

final class MovieInformationStackView: UIStackView {
    private let directorStackView = CategoryStackView(category: Category.director)
    private let productYearStackView = CategoryStackView(category: Category.productYear)
    private let openDateStackView = CategoryStackView(category: Category.openDate)
    private let showingTimeStackView = CategoryStackView(category: Category.showingTime)
    private let watchGradeStackView = CategoryStackView(category: Category.watchGrade)
    private let nationStackView = CategoryStackView(category: Category.nation)
    private let genreStackView = CategoryStackView(category: Category.genre)
    private let actorStackView = CategoryStackView(category: Category.actor)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.axis = .vertical
        self.spacing = 8
        
        self.addArrangedSubview(directorStackView)
        self.addArrangedSubview(productYearStackView)
        self.addArrangedSubview(openDateStackView)
        self.addArrangedSubview(showingTimeStackView)
        self.addArrangedSubview(watchGradeStackView)
        self.addArrangedSubview(nationStackView)
        self.addArrangedSubview(genreStackView)
        self.addArrangedSubview(actorStackView)
        
        NSLayoutConstraint.activate([
            directorStackView.categoryLabel.widthAnchor.constraint(equalTo: productYearStackView.categoryLabel.widthAnchor),
            directorStackView.categoryLabel.widthAnchor.constraint(equalTo: openDateStackView.categoryLabel.widthAnchor),
            directorStackView.categoryLabel.widthAnchor.constraint(equalTo: showingTimeStackView.categoryLabel.widthAnchor),
            directorStackView.categoryLabel.widthAnchor.constraint(equalTo: watchGradeStackView.categoryLabel.widthAnchor),
            directorStackView.categoryLabel.widthAnchor.constraint(equalTo: nationStackView.categoryLabel.widthAnchor),
            directorStackView.categoryLabel.widthAnchor.constraint(equalTo: genreStackView.categoryLabel.widthAnchor),
            directorStackView.categoryLabel.widthAnchor.constraint(equalTo: actorStackView.categoryLabel.widthAnchor),
        ])
    }
    
    func setupInformation(information: MovieDetailInformationItem) {
        directorStackView.setupInformationLabel(
            as: information.directors.map { $0.personName }.joined(separator: ", ")
        )
        productYearStackView.setupInformationLabel(as: information.productYear)
        openDateStackView.setupInformationLabel(as: information.openDate)
        showingTimeStackView.setupInformationLabel(as: information.showingTime)
        watchGradeStackView.setupInformationLabel(
            as: information.audits.map { $0.watchGradeName }.joined(separator: ", ")
        )
        nationStackView.setupInformationLabel(
            as: information.nations.map { $0.nationName }.joined(separator: ", ")
        )
        genreStackView.setupInformationLabel(
            as: information.genres.map { $0.genreName }.joined(separator: ", ")
        )
        actorStackView.setupInformationLabel(
            as: information.actors.map { $0.personName }.joined(separator: ", ")
        )
    }
}

fileprivate enum Category {
    static let director = "감독"
    static let productYear = "제작년도"
    static let openDate = "개봉일"
    static let showingTime = "상영시간"
    static let watchGrade = "관람등급"
    static let nation = "제작국가"
    static let genre = "장르"
    static let actor = "배우"
}
