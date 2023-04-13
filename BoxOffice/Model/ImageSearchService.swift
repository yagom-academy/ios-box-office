//
//  ImageSearchService.swift
//  BoxOffice
//
//  Created by goat,songjun on 2023/04/05.
//

import Foundation

class ImageSearchService {
    private let provider = Provider()
    private var searchedImage: ImageSearch?
    
    func fetchSearchedImage(boxOfficeService: BoxOfficeService, completion: @escaping (Data) -> Void) {
    
        guard let movieName = boxOfficeService.movieDetail?.movieInformationResult.movieInformation.movieName else { return }

        var imageSearchEndpoint = ImageSearchEndpoint()
        imageSearchEndpoint.insertImageQueryValue(imageName: movieName)
        
        provider.loadBoxOfficeAPI(endpoint: imageSearchEndpoint, parser: Parser<ImageSearch>()) {
            parsedData in
           
            guard let url = URL(string: parsedData.imageDatas[0].imageURL) else { return }
            self.loadImageURL(url: url) { data in
                completion(data)
            }

        }
    }
    
    func loadImageURL(url: URL, completion: @escaping (Data) -> Void){ // Renaming 필요
    
        var urlRequest = URLRequest(url: url)
        
        urlRequest.httpMethod = "GET"
        
        let dataTask = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            guard error == nil else { return }
            
            guard let httpURLResponse = response as? HTTPURLResponse, (200...299).contains(httpURLResponse.statusCode) else { return }
            
            guard let validData = data else { return }
            
            completion(validData)
        }
        
        dataTask.resume()
    }
}
