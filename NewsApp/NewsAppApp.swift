//
//  NewsAppApp.swift
//  NewsApp
//
//  Created by Gino Tasis on 3/21/22.
//

import SwiftUI

@main
struct NewsAppApp: App {

    @StateObject var articleBookMarkVM = ArticleBookmarkViewModel()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(articleBookMarkVM)
        }
    }
}
