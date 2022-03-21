//
//  ArticleBookmarkViewModel.swift
//  NewsApp
//
//  Created by Gino Tasis on 3/21/22.
//

import Foundation
import SwiftUI

@MainActor
class ArticleBookmarkViewModel: ObservableObject {
    
    
    @Published private(set) var bookmarks: [Article] = []
    
}
