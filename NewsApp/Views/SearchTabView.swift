//
//  SearchTabView.swift
//  NewsApp
//
//  Created by Gino Tasis on 3/22/22.
//

import SwiftUI

struct SearchTabView: View {
    
    @StateObject var searchVM = ArticleSearchViewModel()
    
    var body: some View {
        NavigationView {
            ArticleListView(articles: articles)
        }
        
    }
    
    private var articles: [Article] {
        if case .success(let articles) = searchVM.phase {
            return articles
        } else {
            return []
        }
    }
}

struct SearchTabView_Previews: PreviewProvider {
    
    @StateObject static var bookmarkVM = ArticleBookmarkViewModel.shared
    
    
    static var previews: some View {
        SearchTabView()
            .environmentObject(bookmarkVM)
    }
}
