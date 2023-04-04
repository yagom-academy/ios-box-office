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
    let directorDataLabel = UILabel()

    lazy var  productYearTitleLabel = makeTitleLabel()
    let productYearDataLabel = UILabel()
   
    lazy var  openDayTitleLabel = makeTitleLabel()
    let openDayDataLabel = UILabel()
    
    lazy var showTimeTitleLabel = makeTitleLabel()
    let showTimeDataLabel = UILabel()
    
    lazy var auditsTitleLabel = makeTitleLabel()
    let auditsDataLabel = UILabel()
    
    lazy var nationTitleLabel = makeTitleLabel()
    let nationDataLabel = UILabel()
    
    lazy var genreTitleLabel = makeTitleLabel()
    let genreDataLabel = UILabel()
    
    lazy var actorTitleLabel: UILabel = makeTitleLabel()
    let actorDataLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()
   
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
        return stackView
    }
    
    private func makeTitleLabel() -> UILabel {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 16)
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
            
            verticalStackView.topAnchor.constraint(equalTo: imageView.bottomAnchor),
            verticalStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            verticalStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            verticalStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            directorTitleLabel.widthAnchor.constraint(equalToConstant: 70),
            productYearTitleLabel.widthAnchor.constraint(equalToConstant: 70),
            openDayTitleLabel.widthAnchor.constraint(equalToConstant: 70),
            showTimeTitleLabel.widthAnchor.constraint(equalToConstant: 70),
            auditsTitleLabel.widthAnchor.constraint(equalToConstant: 70),
            nationTitleLabel.widthAnchor.constraint(equalToConstant: 70),
            genreTitleLabel.widthAnchor.constraint(equalToConstant: 70),
            actorTitleLabel.widthAnchor.constraint(equalToConstant: 70)
            
        ])
    }
}


