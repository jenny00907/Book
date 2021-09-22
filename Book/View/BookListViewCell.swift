//
//  BookListViewCell.swift
//  Kakao_Enterprise_Book
//
//  Created by Jenny Woorim Lee on 2021/08/30.
//

import SwiftUI

struct BookListViewCell: View {
    @ObservedObject var bookListVM: BookListViewModel
    
    var keyword: String
    
    var body: some View {
        Text("Searching... \(keyword)")
            .bold()
            .padding(.leading, 15)
        ScrollView {
            ForEach(bookListVM.books, id: \.id) { bookVM in
                NavigationLink(
                    destination: BookDetailView(id: bookVM.id),
                    label: {
                        HStack(spacing: 10) {
                            Text("\(bookVM.title)\n\(bookVM.id)")
                                .foregroundColor(.black)
                            Spacer()
                            Image(systemName: "arrow.right")
                                .scaledToFit()
                        }
                        .padding(9)
                        Divider()
                    })
            }
        }
    }
}

//struct BookListViewCell_Previews: PreviewProvider {
//    static var previews: some View {
//        BookListViewCell()
//    }
//}
