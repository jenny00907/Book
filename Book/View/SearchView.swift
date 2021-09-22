//
//  SearchView.swift
//  Kakao_Enterprise_Book
//
//  Created by Jenny Woorim Lee on 2021/08/23.
//

import SwiftUI
struct SearchView: View {
    //don't need observableobject as defined in the maintabview as environmentobject
    @EnvironmentObject var bookListVM : BookListViewModel
    
    @State var keyword: String = ""
    @State var isEditing : Bool = false

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 5) {
                HStack(spacing: 5) { //SearchBar
                    TextField("Start typing",
                              text: $keyword,
                              onCommit: { self.performSearch(keyword: keyword)
                                isEditing = false
                              })
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .onTapGesture {
                            self.isEditing = true
                        }
                    Button(action: {self.performSearch(keyword: keyword)
                        isEditing = false
                        UIApplication.shared.endEditing()
                    }) {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.black)
                    }
                    .padding()
                    if isEditing {
                        Button(action: { isEditing = false
                            keyword = ""
                            UIApplication.shared.endEditing()
                        }, label: {
                            Text("Cancel")
                                .foregroundColor(.black)
                        })
                        .padding(.trailing, 8)
                        .transition(.move(edge: .trailing))
                        .animation(.default)
                    }
                }
                
                
                if keyword == "" || isEditing == true{
                    VStack(alignment: .leading) {
                        Text("Query histories")
                            .bold()
                            .padding()
                        ForEach(bookListVM.booksSearched, id: \.self) { element in
                            NavigationLink(destination: BookListViewCell(bookListVM: bookListVM, keyword: element)
                                            .onAppear { self.performSearch(keyword: element) },
                                           label: { Text(element) }
                            )
                            
                            //onTapGesture is not working, it should use onAppear so that when booklistviewcell appears, performsearch should be triggered
//                                .onTapGesture {
//                                    print("performing query search \(element)")
//                                    self.performSearch(keyword: element)
//
//                                }
                        }
                        .padding(.leading, 18)
                    }
                }
                else if keyword.count > 0 {
                    BookListViewCell(bookListVM: bookListVM, keyword: keyword)
                }
            }
        }
    }
    func performSearch(keyword: String) {
        bookListVM.fetchBooks(keyword: keyword)
        if !bookListVM.booksSearched.contains(keyword){
            bookListVM.booksSearched.append(keyword)
        }
        //added to drop old item when bookSearched is bigger than 5
        if bookListVM.booksSearched.count > 5 {
            bookListVM.booksSearched = bookListVM.booksSearched.suffix(5)
        }
    }
}
