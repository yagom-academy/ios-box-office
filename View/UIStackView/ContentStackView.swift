//
//  ContentStackView.swift
//  BoxOffice
//
//  Created by Andrew on 2023/04/03.
//

import UIKit

final class ContentStackView: UIStackView {
    
    private var labelWidthLayout: NSLayoutConstraint?

    private let categoryLabel = {
        let font = UIFont.systemFont(ofSize: 12, weight: .bold)
        let fontMatrics = UIFontMetrics(forTextStyle: .headline).scaledFont(for: font)
        let label = UILabel(fontStyle: fontMatrics)
        
        label.textAlignment = .center
        
        return label
    }()
    
    private let contentLabel = {
        let font = UIFont.systemFont(ofSize: 12)
        let fontMatrics = UIFontMetrics(forTextStyle: .headline).scaledFont(for: font)
        let label = UILabel(fontStyle: fontMatrics, numberOfLine: 0)
        
        return label
    }()

    convenience init(categoryText: String) {
        self.init(frame: CGRect.zero)
        configure()
        
        categoryLabel.text = categoryText
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateLabelText(_ contentText: String) {
        contentLabel.text = contentText
    }
    
    private func changeWidth(by multiplier: CGFloat) {
        guard let previousWidthLayout = labelWidthLayout else { return }
        
        NSLayoutConstraint.deactivate([
            previousWidthLayout
        ])
        
        labelWidthLayout = categoryLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: multiplier)
        labelWidthLayout?.isActive = true
    }
    
    private func makeWidthMultiplier() -> CGFloat {
        switch traitCollection.preferredContentSizeCategory {
        case .accessibilityExtraExtraExtraLarge:
            return 0.3
        case .accessibilityExtraExtraLarge,
             .accessibilityExtraLarge,
             .accessibilityLarge:
            return 0.25
        default:
            return 0.15
        }
    }
    
    @objc private func changeWidthMultiplier() {
        let mutiplierValue = makeWidthMultiplier()
        changeWidth(by: mutiplierValue)
    }
}

// MARK: UI
extension ContentStackView {
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        addArrangedSubview(categoryLabel)
        addArrangedSubview(contentLabel)
        spacing = 5
        
        let mutiplierValue = makeWidthMultiplier()
        
        labelWidthLayout = categoryLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: mutiplierValue)
        labelWidthLayout?.isActive = true
        
        NotificationCenter.default.addObserver(self, selector: #selector(changeWidthMultiplier), name: UIContentSizeCategory.didChangeNotification, object: nil)
    }
}
