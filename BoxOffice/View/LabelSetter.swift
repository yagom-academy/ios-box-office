//
//  LabelSetter.swift
//  BoxOffice
//
//  Created by 리지, kokkilE on 2023/04/04.
//

import UIKit

protocol LabelSetter {
    func configureLabels(_ movieRankLabel: UILabel, _ audienceVarianceLabel: UILabel, _ movieListLabel: UILabel, and audienceInformationLabel: UILabel)
}
