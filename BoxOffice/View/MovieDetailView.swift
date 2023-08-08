//
//  MovieDetailView.swift
//  BoxOffice
//
//  Created by Serena, BMO on 2023/08/06.
//

import UIKit

final class MovieDetailView: UIView {
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints  = false
        
        return scrollView
    }()
    
    let contentView: UIView = {
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        return contentView
    }()
    
    let posterImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        
        return image
    }()
    
    private let totalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.alignment = .leading
        stackView.distribution = .equalSpacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    private let directorContentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        
        return stackView
    }()
    
    private let directorTitleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "감독"
        label.font = UIFont.preferredFont(for: .title3, weight: .heavy)
        label.minimumScaleFactor = 0.3
        label.adjustsFontForContentSizeCategory = true
        label.adjustsFontSizeToFitWidth = true
        
        return label
    }()
    
    let directorDetailLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.minimumScaleFactor = 0.3
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.adjustsFontForContentSizeCategory = true
        label.adjustsFontSizeToFitWidth = true
        
        return label
    }()
    
    private let productionYearContentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 4
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        
        return stackView
    }()
    
    private let productionYearTitleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "제작년도"
        label.font = UIFont.preferredFont(for: .title3, weight: .heavy)
        label.minimumScaleFactor = 0.3
        label.adjustsFontForContentSizeCategory = true
        label.adjustsFontSizeToFitWidth = true
        
        return label
    }()
    
    let productionYearDetailLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.minimumScaleFactor = 0.3
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.adjustsFontForContentSizeCategory = true
        label.adjustsFontSizeToFitWidth = true
        
        return label
    }()
    
    private let openDateContentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 4
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        
        return stackView
    }()
    
    private let openDateTitleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "개봉일"
        label.font = UIFont.preferredFont(for: .title3, weight: .heavy)
        label.minimumScaleFactor = 0.3
        label.adjustsFontForContentSizeCategory = true
        label.adjustsFontSizeToFitWidth = true
        
        return label
    }()
    
    let openDateDetailLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.minimumScaleFactor = 0.3
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.adjustsFontForContentSizeCategory = true
        label.adjustsFontSizeToFitWidth = true
        
        return label
    }()
    
    private let showTimeContentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 4
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        
        return stackView
    }()
    
    private let showTimeTitleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "상영시간"
        label.font = UIFont.preferredFont(for: .title3, weight: .heavy)
        label.minimumScaleFactor = 0.3
        label.adjustsFontForContentSizeCategory = true
        label.adjustsFontSizeToFitWidth = true
        
        return label
    }()
    
    let showTimeDetailLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.minimumScaleFactor = 0.3
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.adjustsFontForContentSizeCategory = true
        label.adjustsFontSizeToFitWidth = true
        
        return label
    }()
    
    private let watchGradeNameContentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 4
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        
        return stackView
    }()
    
    private let watchGradeNameTitleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "관람등급"
        label.font = UIFont.preferredFont(for: .title3, weight: .heavy)
        label.minimumScaleFactor = 0.3
        label.adjustsFontForContentSizeCategory = true
        label.adjustsFontSizeToFitWidth = true
        
        return label
    }()
    
    let watchGradeNameDetailLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.minimumScaleFactor = 0.3
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.adjustsFontForContentSizeCategory = true
        label.adjustsFontSizeToFitWidth = true
        
        return label
    }()
    
    private let nationNameContentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 4
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        
        return stackView
    }()
    
    private let nationNameTitleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "제작국가"
        label.font = UIFont.preferredFont(for: .title3, weight: .heavy)
        label.minimumScaleFactor = 0.3
        label.adjustsFontForContentSizeCategory = true
        label.adjustsFontSizeToFitWidth = true
        
        return label
    }()
    
    let nationNameDetailLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.minimumScaleFactor = 0.3
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.adjustsFontForContentSizeCategory = true
        label.adjustsFontSizeToFitWidth = true
        
        return label
    }()
    
    private let genreNameContentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 4
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        
        return stackView
    }()
    
    private let genreNameTitleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "장르"
        label.font = UIFont.preferredFont(for: .title3, weight: .heavy)
        label.minimumScaleFactor = 0.3
        label.adjustsFontForContentSizeCategory = true
        label.adjustsFontSizeToFitWidth = true
        
        return label
    }()
    
    let genreNameDetailLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.minimumScaleFactor = 0.3
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.adjustsFontForContentSizeCategory = true
        label.adjustsFontSizeToFitWidth = true
        
        return label
    }()
    
    private let actorsContentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 4
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        
        return stackView
    }()
    
    private let actorsTitleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "배우"
        label.font = UIFont.preferredFont(for: .title3, weight: .heavy)
        label.minimumScaleFactor = 0.3
        label.adjustsFontForContentSizeCategory = true
        label.adjustsFontSizeToFitWidth = true
        
        return label
    }()
    
    let actorsDetailLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.minimumScaleFactor = 0.3
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.adjustsFontForContentSizeCategory = true
        label.adjustsFontSizeToFitWidth = true
        
        return label
    }()
    
    convenience init() {
        self.init(frame: CGRectZero)
        
        configureUI()
        setUpConstraints()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(posterImage)
        contentView.addSubview(totalStackView)
        [directorContentStackView, productionYearContentStackView, openDateContentStackView, showTimeContentStackView, watchGradeNameContentStackView, nationNameContentStackView, genreNameContentStackView, actorsContentStackView].forEach { totalStackView.addArrangedSubview($0) }
        [directorTitleLabel, directorDetailLabel].forEach { directorContentStackView.addArrangedSubview($0) }
        [productionYearTitleLabel, productionYearDetailLabel].forEach { productionYearContentStackView.addArrangedSubview($0) }
        [openDateTitleLabel, openDateDetailLabel].forEach { openDateContentStackView.addArrangedSubview($0) }
        [showTimeTitleLabel, showTimeDetailLabel].forEach { showTimeContentStackView.addArrangedSubview($0) }
        [watchGradeNameTitleLabel, watchGradeNameDetailLabel].forEach { watchGradeNameContentStackView.addArrangedSubview($0) }
        [nationNameTitleLabel, nationNameDetailLabel].forEach { nationNameContentStackView.addArrangedSubview($0) }
        [genreNameTitleLabel, genreNameDetailLabel].forEach { genreNameContentStackView.addArrangedSubview($0) }
        [actorsTitleLabel, actorsDetailLabel].forEach { actorsContentStackView.addArrangedSubview($0) }
    }
    
    private func setUpConstraints() {
        setUpScrollViewConstraints()
        setUpContentViewConstraints()
        setUpPosterImageViewConstraints()
        setUpTotalStackViewConstraints()
        setUpTitleLabelsAlign()
        setUpDetailLabelsAlign()
    }
}

