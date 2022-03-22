//
//  SearchHistoryListView.swift
//  NewsApp
//
//  Created by Gino Tasis on 3/22/22.
//

import SwiftUI

struct SearchHistoryListView: View {
    
    @ObservedObject var searchVM: ArticleSearchViewModel
    let onSubmit: (String) -> ()
    
    var body: some View {
        List {
            HStack {
                Text("Recently Searched")
                Spacer()
                Button("Clear") {
                    searchVM.removeAllHistory()
                }
            }
            .listRowSeparator(.hidden)
            
            ForEach(searchVM.history, id: \.self) { history in
                Button(history) {
                onSubmit(history)
                }
            }
        }
    }
}

struct SearchHistoryListView_Previews: PreviewProvider {
    static var previews: some View {
        SearchHistoryListView(searchVM: ArticleSearchViewModel()) { _ in
                
        }
    }
}
