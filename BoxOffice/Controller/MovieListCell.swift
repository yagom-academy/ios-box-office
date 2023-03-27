//
//  MovieListCell.swift
//  BoxOffice
//
//  Created by 리지, kokkilE on 2023/03/27.
//

import UIKit

@available(iOS 14.0, *)
class ItemListCell: UICollectionViewListCell {
    var item: DailyBoxOffice.BoxOfficeResult.Movie? = nil
    
    func updateWithItem(_ newItem: DailyBoxOffice.BoxOfficeResult.Movie) {
        guard item != newItem else { return }
        item = newItem
        setNeedsUpdateConfiguration()
    }
    
    override var configurationState: UICellConfigurationState {
        var state = super.configurationState
        state.item = self.item
        return state
    }
}

@available(iOS 14.0, *)
class CustomListCell: ItemListCell {
    
    func defaultListContentConfiguration() -> UIListContentConfiguration { return .subtitleCell() }
    lazy var listContentView = UIListContentView(configuration: defaultListContentConfiguration())
    
    let movieRank = UILabel()
    let categoryLabel = UILabel()
    var customViewConstraints: (categoryLabelLeading: NSLayoutConstraint,
                                        categoryLabelTrailing: NSLayoutConstraint,
                                        categoryIconTrailing: NSLayoutConstraint)?
    
    func setupViewsIfNeeded() {
        // We only need to do anything if we haven't already setup the views and created constraints.
        guard customViewConstraints == nil else { return }
        
        contentView.addSubview(listContentView)
        contentView.addSubview(categoryLabel)
        contentView.addSubview(movieRank)
        listContentView.translatesAutoresizingMaskIntoConstraints = false
        let defaultHorizontalCompressionResistance = listContentView.contentCompressionResistancePriority(for: .horizontal)
        listContentView.setContentCompressionResistancePriority(defaultHorizontalCompressionResistance - 1, for: .horizontal)
        categoryLabel.translatesAutoresizingMaskIntoConstraints = false
        movieRank.translatesAutoresizingMaskIntoConstraints = false
        let constraints = (
            categoryLabelLeading: categoryLabel.leadingAnchor.constraint(greaterThanOrEqualTo: listContentView.trailingAnchor),
            categoryLabelTrailing: movieRank.leadingAnchor.constraint(equalTo: categoryLabel.trailingAnchor),
            categoryIconTrailing: contentView.trailingAnchor.constraint(equalTo: movieRank.trailingAnchor)
        )
        NSLayoutConstraint.activate([
            listContentView.topAnchor.constraint(equalTo: contentView.topAnchor),
            listContentView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            listContentView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            categoryLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            movieRank.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            constraints.categoryLabelLeading,
            constraints.categoryLabelTrailing,
            constraints.categoryIconTrailing
        ])
        customViewConstraints = constraints
    }
    
    var separatorConstraint: NSLayoutConstraint?
    func updateSeparatorConstraint() {
        guard let textLayoutGuide = listContentView.textLayoutGuide else { return }
        if let existingConstraint = separatorConstraint, existingConstraint.isActive {
            return
        }
        let constraint = separatorLayoutGuide.leadingAnchor.constraint(equalTo: textLayoutGuide.leadingAnchor)
        constraint.isActive = true
        separatorConstraint = constraint
    }
    
    /// - Tag: UpdateConfiguration
    override func updateConfiguration(using state: UICellConfigurationState) {
        setupViewsIfNeeded()
        
        // Configure the list content configuration and apply that to the list content view.
        var content = defaultListContentConfiguration().updated(for: state)
        content.imageProperties.preferredSymbolConfiguration = .init(font: content.textProperties.font, scale: .large)
//        content.image = state.item?.rank
        content.secondaryText = state.item?.rank
        content.text = state.item?.name
//        content.secondaryText = state.item?.description
        content.axesPreservingSuperviewLayoutMargins = []
        listContentView.configuration = content
        
        // Get the list value cell configuration for the current state, which we'll use to obtain the system default
        // styling and metrics to copy to our custom views.
        let valueConfiguration = UIListContentConfiguration.valueCell().updated(for: state)
        
        // Configure custom image view for the category icon, copying some of the styling from the value cell configuration.
//        categoryIconView.image = state.item?.category.icon
        movieRank.tintColor = valueConfiguration.imageProperties.resolvedTintColor(for: tintColor)
//        movieRank.preferredSymbolConfiguration = .init(font: valueConfiguration.secondaryTextProperties.font, scale: .small)
        
        // Configure custom label for the category name, copying some of the styling from the value cell configuration.
//        categoryLabel.text = state.item?.category.name
        categoryLabel.textColor = valueConfiguration.secondaryTextProperties.resolvedColor()
        categoryLabel.font = valueConfiguration.secondaryTextProperties.font
        categoryLabel.adjustsFontForContentSizeCategory = valueConfiguration.secondaryTextProperties.adjustsFontForContentSizeCategory
        
        // Update some of the constraints for our custom views using the system default metrics from the configurations.
        customViewConstraints?.categoryLabelLeading.constant = content.directionalLayoutMargins.trailing
        customViewConstraints?.categoryLabelTrailing.constant = valueConfiguration.textToSecondaryTextHorizontalPadding
        customViewConstraints?.categoryIconTrailing.constant = content.directionalLayoutMargins.trailing
        updateSeparatorConstraint()
    }
}
