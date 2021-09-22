//
//  Webservice.swift
//  Kakao_Enterprise_Book
//
//  Created by Jenny Woorim Lee on 2021/08/23.
//
import Foundation
import Combine
import SwiftUI


struct Webservice {
    enum Error: LocalizedError, Identifiable {
        var id: String {localizedDescription }
        
        case addressUnreachable(URL)
        case invalidResponse
        
        var errorDescription: String? {
            switch self {
            case .invalidResponse: return "The server responded with garbage"
            case .addressUnreachable(let url): return "\(url.absoluteString) is un reachable."
            }
        }
    }
    enum EndPoint {
//        TODO: 설정 파일 분리
        static let baseURL = URL(string: "https://api.itbook.store/1.0/")!
        
        case books(String)
        case book(String)
        
        var url: URL {
            switch self {
            case .books(let keyword):
                return EndPoint.baseURL.appendingPathComponent("search/\(keyword))")
            case .book(let isbn):
                return EndPoint.baseURL.appendingPathComponent("books/\(isbn)") //change isbn with id
            }
        }
    }
//    TODO: URLSession 작동원리 확인 - 서버 response code에 따른 error처리
    //storylist 보고 디코드 맵에 대해서 확실하게 확인하기
    func getSearchBooks(keyword: String) -> AnyPublisher<[Book], Error> {
        URLSession.shared.dataTaskPublisher(for: EndPoint.books(keyword).url)
            .receive(on: RunLoop.main)
            //.map{ $0.data }
            .map(\.data)
            .decode(type: BooksData.self, decoder: JSONDecoder())
            .map{$0.books}
            .catch { _ in Empty<[Book], Error>()}
            .eraseToAnyPublisher()
    
    }
    
    func getBookById(bookId: String) -> AnyPublisher<BookDetail, Error> {
        URLSession.shared.dataTaskPublisher(for: EndPoint.book(bookId).url)
            .receive(on: RunLoop.main)
            .map(\.data)
            .decode(type: BookDetail.self, decoder: JSONDecoder())
            .catch { _ in Empty<BookDetail, Error>() }
            .eraseToAnyPublisher()
    }
    
}
