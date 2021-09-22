//
//  BookDetailView.swift
//  Kakao_Enterprise_Book
//
//  Created by Jenny Woorim Lee on 2021/08/23.
//

import SwiftUI

struct BookDetailView: View {
    @ObservedObject  var bookDetailVM = BookDetailViewModel()
    @EnvironmentObject var bookmarkVM : BookmarksViewModel

    var id: String
    
    var body: some View {
        ScrollView {
            HStack(spacing: 5) {
                Text(self.bookDetailVM.title)
                    .font(.system(size: 25, weight: .semibold))
                Button(bookmarkVM.contains(bookDetailVM) ? "Remove bookmark" : "Add to bookmark") {

                    if self.bookmarkVM.contains(self.bookDetailVM) {
                        self.bookmarkVM.remove(self.bookDetailVM)
                    } else {
                        self.bookmarkVM.add(self.bookDetailVM)
                    }
                }
                
            }
            if let url = URL(string: bookDetailVM.image) {
                Image(systemName: "book")
                    .data(url: url)
                    .scaledToFit()
            }
            VStack(alignment: .leading){
                HStack(alignment: .firstTextBaseline){
                    Text("Author: ")
                        .bold()
                    Text(self.bookDetailVM.authors)
                }.padding()
                
                HStack(alignment: .firstTextBaseline){
                    Text("Subtitle: ")
                    .bold()
                    Text(self.bookDetailVM.subtitle)
                }.padding()
                
                HStack(alignment: .firstTextBaseline){
                    Text("isbn: ")
                    .bold()
                    Text(self.bookDetailVM.isbn13)
                }.padding()
                
                HStack(alignment: .firstTextBaseline){
                    Text("Price: ")
                    .bold()
                    Text(self.bookDetailVM.price)
                }.padding()
                
                HStack(alignment: .firstTextBaseline){
                    Text("Publisher: ")
                    .bold()
                    Text(self.bookDetailVM.publisher)
                }.padding()
                
                HStack(alignment: .firstTextBaseline){
                    Text("Pages: ")
                    .bold()
                    Text(self.bookDetailVM.pages)
                }.padding()
                
                HStack(alignment: .firstTextBaseline){
                    Text("Descritpion: ")
                    .bold()
                    Text(self.bookDetailVM.desc)
                }.padding()
                
                HStack(alignment: .firstTextBaseline){
                    Text("Descritpion: ")
                    .bold()
                    Text(self.bookDetailVM.rating)
                }.padding()
                HStack(alignment: .firstTextBaseline){
                    Text("URL: ")
                    .bold()
                    Text(self.bookDetailVM.url)
                }.padding()
            }
        }.onAppear{self.bookDetailVM.fetchBookDetails(isbn: self.id) }
        
    }
}

struct BookDetailView_Previews: PreviewProvider {
    static var previews: some View {
        BookDetailView(id: "9781484206485")
    }
}
