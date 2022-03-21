//
//  ArticleRowView.swift
//  NewsApp
//
//  Created by Gino Tasis on 3/21/22.
//

import SwiftUI

struct ArticleRowView: View {
    
    let article: Article
    
    var body: some View {
        
        VStack (alignment: .leading, spacing: 16) {
            
            AsyncImage(url: article.imageURL) { phase in
                
                switch phase {
                case .empty:
                    ProgressView()
                
                case .success(let image):
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                 
                case .failure:
                    Image(systemName: "photo")
                }
            }
        }
    }
}

struct ArticleRowView_Previews: PreviewProvider {
    static var previews: some View {
        List {
            ArticleRowView(article: .previewData[0])
            //creatinmg how each row would be set in the each frame
                .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
        }
        // creating the style of the list
        .listStyle(.plain)
    }
}
