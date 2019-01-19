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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = collection.title
        
        fetchProductData {
            (fetchedInfo) in
            self.productKey = fetchedInfo?.first?.key
            for product in (fetchedInfo?[self.productKey!]!)! {
                self.products.append(product)
            }
            DispatchQueue.main.async {
                self.fetchProductDetailData() {
                    (fetchedInfo) in
                    var productDetailDictionary: [Int:ProductDetail] = [:]
                    let productDetailsKey = fetchedInfo?.first?.key
                    for productDetail in ((fetchedInfo?[productDetailsKey!]!)!) {
                        productDetailDictionary[productDetail.id] = productDetail
                    }
                    DispatchQueue.main.async { self.tableView.reloadData() }
                }
            }
        }
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
//        navigationItem.title = collection.title
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return products.count
        } else {
            return 0
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductCell", for: indexPath)
        let product = products[indexPath.row]
        if let productDetail = productDetailsDictionary[product.id] {
            cell.textLabel?.text = "\(productDetail.title)"
        } else {
            cell.textLabel?.text = "\(product.id)"
        }
        
        return cell
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
            productIdString.append("\(product.id),")
        }

        productIdString.removeLast()
        return productIdString
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
