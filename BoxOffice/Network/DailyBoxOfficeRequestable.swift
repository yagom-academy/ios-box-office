//
//  DailyBoxOfficeRequestable.swift
//  BoxOffice
//
//  Created by 리지, kokkilE on 2023/03/21.
//

protocol DailyBoxOfficeRequestable {
    var key: String { get }
    var targetDate: String { get }
    var itemPerPage: String? { get }
    var movieType: MovieType? { get }
    var nationalCode: NationalCode? { get }
    var wideAreaCode: String? { get }
}
