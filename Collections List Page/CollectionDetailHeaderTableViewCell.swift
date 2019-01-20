//
//  CollectionDetailHeaderTableViewCell.swift
//  Collections List Page
//
//  Created by MICHAEL on 2019-01-19.
//  Copyright © 2019 Michael Truong. All rights reserved.
//

import UIKit

class CollectionDetailHeaderTableViewCell: UITableViewCell {
    
    @IBOutlet weak var collectionTitleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var collectionImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func update(_ image: UIImage, _ collectionTitle: String, _ description: String) {
        collectionImageView.image = image
        collectionImageView.layer.borderWidth = 1
        collectionImageView.layer.borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1).cgColor
        collectionImageView.layer.cornerRadius = 5
        
        collectionTitleLabel.text = collectionTitle
        descriptionLabel.text = description
    }
}
