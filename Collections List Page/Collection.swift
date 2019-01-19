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
    var id: Int?
    var productId: Int?
    var position: Int?
    var updatedAt: String?
    var createdAt: String
    var alt: String?
    var width: Int
    var height: Int
    var src: String
}

struct Product: Decodable {
    var id: Int
    var collectionId: Int
    var productId: Int
    var featured: Bool
    var createdAt: String
    var updatedAt: String
    var position: Int
    var sortValue: String
    var productDetail: ProductDetail?
}

struct ProductDetail: Decodable {
    var id: Int
    var title: String
    var bodyHtml: String
    var vendor: String
    var productType: String
    var createdAt: String
    var handle: String
    var updatedAt: String
    var publishedAt: String
    var templateSuffix: String?
    var tags: String
    var publishedScope: String
    var adminGraphqlApiId: String
    var variants: [Variant]
    var options: Option
    var images: [Image]
    var image: Image
}

struct Variant: Decodable {
    var id: Int
    var productId: Int
    var title: String
    var price: Double
    var sku: String?
    var position: Int
    var inventoryPolicy: String
    var compareAtPrice: String?
    var fulfillmentService: String
    var inventoryManagement: String?
    var option1: String
    var option2: String
    var option3: String
    var createdAt: String
    var updatedAt: String
    var taxable: Bool
    var barcode: String?
    var grams: Int
    var imageId: Int?
    var weight: Double
    var weightUnit: String
    var inventoryItemId: Int
    var inventoryQuantity: Int
    var oldInventoryQuantity: Int
    var requiresShipping: Bool
    var adminGraphqlApiId: String
}

struct Option: Decodable {
    var id: Int
    var productId: Int
    var name: String
    var position: Int
    var values: [Int:String]
}
