//
//  Endpoint.swift
//  BoxOffice
//
//  Created by Toy, Morgan on 12/12/23.
//
import Foundation

struct Endpoint {
    private let api: API
    private let queryItems:[URLQueryItem]
    private let httpMethod: HTTPMethod
    private let httpHeaderField: HTTPHeaderField
    private let mime: MIME

    init(api: API, queryItems: [URLQueryItem], httpMethod: HTTPMethod, httpHeaderField: HTTPHeaderField, mime: MIME = MIME.json) {
        self.api = api
        self.queryItems = queryItems
        self.httpMethod = httpMethod
        self.httpHeaderField = httpHeaderField
        self.mime = mime
    }

    func asURLRequest() throws -> URLRequest {
        guard let url = api.getURL(apikey: Key.movieDataApiKey, queryItems: queryItems) else { throw URLError.invalidURL }

        var request = URLRequest(url: url)
        request.httpMethod = httpMethod.rawValue
        request.addValue(mime.rawValue, forHTTPHeaderField: httpHeaderField.rawValue)

        return request
    }
}
