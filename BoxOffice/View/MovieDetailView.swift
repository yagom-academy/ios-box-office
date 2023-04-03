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
    
    let directorStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        return stackView
    }()
    
    let productYearStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        return stackView
    }()
    
    let openDayStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        return stackView
    }()
    
    let showTimeStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        return stackView
    }()
    
    let auditsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        return stackView
    }()
    
    let nationsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        return stackView
    }()
    
    let genreStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        return stackView
    }()
    
    let actorStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        return stackView
    }()
    
    let directorTitleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    let directorDataLabel: UILabel = {
        let label = UILabel()
        
        return label
    }()
    
    let productYearTitleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    let productYearDataLabel: UILabel = {
        let label = UILabel()
        
        return label
    }()
   
    let openDayTitleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    let openDayDataLabel: UILabel = {
        let label = UILabel()
        
        return label
    }()
    
    let showTimeTitleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    let showTimeDataLabel: UILabel = {
        let label = UILabel()
        
        return label
    }()
    
    let auditsTitleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    let auditsDataLabel: UILabel = {
        let label = UILabel()
        
        return label
    }()
    
    let nationTitleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    let nationDataLabel: UILabel = {
        let label = UILabel()
        
        return label
    }()
    
    let genreTitleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    let genreDataLabel: UILabel = {
        let label = UILabel()
        
        return label
    }()
    
    let actorTitleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
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
    
    func configureUI() {
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


