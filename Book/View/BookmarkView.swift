//
//  BookmarkView.swift
//  Kakao_Enterprise_Book
//
//  Created by Jenny Woorim Lee on 2021/08/23.
//

import SwiftUI

struct BookmarkView: View {
    @EnvironmentObject var bookmarkVM : BookmarksViewModel
    
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 10) {
                ForEach(bookmarkVM.books, id:\.id) { bookmark in
                    NavigationLink(
                        destination: BookDetailView(id: bookmark.id),
                        label: {
                            HStack(spacing: 10) {
                                Text("\(bookmark.title)")
                                    .font(.system(size: 18))
                                    .foregroundColor(.black)
                                Spacer()
                                Image(systemName: "arrow.right")
                                    .scaledToFit()
                            }
                            .padding(9)
                            Divider()
                            
                        
                    })
                        

                }
            }.padding(.top, 5)
            
        }
    }
}

struct BookmarkView_Previews: PreviewProvider {
    static var previews: some View {
        BookmarkView()
    }
}