// MARK: - Constraints
extension MovieDetailView {
    private func setUpScrollViewConstraints() {
        NSLayoutConstraint.activate([
            scrollView.frameLayoutGuide.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            scrollView.frameLayoutGuide.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            scrollView.frameLayoutGuide.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            scrollView.frameLayoutGuide.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func setUpContentViewConstraints() {
        NSLayoutConstraint.activate([
            contentView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            contentView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor, multiplier: 1)
        ])
        
        let contentViewHeightConstraints = contentView.heightAnchor.constraint(equalTo: scrollView.frameLayoutGuide.heightAnchor, constant: 1)
        contentViewHeightConstraints.priority = .init(1)
        contentViewHeightConstraints.isActive = true
    }
    
    private func setUpPosterImageViewConstraints() {
        NSLayoutConstraint.activate([
            posterImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            posterImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            posterImage.topAnchor.constraint(equalTo: contentView.topAnchor)
        ])
    }
    
    private func setUpTotalStackViewConstraints() {
        NSLayoutConstraint.activate([
            totalStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            totalStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            totalStackView.topAnchor.constraint(equalTo: posterImage.bottomAnchor, constant: 8),
            totalStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    private func setUpTitleLabelsAlign() {
        NSLayoutConstraint.activate([
            productionYearTitleLabel.centerXAnchor.constraint(equalTo: directorTitleLabel.centerXAnchor),
            openDateTitleLabel.centerXAnchor.constraint(equalTo: directorTitleLabel.centerXAnchor),
            showTimeTitleLabel.centerXAnchor.constraint(equalTo: directorTitleLabel.centerXAnchor),
            watchGradeNameTitleLabel.centerXAnchor.constraint(equalTo: directorTitleLabel.centerXAnchor),
            nationNameTitleLabel.centerXAnchor.constraint(equalTo: directorTitleLabel.centerXAnchor),
            genreNameTitleLabel.centerXAnchor.constraint(equalTo: directorTitleLabel.centerXAnchor),
            actorsTitleLabel.centerXAnchor.constraint(equalTo: directorTitleLabel.centerXAnchor)
        ])
    }
    
    private func setUpDetailLabelsAlign() {
        NSLayoutConstraint.activate([
            productionYearDetailLabel.leadingAnchor.constraint(equalTo: directorDetailLabel.leadingAnchor),
            openDateDetailLabel.leadingAnchor.constraint(equalTo: directorDetailLabel.leadingAnchor),
            showTimeDetailLabel.leadingAnchor.constraint(equalTo: directorDetailLabel.leadingAnchor),
            watchGradeNameDetailLabel.leadingAnchor.constraint(equalTo: directorDetailLabel.leadingAnchor),
            nationNameDetailLabel.leadingAnchor.constraint(equalTo: directorDetailLabel.leadingAnchor),
            genreNameDetailLabel.leadingAnchor.constraint(equalTo: directorDetailLabel.leadingAnchor),
            actorsDetailLabel.leadingAnchor.constraint(equalTo: directorDetailLabel.leadingAnchor)
        ])
    }
}
