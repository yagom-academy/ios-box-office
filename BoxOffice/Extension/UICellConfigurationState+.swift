//
//  UICellConfigurationState+.swift
//  BoxOffice
//
//  Created by Kobe, yyss99 on 2023/08/06.
//

import UIKit

extension UICellConfigurationState {
    var item: DailyBoxOfficeList? {
        get { return self[.item] as? DailyBoxOfficeList }
        set { self[.item] = newValue}
    }
}
