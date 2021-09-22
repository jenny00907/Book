//
//  Image.swift
//  Kakao_Enterprise_Book
//
//  Created by Jenny Woorim Lee on 2021/08/25.
//

import SwiftUI

extension Image {
    func data(url: URL) -> Self {
        if let data = try? Data(contentsOf: url) {
            return Image(uiImage: UIImage(data:data)!)
        }
        return self
            .resizable()
    }
}
