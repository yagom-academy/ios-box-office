//
//  LoadingView.swift
//  BoxOffice
//
//  Created by JSB on 2023/08/09.
//

import UIKit

final class LoadingView: UIView {

    private let activityIndicator: UIActivityIndicatorView = {
        let activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
        activityIndicator.color = .systemRed
        activityIndicator.hidesWhenStopped = true
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.style = .large
        
        return activityIndicator
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
        setUpAutoLayout()
        activityIndicator.startAnimating()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func hide() {
        layer.zPosition = 0
        activityIndicator.stopAnimating()
    }
    
    private func configureView() {
        translatesAutoresizingMaskIntoConstraints = false
        layer.zPosition = 1
        backgroundColor = .systemBackground
        addSubview(activityIndicator)
        
    }
    
    private func setUpAutoLayout() {
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}
