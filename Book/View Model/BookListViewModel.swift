//
//  BookListViewModel.swift
//  Kakao_Enterprise_Book
//
//  Created by Jenny Woorim Lee on 2021/08/23.
//

import Foundation
import Combine

class BookListViewModel: ObservableObject {
    @Published var books: [BookViewModel] = []
    var booksSearched : [String] = []
    private var cancellable: AnyCancellable?
    
    func fetchBooks(keyword: String) {
        self.cancellable = Webservice().getSearchBooks(keyword: keyword).map { books in
            books.map { BookViewModel(book: $0) }
        }
            .sink(receiveCompletion: { completion in
                if case .failure(let err) = completion {
                    print("Retrieving data failed with error \(err)")
                }
            }, receiveValue: { bookViewModel in
                //print("bookViewModel: \(bookViewModel)")
                self.books = bookViewModel
                //self.books.append(contentsOf: bookViewModel)
                //print(self.books)
            })
    }
}

struct BookViewModel {
    let book: Book
    
    var id: String {
        return self.book.isbn13
    }
    var title: String{
        return self.book.title
    }
}
