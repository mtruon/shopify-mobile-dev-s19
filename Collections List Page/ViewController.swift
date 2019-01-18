//
//  ViewController.swift
//  Collections List Page
//
//  Created by MICHAEL on 2019-01-17.
//  Copyright © 2019 Michael Truong. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        getData()
    }

    private func getData() {
        guard let url = URL(string: "https://shopicruit.myshopify.com/admin/custom_collections.json?page=1&access_token=c32313df0d0ef512ca64d5b336a0d7c6") else { return }
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            guard let data = data else { return }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let collectionsDictionary = try decoder.decode([String:[Collection]].self, from: data)
                for collection in collectionsDictionary["customCollections"]! {
                    print(collection)
                }

            } catch let jsonError {
                print("Error serializing JSON: ", jsonError)
            }

        }
        task.resume()
    }

}

