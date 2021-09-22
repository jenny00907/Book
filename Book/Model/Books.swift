//
//  Books.swift
//  Kakao_Enterprise_Book
//
//  Created by Jenny Woorim Lee on 2021/08/23.
//

import Foundation


struct BooksData: Codable {
    let books: [Book]

}

struct Book: Codable {
    let title: String
    let subtitle: String
    let isbn13: String
    let price: String
    let image: String
    let url: String
    
    
}

struct BookDetail: Codable {
    let title: String
    let subtitle: String
    let authors: String
    let publisher: String
    let isbn13: String
    let pages: String
    let rating: String
    let desc: String
    let price: String
    let image: String
    let url: String
    
    static func placeholder() -> BookDetail {
        return BookDetail(title: "No Title", subtitle: "", authors: "", publisher: "", isbn13: "", pages: "", rating: "", desc:"", price: "", image: "", url: "")
    }
}

