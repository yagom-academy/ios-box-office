//
//  MovieService.swift
//  BoxOffice
//
//  Created by Idinaloq, MARY on 2023/07/27.
//

import Foundation

struct MovieService {
    func fetchData() {
        guard let url = APIConstants().receiveDailyBoxOfficeURL() else { return }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                        (200...299).contains(httpResponse.statusCode) else {
                        return
                    }
            
            if let data = data,
               let decodedData = try? JSONDecoder().decode(BoxOffice.self, from: data) {
                print(decodedData)
            }
        }
        
        task.resume()
    }
}
