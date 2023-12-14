//
//  HTTPHeaderField.swift
//  BoxOffice
//
//  Created by Toy, Morgan on 12/12/23.
//
enum HTTPHeaderField: String {
    case contentType = "Content-Type"
    case contentEncoding = "Content-Encoding"
    case contentLanguage = "Content-Language"
}

enum MIME: String {
    case html = "text/html"
    case json = "application/json"
    case iamge = "image"
    case gzip
    case deflate
    case identity

}
