//
//  DetailMovieInfoView.swift
//  BoxOffice
//
//  Created by Seoyeon Hong on 2023/03/31.
//

import UIKit

final class MovieInfoView: UIView {
    
    var titleLabel = UILabel()
    var contentLabel = UILabel()
    
    init(frame: CGRect = .zero, title: String, content: String) {
        super.init(frame: frame)
        titleLabel.text = title
        contentLabel.text = content
        contentLabel.numberOfLines = 0
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        addSubview(titleLabel)
        addSubview(contentLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.widthAnchor.constraint(equalToConstant: 100),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            contentLabel.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            contentLabel.topAnchor.constraint(equalTo: topAnchor),
            contentLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            contentLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.textAlignment = .center
        titleLabel.font = .systemFont(ofSize: 16, weight: .bold)
        
        contentLabel.translatesAutoresizingMaskIntoConstraints = false
        contentLabel.font = .systemFont(ofSize: 16)
    }
    
}
