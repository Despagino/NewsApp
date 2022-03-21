//
//  Article.swift
//  NewsApp
//
//  Created by Gino Tasis on 3/21/22.
//

import Foundation

struct Article {
    
    let source: Source

    let title: String
    let url: String
    let publishedAt: Date
    
    let author: String?
    let description: String?
    let urlToImage: String?
        
    var authorText: String {
        author ?? ""
    }
    
    var descriptionText: String {
        description ?? ""
    }
    
    var imageURL: URL? {
        guard let urlToImage = urlToImage else {
            return nil
        }
        return URL(string: urlToImage)
    }
    
    var articleURL: URL {
        URL(string: url)!
    }
}

//parsing the JSON data we get
extension Article: Codable {}
// comparing the data with one another so we can delete
extension Article: Equatable {}
// so we can pass data around
extension Article: Identifiable {
    var id: String {url}
}

struct Source {
    let name: String
}

extension Source: Codable {}
extension Source: Equatable {}

extension Article {
    static var previewData: [Article] {
        let previewDataURL = Bundle.main.url(forResource: "news", withExtension: "json")!
        let data = try! Data(contentsOf: previewDataURL)
        let jsonDecoder = JSONDecoder()
        
        // using this format we will conform to the swift native date type
        jsonDecoder.dateDecodingStrategy = .iso8601
        
        let apiResponses = try! jsonDecoder.decode(NewsAPIResponse.self, from: data)
        return apiResponses.articles ?? []
    }
}
