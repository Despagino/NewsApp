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
