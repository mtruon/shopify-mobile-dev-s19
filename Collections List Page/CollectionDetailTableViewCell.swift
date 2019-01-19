//
//  CollectionDetailTableViewCell.swift
//  Collections List Page
//
//  Created by MICHAEL on 2019-01-19.
//  Copyright © 2019 Michael Truong. All rights reserved.
//

import UIKit

class CollectionDetailTableViewCell: UITableViewCell {

    @IBOutlet weak var collectionImageView: UIImageView!
    @IBOutlet weak var productTitleLabel: UILabel!
    @IBOutlet weak var collectionTitleLabel: UILabel!
    @IBOutlet weak var quantityLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func update(_ image: UIImage, _ productTitle: String, collectionTitle: String, quantity: Int) {
        collectionImageView.image = image
        productTitleLabel.text = productTitle
        collectionTitleLabel.text = collectionTitle
        quantityLabel.text = "\(quantity)"
        
        if quantity < 100 {
            quantityLabel.textColor = UIColor.orange
        } else if quantity < 50 {
            quantityLabel.textColor = UIColor.red
        }
    }

}
