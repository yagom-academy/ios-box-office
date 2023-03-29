//
//  RankStackView.swift
//  BoxOffice
//
//  Created by Christy, Hyemory on 2023/03/28.
//

import UIKit

final class RankStackView: UIStackView {
    let rankLabel: UILabel = {
        let label = UILabel()
        
        label.font = .preferredFont(forTextStyle: .title1)
        
        return label
    }()
    
    let rankInfoLabel: UILabel = {
        let label = UILabel()
        
        label.font = .preferredFont(forTextStyle: .caption1)
        
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
        self.alignment = .center
        
        self.addArrangedSubview(rankLabel)
        self.addArrangedSubview(rankInfoLabel)
    }
}
