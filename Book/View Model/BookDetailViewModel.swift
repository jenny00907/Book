//
//  BookDetailViewModel.swift
//  Kakao_Enterprise_Book
//
//  Created by Jenny Woorim Lee on 2021/08/23.
//

import Foundation
import Combine


class BookDetailViewModel: ObservableObject {
    var title: String {
        return self.book.title
    }
    var subtitle: String {
        return self.book.subtitle
    }
    var price: String {
        return self.book.price
    }
    var image: String {
        return self.book.image
    }
    var url: String {
        return self.book.url
    }
    var isbn13: String {
        return self.book.isbn13
    }
    var authors: String {
        return self.book.authors
    }
    var publisher: String {
        return self.book.publisher
    }
    var pages: String {
        return self.book.pages
    }
    var rating: String {
        return self.book.rating
    }
    var desc: String {
        return self.book.desc
    }

    
    private var cancellable: AnyCancellable?
    
    @Published private var book = BookDetail.placeholder()
    
    func fetchBookDetails(isbn: String) {
        self.cancellable =
            Webservice().getBookById(bookId: isbn)
            .catch { _ in Just(BookDetail.placeholder()) }
            .sink(receiveCompletion: { _ in },
                  receiveValue: { book in
                    self.book = book
                  })
    }
}
