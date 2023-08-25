//
//  MovieInformationStackView.swift
//  BoxOffice
//
//  Created by Dasan & Whales on 2023/08/15.
//

import UIKit

final class MovieInformationStackView: UIStackView {
    private var movieInformation: MovieInformation?
    
    private var directorStackView: MovieDetailStackView?
    private var productionYearStackView: MovieDetailStackView?
    private var openingDateStackView: MovieDetailStackView?
    private var showTimeStackView: MovieDetailStackView?
    private var watchGradeStackView: MovieDetailStackView?
    private var nationStackView: MovieDetailStackView?
    private var genreStackView: MovieDetailStackView?
    private var actorStackView: MovieDetailStackView?
    
    init(frame: CGRect, movieInformation: MovieInformation) {
        super.init(frame: frame)
        self.movieInformation = movieInformation
        
        configureUI()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MovieInformationStackView {
    private func configureUI() {
        self.axis = .vertical
        self.alignment = .center
        self.distribution = .fill
        self.spacing = 8
        self.translatesAutoresizingMaskIntoConstraints = false
        
        configureLabels()
        
        _ = [directorStackView, productionYearStackView, openingDateStackView, showTimeStackView,
         watchGradeStackView,nationStackView, genreStackView, actorStackView].map {
            guard let stackView = $0 else { return }
            self.addArrangedSubview(stackView)
            stackView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        }
    }
    
    private func configureLabels() {
        guard let directorsName = movieInformation?.directors.map({ $0.personName }).joined(separator: ", "),
              let productionYear = movieInformation?.productionYear,
              var openingDate = movieInformation?.openingDate,
              let showTime = movieInformation?.showTime,
              let watchGradesName = movieInformation?.audits.map({ $0.watchGradeName }).joined(separator: ", "),
              let nationsName = movieInformation?.nations.map({ $0.nationName }).joined(separator: ", "),
              let genresName = movieInformation?.genres.map({ $0.genreName }).joined(separator: ", "),
              let actorsName = movieInformation?.actors.map({ $0.personName }).joined(separator: ", ") else { return }
        
        directorStackView = MovieDetailStackView(frame: .zero, title: "감독", content: directorsName)
        productionYearStackView = MovieDetailStackView(frame: .zero, title: "제작년도", content: productionYear)
        openingDateStackView = MovieDetailStackView(frame: .zero, title: "개봉일", content: openingDate.formattedDateWithHyphen())
        showTimeStackView = MovieDetailStackView(frame: .zero, title: "상영시간", content: showTime)
        watchGradeStackView = MovieDetailStackView(frame: .zero, title: "관람등급", content: watchGradesName)
        nationStackView = MovieDetailStackView(frame: .zero, title: "제작국가", content: nationsName)
        genreStackView = MovieDetailStackView(frame: .zero, title: "장르", content: genresName)
        actorStackView = MovieDetailStackView(frame: .zero, title: "배우", content: actorsName)
    }
}
