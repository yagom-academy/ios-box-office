//
//  BoxOfficeListCell.swift
//  BoxOffice
//
//  Created by goat, songjun on 2023/03/23.
//

import UIKit

class BoxOfficeListCell: UICollectionViewListCell  {
    
    @IBOutlet weak var rankNumberLabel: UILabel!
    @IBOutlet weak var rankGapLabel: UILabel!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var audienceCountLabel: UILabel!
    
    private let rankStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fill
        
        return stackView
    }()
    
    private let titleAndAudienceStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        
        return stackView
    }()
    
    private let iconTypeStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 10
        return stackView
    }()
    
    func configureListCellUI() {
        setUpLabelStyle()
        self.layer.borderWidth = 0.2
        self.layer.borderColor = UIColor.lightGray.cgColor
        
        rankNumberLabel.translatesAutoresizingMaskIntoConstraints = false
        rankGapLabel.translatesAutoresizingMaskIntoConstraints = false
        movieTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        audienceCountLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(rankStackView)
        self.addSubview(titleAndAudienceStackView)
        
        rankStackView.addArrangedSubview(rankNumberLabel)
        rankStackView.addArrangedSubview(rankGapLabel)
        
        titleAndAudienceStackView.addArrangedSubview(movieTitleLabel)
        titleAndAudienceStackView.addArrangedSubview(audienceCountLabel)
        
        NSLayoutConstraint.activate([
            rankStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            rankStackView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            
            titleAndAudienceStackView.leadingAnchor.constraint(equalTo: rankStackView.trailingAnchor,constant: 20),
            titleAndAudienceStackView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            titleAndAudienceStackView.trailingAnchor.constraint(lessThanOrEqualTo: self.trailingAnchor, constant: -20)
        ])
    }
    
    func configureIconCellUI() {
        setUpLabelStyle()
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.black.cgColor
        self.addSubview(iconTypeStackView)
        
        iconTypeStackView.addArrangedSubview(rankNumberLabel)
        iconTypeStackView.addArrangedSubview(movieTitleLabel)
        iconTypeStackView.addArrangedSubview(rankGapLabel)
        iconTypeStackView.addArrangedSubview(audienceCountLabel)
        
        NSLayoutConstraint.activate([
            iconTypeStackView.topAnchor.constraint(equalTo: self.topAnchor),
            iconTypeStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            iconTypeStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            iconTypeStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor,constant: -10)
            
        ])
    }
    
    private func setUpLabelStyle() {
        rankNumberLabel.font = UIFont.preferredFont(forTextStyle: .largeTitle)
        rankGapLabel.font = UIFont.preferredFont(forTextStyle: .subheadline)
        movieTitleLabel.font = UIFont.preferredFont(forTextStyle: .title3)
        audienceCountLabel.font = UIFont.preferredFont(forTextStyle: .subheadline)
        
        rankGapLabel.textAlignment = .center
        
    }
    
    func setUpLabel(by dailyBoxOffice: DailyBoxOffice, indexPath: IndexPath) {
        let audienceCount = dailyBoxOffice.boxOfficeResult.dailyBoxOfficeList[indexPath.row].audienceCount
        let audienceAccumulation = dailyBoxOffice.boxOfficeResult.dailyBoxOfficeList[indexPath.row].audienceAccumulation
        
        self.rankNumberLabel.text = dailyBoxOffice.boxOfficeResult.dailyBoxOfficeList[indexPath.row].rank
        self.rankGapLabel.attributedText = convertRankGapPresentation(dailyBoxOffice: dailyBoxOffice, indexPath: indexPath)
        self.movieTitleLabel.text = dailyBoxOffice.boxOfficeResult.dailyBoxOfficeList[indexPath.row].movieName
        self.audienceCountLabel.text = "오늘 " + audienceCount.insertComma() + " / 총 " + audienceAccumulation.insertComma()
    }
    
    private func convertRankGapPresentation(dailyBoxOffice: DailyBoxOffice, indexPath: IndexPath) -> NSMutableAttributedString {
        let rankGap = dailyBoxOffice.boxOfficeResult.dailyBoxOfficeList[indexPath.row].rankGap
        let rankOldAndNew = dailyBoxOffice.boxOfficeResult.dailyBoxOfficeList[indexPath.row].rankOldAndNew
        guard let intRankGap = Int(rankGap) else { return NSMutableAttributedString().makeColorToText(string: "", color: .red) }
        
        if rankOldAndNew == "NEW" {
            return NSMutableAttributedString().makeColorToText(string: "신작", color: .red)
        }
        
        switch intRankGap {
        case -20 ... -1:
            return NSMutableAttributedString().makeColorToText(string: "▼", color: .blue).makeColorToText(string: rankGap.trimmingCharacters(in: ["-"]), color: .black)
        case 1...20:
            return NSMutableAttributedString().makeColorToText(string: "▲", color: .red).makeColorToText(string: rankGap, color: .black)
        case 0:
            return NSMutableAttributedString().makeColorToText(string: "-", color: .black)
        default:
            return NSMutableAttributedString().makeColorToText(string: "", color: .black)
        }
    }
}
