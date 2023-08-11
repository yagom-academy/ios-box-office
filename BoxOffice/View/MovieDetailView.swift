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
        image.backgroundColor = .systemGray6
        
        return image
    }()
    
    private let loadingImage: UIImageView = {
        let image = UIImageView()
        let beanEaters: [UIImage] = (0...29).map { UIImage(named: String(format: "%02d", $0)) ?? UIImage() }
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        image.image = UIImage.animatedImage(with: beanEaters, duration: 0.35)
        
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
    
    private let directorContentStackView = LabelsStack()
    private let directorTitleLabel = TitleLabel(title: MovieDetailNameSpace.director)
    let directorDetailLabel = DetailLabel()
    
    private let productionYearContentStackView = LabelsStack()
    private let productionYearTitleLabel = TitleLabel(title: MovieDetailNameSpace.productionYear)
    let productionYearDetailLabel = DetailLabel()
    
    private let openDateContentStackView = LabelsStack()
    private let openDateTitleLabel = TitleLabel(title: MovieDetailNameSpace.openDate)
    let openDateDetailLabel = DetailLabel()
    
    private let showTimeContentStackView = LabelsStack()
    private let showTimeTitleLabel = TitleLabel(title: MovieDetailNameSpace.showTime)
    let showTimeDetailLabel = DetailLabel()
    
    private let watchGradeNameContentStackView = LabelsStack()
    private let watchGradeNameTitleLabel = TitleLabel(title: MovieDetailNameSpace.watchGradeName)
    let watchGradeNameDetailLabel = DetailLabel()
    
    private let nationNameContentStackView = LabelsStack()
    private let nationNameTitleLabel = TitleLabel(title: MovieDetailNameSpace.nationName)
    let nationNameDetailLabel = DetailLabel()
    
    private let genreNameContentStackView = LabelsStack()
    private let genreNameTitleLabel = TitleLabel(title: MovieDetailNameSpace.genreName)
    let genreNameDetailLabel = DetailLabel()
    
    private let actorsContentStackView = LabelsStack()
    private let actorTitleLabel = TitleLabel(title: MovieDetailNameSpace.actor)
    let actorDetailLabel = DetailLabel()
    
    convenience init() {
        self.init(frame: CGRectZero)
        
        configureUI()
        setupConstraints()
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
        [actorTitleLabel, actorDetailLabel].forEach { actorsContentStackView.addArrangedSubview($0) }
    }
    
    private func setupConstraints() {
        setupScrollViewConstraints()
        setupContentViewConstraints()
        setupPosterImageViewConstraints()
        setupTotalStackViewConstraints()
        setupTitleLabelsAlign()
        setupDetailLabelsAlign()
    }
}

// MARK: - Constraints
extension MovieDetailView {
    private func setupScrollViewConstraints() {
        NSLayoutConstraint.activate([
            scrollView.frameLayoutGuide.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            scrollView.frameLayoutGuide.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            scrollView.frameLayoutGuide.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            scrollView.frameLayoutGuide.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func setupContentViewConstraints() {
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
    
    private func setupPosterImageViewConstraints() {
        NSLayoutConstraint.activate([
            posterImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            posterImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            posterImage.topAnchor.constraint(equalTo: contentView.topAnchor)
        ])
    }

    private func setupLoadingImageViewConstraints() {
        NSLayoutConstraint.activate([
            loadingImage.centerXAnchor.constraint(equalTo: centerXAnchor),
            loadingImage.centerYAnchor.constraint(equalTo: posterImage.centerYAnchor),
            loadingImage.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.25),
            loadingImage.heightAnchor.constraint(equalTo: loadingImage.widthAnchor)
        ])
    }
    
    private func setupTotalStackViewConstraints() {
        NSLayoutConstraint.activate([
            totalStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            totalStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            totalStackView.topAnchor.constraint(equalTo: posterImage.bottomAnchor, constant: 8),
            totalStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    private func setupTitleLabelsAlign() {
        NSLayoutConstraint.activate([
            productionYearTitleLabel.centerXAnchor.constraint(equalTo: directorTitleLabel.centerXAnchor),
            openDateTitleLabel.centerXAnchor.constraint(equalTo: directorTitleLabel.centerXAnchor),
            showTimeTitleLabel.centerXAnchor.constraint(equalTo: directorTitleLabel.centerXAnchor),
            watchGradeNameTitleLabel.centerXAnchor.constraint(equalTo: directorTitleLabel.centerXAnchor),
            nationNameTitleLabel.centerXAnchor.constraint(equalTo: directorTitleLabel.centerXAnchor),
            genreNameTitleLabel.centerXAnchor.constraint(equalTo: directorTitleLabel.centerXAnchor),
            actorTitleLabel.centerXAnchor.constraint(equalTo: directorTitleLabel.centerXAnchor)
        ])
    }
    
    private func setupDetailLabelsAlign() {
        NSLayoutConstraint.activate([
            productionYearDetailLabel.leadingAnchor.constraint(equalTo: directorDetailLabel.leadingAnchor),
            openDateDetailLabel.leadingAnchor.constraint(equalTo: directorDetailLabel.leadingAnchor),
            showTimeDetailLabel.leadingAnchor.constraint(equalTo: directorDetailLabel.leadingAnchor),
            watchGradeNameDetailLabel.leadingAnchor.constraint(equalTo: directorDetailLabel.leadingAnchor),
            nationNameDetailLabel.leadingAnchor.constraint(equalTo: directorDetailLabel.leadingAnchor),
            genreNameDetailLabel.leadingAnchor.constraint(equalTo: directorDetailLabel.leadingAnchor),
            actorDetailLabel.leadingAnchor.constraint(equalTo: directorDetailLabel.leadingAnchor)
        ])
    }
}

// MARK: - Loading Image
extension MovieDetailView {
    func startLoadingImage() {
        addSubview(loadingImage)
        setupLoadingImageViewConstraints()
    }
    
    func stopLoadingImage() {
        loadingImage.removeFromSuperview()
    }
}
