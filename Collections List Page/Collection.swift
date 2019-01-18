//
//  Collection.swift
//  Collections List Page
//
//  Created by MICHAEL on 2019-01-17.
//  Copyright © 2019 Michael Truong. All rights reserved.
//

import Foundation

struct Collection: Decodable {
    var id: Int
    var handle: String
    var title: String
    var updatedAt: String
    var bodyHtml: String
    var publishedAt: String
    var sortOrder: String
    var templateSuffix: String
    var publishedScope: String
    var adminGraphqlApiId: String
    var image: Image
}

struct Image: Decodable {
    var createdAt: String
    var alt: String?
    var width: Int
    var height: Int
    var src: String
}
