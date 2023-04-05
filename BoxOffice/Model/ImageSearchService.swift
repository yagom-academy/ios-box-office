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
            guard let data = try? Data(contentsOf: url) else { return }

            completion(data)
        }
    }
}
