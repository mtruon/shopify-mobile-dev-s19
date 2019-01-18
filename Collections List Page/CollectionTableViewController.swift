//
//  ViewController.swift
//  Collections List Page
//
//  Created by MICHAEL on 2019-01-17.
//  Copyright © 2019 Michael Truong. All rights reserved.
//

import UIKit

class CollectionTableViewController: UITableViewController {

    var collectionKey: String?
    var collections: [Collection] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchCollectionData {
            (fetchedInfo) in
            self.collectionKey = fetchedInfo?.first?.key
            for collection in (fetchedInfo?[self.collectionKey!]!)! {
                self.collections.append(collection)
            }
            
            DispatchQueue.main.async { self.tableView.reloadData() }
        }
        navigationItem.title = "Collections"
        navigationController?.navigationBar.prefersLargeTitles = true
//        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        
    }

    // MARK: Table View Data Source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return collections.count
        } else {
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CollectionCell", for: indexPath)
        let collection = collections[indexPath.row]
        cell.textLabel?.text = collection.title
        return cell
    }
    
    // MARK: Table View Protocol
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(collections[indexPath.row].title)
    }
    
    // MARK: Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "CollectionDetailsSegue" {
            let collectionDetailsTableViewController = segue.destination as! CollectionDetailsTableViewController
            collectionDetailsTableViewController.navigationItem.title = "Test"
        }
    }
    
    // MARK: API Call
    
    private func fetchCollectionData(completion: @escaping ([String:[Collection]]?) -> Void) {
        guard let url = URL(string: "https://shopicruit.myshopify.com/admin/custom_collections.json?page=1&access_token=c32313df0d0ef512ca64d5b336a0d7c6") else { return }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            if let data = data,
                let collectionsDictionary = try? decoder.decode([String:[Collection]].self, from: data) {
                completion(collectionsDictionary)
            } else {
                print("Error in decoding JSON or no data was returned")
                completion(nil)
            }
        }
        task.resume()
    }

}

