//
//  MovieListCell.swift
//  BoxOffice
//
//  Created by Kiseok on 12/5/23.
//

import UIKit

class MovieListCell: UICollectionViewListCell {
    var movie: DailyBoxOfficeList?
    
    override func updateConfiguration(using state: UICellConfigurationState) {
        var newConfiguration = MovieConfiguration().updated(for: state)
        newConfiguration.rank = movie?.rank
        newConfiguration.rankFluctuation = movie?.rankFluctuation
        newConfiguration.movieName = movie?.movieName
        newConfiguration.audienceCount = movie?.audienceCount
        newConfiguration.audienceAccumulation = movie?.audienceAccumulation
        
        contentConfiguration = newConfiguration
        
        self.accessories = [.disclosureIndicator()]
    }
}
