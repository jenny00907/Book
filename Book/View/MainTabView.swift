//
//  MainTabView.swift
//  Kakao_Enterprise_Book
//
//  Created by Jenny Woorim Lee on 2021/08/23.
//

import SwiftUI

struct MainTabView: View {
    @State private var selectedIndex = 0
    @StateObject var bookmark = BookmarksViewModel()
    @StateObject var history = BookListViewModel()
    
        
    var tabTitle: String {
        switch selectedIndex {
        case 0: return "Search"
        case 1: return "Bookmark Bar"
        default: return ""
        }
    }
    
    var body: some View {
        NavigationView {
            TabView(selection: $selectedIndex) {
                SearchView()
                    .onTapGesture { selectedIndex = 0 }
                    .tabItem { Image(systemName: "magnifyingglass") }
                    .tag(0)
                
                BookmarkView()
                    .onTapGesture { selectedIndex = 1 }
                    .tabItem { Image(systemName: "bookmark") }
                    .tag(1)
            }
            .navigationTitle(tabTitle)
        }
        .environmentObject(bookmark)
        .environmentObject(history)
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}
