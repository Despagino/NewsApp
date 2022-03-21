//
//  NewsAPI.swift
//  NewsApp
//
//  Created by Gino Tasis on 3/21/22.
//

import Foundation

struct NewsAPI {
    
    static let shared = NewsAPI()
    private init() {}
    
    private let apiKey = "154df729ec3f4e488025288e328897af"
    private let session = URLSession.shared
    private let jsonDecoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return decoder
    }()
    
    func fetch(from category: Category) async throws -> [Article] {
        
        let url = generalNewsURL(from: category)
        let (data, response) = try await session.data(from: url)
        
        guard let response = response as? HTTPURLResponse else {
            
            throw generateErrorCode(description: "Bad Response")
        }
        
        switch response.statusCode {
            
        case (200...299), (400...499):
            
            let apiResponse = try jsonDecoder.decode(NewsAPIResponse.self, from: data)
            if apiResponse.status == "ok" {
                return apiResponse.articles ?? []
            } else {
                throw generateErrorCode(description: apiResponse.message ?? "An error occured")
            }
            
        default:
            throw generateErrorCode(description: "An server error occured")
        }
    }
    
        // created helper function so that we dont have to always type it out
    private func generateErrorCode(code: Int = 1, description: String) -> Error {
        NSError(domain: "NewsAPI", code: code, userInfo: [NSLocalizedDescriptionKey: description])
    }
    
    private func generalNewsURL(from category: Category) -> URL {
        var url = "https://newsapi.org/v2/top-headlines?"
        url += "apiKey=\(apiKey)"
        url += "&language=en"
        url += "&category=\(category.rawValue)"
        return URL(string: url)!
    }
}
