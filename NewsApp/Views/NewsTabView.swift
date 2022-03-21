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
                .overlay(overlayView)
                .task(id: articlesNewsVM.selectedCategory, loadTask)
            //pull to refresh method
//                .refreshable {
//                    loadTask()
//                }
            //fetching the data
//                .onAppear(perform: {
//                   loadTask()
//                })
//                .onChange(of: articlesNewsVM.selectedCategory, perform: { _ in
//                    loadTask()
//                })
                .navigationTitle(articlesNewsVM.selectedCategory.text)
                .navigationBarItems(trailing: menu)
        }
    }
    
    @ViewBuilder
    private var overlayView: some View {
        
            switch articlesNewsVM.phase {
                
            case .empty:
                 ProgressView()
            case .success(let articles) where articles.isEmpty:
                 EmptyPlaceholderView(text: "No articles", image: nil)
            case .failure(let error):
                 RetryView(text: error.localizedDescription) {
//                     loadTask()
            }

            default: EmptyView()
            }
    }

    @Sendable private func loadTask() async {
        await articlesNewsVM.loadArticles()
    }
    
    // creating the options for you to click whichever category you want
    private var menu: some View {
        Menu {
            Picker("Category", selection: $articlesNewsVM.selectedCategory) {
                ForEach(Category.allCases) {
                    Text($0.text).tag($0)
                }
            }
        } label: {
            Image(systemName: "fiberchannel")
                .imageScale(.large)
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

