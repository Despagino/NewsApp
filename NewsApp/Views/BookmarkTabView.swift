//
//  BookmarkTabView.swift
//  NewsApp
//
//  Created by Gino Tasis on 3/22/22.
//

import SwiftUI

struct BookmarkTabView: View {
    
    @EnvironmentObject var articleBookmarkVM: ArticleBookmarkViewModel
    
    var body: some View {
        NavigationView {
            
            ArticleListView(articles: articleBookmarkVM.bookmarks)
                .overlay(overlayView(isEmpty: articleBookmarkVM.bookmarks.isEmpty))
                .navigationTitle("Saved Articles")
            
            
        }
    }
    
    // if there are no bookmarks
    @ViewBuilder
    func overlayView(isEmpty: Bool) -> some View {
        if isEmpty {
            EmptyPlaceholderView(text: "No saved articles", image: Image(systemName: "bookmark"))
        }
    }
}

struct BookmarkTabView_Previews: PreviewProvider {
    
    @StateObject static var articleBookmarkVM = ArticleBookmarkViewModel()
    static var previews: some View {
        BookmarkTabView()
            .environmentObject(articleBookmarkVM)
    }
}
