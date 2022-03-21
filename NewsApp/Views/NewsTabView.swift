//
//  NewsTabView.swift
//  NewsApp
//
//  Created by Gino Tasis on 3/21/22.
//

import SwiftUI

struct NewsTabView: View {
    
    @StateObject var articlesNewsVM = ArticleNewsViewModel()
    
    
    var body: some View {
        NavigationView {
            ArticleListView(articles: articles)
            //fetching the dataa
                .onAppear(perform: {
                    async {
                    await articlesNewsVM.loadArticles()
                    }
                })
                .navigationTitle(articlesNewsVM.selectedCategory.text)
            
        }
    }
    
    @ViewBuilder
    private var overlayView: some View {
        
            switch articlesNewsVM.phase {
                
            case .empty: ProgressView()
            case .success(let articles) where articles.isEmpty: EmptyPlaceholderView(text: "No articles", image: nil)
            case .failure(let error): 
                
                
            default: EmptyView()
            }
    }
    
    // getting the data from the enum
    private var articles: [Article] {
        if case let .success(articles) = articlesNewsVM.phase {
            return articles
        } else {
            return []
        }
    }
}

struct NewsTabView_Previews: PreviewProvider {
    static var previews: some View {
        NewsTabView(articlesNewsVM: ArticleNewsViewModel(articles: Article.previewData))
    }
}

