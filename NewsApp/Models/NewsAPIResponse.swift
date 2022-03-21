//
//  NewsAPIResponse.swift
//  NewsApp
//
//  Created by Gino Tasis on 3/21/22.
//

import Foundation

struct NewsAPIResponse: Decodable {
    
    let status: String
    let totalResults: Int?
    let articles: [Article]?
    
    let code: String?
    let message: String?

    
}
