//
//  Article.swift
//  NewsMVVM
//
//  Created by hyeri kim on 11/07/2019.
//  Copyright © 2019 hyeri kim. All rights reserved.
//

import Foundation

struct ArticleResponse: Decodable {
    let articles: [Article]
}

struct Article: Decodable {
    let title: String
    let description: String?
}
