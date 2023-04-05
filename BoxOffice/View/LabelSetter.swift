//
//  LabelSetter.swift
//  BoxOffice
//
//  Created by 리지, kokkilE on 2023/04/04.
//

import UIKit

protocol LabelSetter {
    func setupLabels(name: String, audienceInformation: String, rank: String, rankMark: String, audienceVariance: String, rankMarkColor: MovieRankMarkColor)
}
