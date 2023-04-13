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
        
        urlRequest.cachePolicy = .returnCacheDataElseLoad
        
        let dataTask = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            guard error == nil else { return }
            
            guard let httpURLResponse = response as? HTTPURLResponse, (200...299).contains(httpURLResponse.statusCode) else { return }
            
            guard let validData = data else { return }
            
            let cacheURLResponse = CachedURLResponse(response: httpURLResponse, data: validData, storagePolicy: .allowedInMemoryOnly)
            
            URLCache.shared.storeCachedResponse(cacheURLResponse, for: urlRequest)
            
            completion(validData)
        }
        
        URLCache.shared.getCachedResponse(for: dataTask) { cachedResponse in
            if let cachedResponse = cachedResponse {
                print("캐시 정상 작동")
                completion(cachedResponse.data)
            } else {
                print("캐시 데이터 없음")
                dataTask.resume()
            }
        }
    }
    
    func removeCache() {
        print("캐시 지워짐")
        URLCache.shared.removeAllCachedResponses()
    }
}
