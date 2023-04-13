//
//  MovieDetailScrollView.swift
//  BoxOffice
//
//  Created by goat, songjung on 2023/03/30.
//

import UIKit

class MovieDetailView: UIView {
    
    let movieDetailScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let verticalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        return stackView
    }()
    
    lazy var directorStackView = makeHorizontalStackView()
    lazy var productYearStackView  = makeHorizontalStackView()
    lazy var openDayStackView = makeHorizontalStackView()
    lazy var showTimeStackView = makeHorizontalStackView()
    lazy var auditsStackView = makeHorizontalStackView()
    lazy var nationsStackView = makeHorizontalStackView()
    lazy var genreStackView = makeHorizontalStackView()
    lazy var actorStackView = makeHorizontalStackView()

    lazy var directorTitleLabel = makeTitleLabel()
    lazy var directorDataLabel = makeDataLabel()

    lazy var  productYearTitleLabel = makeTitleLabel()
    lazy var productYearDataLabel = makeDataLabel()
   
    lazy var  openDayTitleLabel = makeTitleLabel()
    lazy var openDayDataLabel = makeDataLabel()
    
    lazy var showTimeTitleLabel = makeTitleLabel()
    lazy var showTimeDataLabel = makeDataLabel()
    
    lazy var auditsTitleLabel = makeTitleLabel()
    lazy var auditsDataLabel = makeDataLabel()
    
    lazy var nationTitleLabel = makeTitleLabel()
    lazy var nationDataLabel = makeDataLabel()
    
    lazy var genreTitleLabel = makeTitleLabel()
    lazy var genreDataLabel = makeDataLabel()
    
    lazy var actorTitleLabel = makeTitleLabel()
    lazy var actorDataLabel = makeDataLabel()
   
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
        self.backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func makeHorizontalStackView() -> UIStackView {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 6
        return stackView
    }
    
    private func makeTitleLabel() -> UILabel {
        let label = UILabel()
        label.textAlignment = .center
        label.adjustsFontForContentSizeCategory = true
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        return label
    }
    
    private func makeDataLabel() -> UILabel {
        let label = UILabel()
        label.textAlignment = .left
        label.numberOfLines = 0
        label.adjustsFontForContentSizeCategory = true
        label.font = UIFont.preferredFont(forTextStyle: .callout)
        return label
    }
    
    private func configureUI() {
        let safeArea = safeAreaLayoutGuide
        self.addSubview(movieDetailScrollView)
        
        movieDetailScrollView.addSubview(contentView)
        contentView.addSubview(imageView)
        contentView.addSubview(verticalStackView)

        verticalStackView.addArrangedSubview(directorStackView)
        verticalStackView.addArrangedSubview(productYearStackView)
        verticalStackView.addArrangedSubview(openDayStackView)
        verticalStackView.addArrangedSubview(showTimeStackView)
        verticalStackView.addArrangedSubview(auditsStackView)
        verticalStackView.addArrangedSubview(nationsStackView)
        verticalStackView.addArrangedSubview(genreStackView)
        verticalStackView.addArrangedSubview(actorStackView)

        directorStackView.addArrangedSubview(directorTitleLabel)
        directorStackView.addArrangedSubview(directorDataLabel)

        productYearStackView.addArrangedSubview(productYearTitleLabel)
        productYearStackView.addArrangedSubview(productYearDataLabel)

        openDayStackView.addArrangedSubview(openDayTitleLabel)
        openDayStackView.addArrangedSubview(openDayDataLabel)

        showTimeStackView.addArrangedSubview(showTimeTitleLabel)
        showTimeStackView.addArrangedSubview(showTimeDataLabel)

        auditsStackView.addArrangedSubview(auditsTitleLabel)
        auditsStackView.addArrangedSubview(auditsDataLabel)

        nationsStackView.addArrangedSubview(nationTitleLabel)
        nationsStackView.addArrangedSubview(nationDataLabel)

        genreStackView.addArrangedSubview(genreTitleLabel)
        genreStackView.addArrangedSubview(genreDataLabel)

        actorStackView.addArrangedSubview(actorTitleLabel)
        actorStackView.addArrangedSubview(actorDataLabel)
        
        NSLayoutConstraint.activate([
            movieDetailScrollView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            movieDetailScrollView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            movieDetailScrollView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
            movieDetailScrollView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            
            contentView.topAnchor.constraint(equalTo: movieDetailScrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: movieDetailScrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: movieDetailScrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: movieDetailScrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: movieDetailScrollView.widthAnchor),
            
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 14),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -14),
            
            imageView.heightAnchor.constraint(equalToConstant: 400),
            
            verticalStackView.topAnchor.constraint(equalTo: imageView.bottomAnchor),
            verticalStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            verticalStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            verticalStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            directorTitleLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: 70),
            productYearTitleLabel.widthAnchor.constraint(equalTo: directorTitleLabel.widthAnchor),
            openDayTitleLabel.widthAnchor.constraint(equalTo: directorTitleLabel.widthAnchor),
            showTimeTitleLabel.widthAnchor.constraint(equalTo: directorTitleLabel.widthAnchor),
            auditsTitleLabel.widthAnchor.constraint(equalTo: directorTitleLabel.widthAnchor),
            nationTitleLabel.widthAnchor.constraint(equalTo: directorTitleLabel.widthAnchor),
            genreTitleLabel.widthAnchor.constraint(equalTo: directorTitleLabel.widthAnchor),
            actorTitleLabel.widthAnchor.constraint(equalTo: directorTitleLabel.widthAnchor)
           
        ])
    }
}

