//
//  ContentStackView.swift
//  BoxOffice
//
//  Created by karen on 2023/08/19.
//

import UIKit

final class ContentStackView: UIStackView {
    
    private var categoryLabelWidthConstraint: NSLayoutConstraint?
    
    private let categoryLabel = UILabel(fontStyle: UIFontMetrics(forTextStyle: .headline).scaledFont(for: UIFont.systemFont(ofSize: 12, weight: .bold)))
    private let contentLabel = UILabel(fontStyle: UIFontMetrics(forTextStyle: .headline).scaledFont(for: UIFont.systemFont(ofSize: 12)), numberOfLine: 0)
    
    convenience init(categoryText: String) {
        self.init(frame: CGRect.zero)
        setupUI(categoryText: categoryText)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateContentText(_ contentText: String) {
        contentLabel.text = contentText
    }
    
    private func updateCategoryLabelWidth(by multiplier: CGFloat) {
        guard let previousWidthConstraint = categoryLabelWidthConstraint else { return }
        
        NSLayoutConstraint.deactivate([previousWidthConstraint])
        
        categoryLabelWidthConstraint = categoryLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: multiplier)
        categoryLabelWidthConstraint?.isActive = true
    }
    
    private func calculateCategoryLabelWidthMultiplier() -> CGFloat {
        switch traitCollection.preferredContentSizeCategory {
        case .accessibilityExtraExtraExtraLarge:
            return 0.3
        case .accessibilityExtraExtraLarge, .accessibilityExtraLarge, .accessibilityLarge:
            return 0.25
        default:
            return 0.15
        }
    }
    
    @objc private func contentSizeCategoryChange() {
        let widthMultiplier = calculateCategoryLabelWidthMultiplier()
        updateCategoryLabelWidth(by: widthMultiplier)
    }
}

// MARK: - UI Configuration
extension ContentStackView {
    private func setupUI(categoryText: String? = nil) {
        translatesAutoresizingMaskIntoConstraints = false
        addArrangedSubview(categoryLabel)
        addArrangedSubview(contentLabel)
        spacing = 5
        
        let widthMultiplier = calculateCategoryLabelWidthMultiplier()
        categoryLabelWidthConstraint = categoryLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: widthMultiplier)
        categoryLabelWidthConstraint?.isActive = true
        
        if let categoryText = categoryText {
            categoryLabel.textAlignment = .center
            categoryLabel.text = categoryText
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(contentSizeCategoryChange), name: UIContentSizeCategory.didChangeNotification, object: nil)
    }
}

