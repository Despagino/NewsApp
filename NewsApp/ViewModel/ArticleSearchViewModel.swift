//
//  ArticleSearchViewModel.swift
//  NewsApp
//
//  Created by Gino Tasis on 3/22/22.
//

import Foundation

@MainActor
class ArticleSearchViewModel: ObservableObject {
    
    @Published var phase: DataFetchPhase<[Article]> = .empty
    @Published var searchQuery = ""
    @Published var history = [String]()
    
    private let historyMaxLimit = 10
    private let newsAPI = NewsAPI.shared
    
    func addHistory(_ text: String) {
        if let index = history.firstIndex(where: { text.lowercased() == $0.lowercased()}) {
            history.remove(at: index)
        } else if history.count == historyMaxLimit {
            history.remove(at: -1)
        }
        history.insert(text, at: 0)
    }
    
    func removeHistory(_ text: String) {
        
        
    }
    
    
    func searchArticle() async {
        
        if Task.isCancelled { return }
        
        let searchQuery = self.searchQuery.trimmingCharacters(in: .whitespacesAndNewlines)
        phase = .empty
        
        if searchQuery.isEmpty {
            return
        }
        
        do {
            let articles = try await newsAPI.search(for: searchQuery)
            if Task.isCancelled { return }
            phase = .success(articles)
        } catch {
            if Task.isCancelled { return }
            phase = .failure(error)
        }
    }
}
