//
//  ProductTableViewController.swift
//  Collections List Page
//
//  Created by MICHAEL on 2019-01-18.
//  Copyright © 2019 Michael Truong. All rights reserved.
//

import UIKit

class CollectionDetailsTableViewController: UITableViewController {
    
    var collection: Collection!
    var productKey: String?
    var products: [Product] = []
    var productDetailsDictionary: [Int:ProductDetail] = [:]
    var collectionImage: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = false
        collectionImage = getCollectionImage()
        
        fetchProductData {
            (fetchedInfo) in
            self.productKey = fetchedInfo?.first?.key
            for product in (fetchedInfo?[self.productKey!]!)! {
                self.products.append(product)
            }
            DispatchQueue.main.async {
                self.fetchProductDetailData() {
                    (fetchedInfo) in
                    // Implement type safety
                    let productDetailsKey = fetchedInfo?.first?.key
                    for productDetail in ((fetchedInfo?[productDetailsKey!]!)!) {
                        self.productDetailsDictionary[productDetail.id] = productDetail
                    }
                    DispatchQueue.main.async { self.tableView.reloadData() }
                }
            }
        }
    }
    
    private func getCollectionImage() -> UIImage? {
        let imageURL = URL(string: collection.image.src)
        guard let imageData = try? Data(contentsOf: imageURL!) else { return nil }
        return UIImage(data: imageData)
    }
    
    private func getProductImage(from productDetail: ProductDetail) -> UIImage? {
        let imageURL = URL(string: productDetail.image.src)
        guard let imageData = try? Data(contentsOf: imageURL!) else { return UIImage() }
        return UIImage(data: imageData)
    }
    
    // MARK: - Table View
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return products.count
        } else {
            return 0
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CollectionDetailHeaderCell", for: indexPath) as! CollectionDetailHeaderTableViewCell
            cell.update(collectionImage!, collection.title, collection.bodyHtml)
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CollectionDetailCell", for: indexPath) as! CollectionDetailTableViewCell
            let product = products[indexPath.row]
            if let productDetail = productDetailsDictionary[product.productId], collectionImage != nil {
                cell.update(getProductImage(from: productDetail)!, productDetail.title, collectionTitle: collection.title, quantity: getProductTotalQuantity(from: productDetail))
            } else {
                cell.textLabel?.text = "\(product.id)"
            }
            
            return cell
        }
    }
    
    private func getProductTotalQuantity(from productDetail: ProductDetail) -> Int {
        var totalQuantity = 0
        for variant in productDetail.variants {
            totalQuantity += variant.inventoryQuantity
        }
        return totalQuantity
    }
    
    // MARK: API
    private func fetchProductData(completion: @escaping ([String:[Product]]?) -> Void) {
        guard let url = URL(string: "https://shopicruit.myshopify.com/admin/collects.json?collection_id=\(collection.id)&page=1&access_token=c32313df0d0ef512ca64d5b336a0d7c6") else { return }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            if let data = data,
                let productsDictionary = try? decoder.decode([String:[Product]].self, from: data) {
                completion(productsDictionary)
            } else {
                print("Error in decoding JSON or no data was returned")
                completion(nil)
            }
        }
        task.resume()
    }
    
    private func fetchProductDetailData(completion: @escaping ([String:[ProductDetail]]?) -> Void) {
        
        guard let url = URL(string: "https://shopicruit.myshopify.com/admin/products.json?ids=\(self.getProductIdString())&page=1&access_token=c32313df0d0ef512ca64d5b336a0d7c6") else { return }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            if let data = data,
                let productDetailsDictionary = try? decoder.decode([String:[ProductDetail]].self, from: data) {
                completion(productDetailsDictionary)
            } else {
                print("Error in decoding JSON or no data was returned")
                completion(nil)
            }
        }
        task.resume()
    }
    
    private func getProductIdString() -> String {
        var productIdString = ""
        for product in self.products {
            productIdString.append("\(product.productId),")
        }

        productIdString.removeLast()
        return productIdString
    }
    
}
