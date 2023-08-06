//
//  URL+.swift
//  BoxOffice
//
//  Created by karen on 2023/08/06.
//

import Foundation

extension URL {
    init?(apiType: KobisAPIType) {
        guard let urlComponents = apiType.urlComponents else {
            return nil
        }

        guard let url = urlComponents.url else {
            return nil
        }

        self = url
    }
}
