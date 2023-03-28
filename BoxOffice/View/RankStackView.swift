//
//  RankStackView.swift
//  BoxOffice
//
//  Created by Christy, Hyemory on 2023/03/28.
//

import UIKit

final class RankStackView: UIStackView {
    private let rankLabel: UILabel = {
        let label = UILabel()
        
        label.font = .preferredFont(forTextStyle: .title1)
        
        return label
    }()
    
    private let rankInfoLabel: UILabel = {
        let label = UILabel()
        
        label.font = .preferredFont(forTextStyle: .body)
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureRankStackView()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureRankStackView() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.axis = .vertical
        self.spacing = 4
        
        self.addArrangedSubview(rankLabel)
        self.addArrangedSubview(rankInfoLabel)
    }
}
