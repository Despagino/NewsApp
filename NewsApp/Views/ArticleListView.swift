//
//  ArticleListView.swift
//  NewsApp
//
//  Created by Gino Tasis on 3/21/22.
//

import SwiftUI

struct ArticleListView: View {
    
    let articles: [Article]
    
    var body: some View {
        List {
            ForEach(articles) { article in
                ArticleRowView(article: article)
            }
            .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
            .listRowSeparator(.visible)
        }
        .listStyle(.plain)
    }
}

struct ArticleListView_Previews: PreviewProvider {
    static var previews: some View {
        ArticleListView(articles: Article.previewData)
    }
}
