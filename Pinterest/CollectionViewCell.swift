//
//  CollectionViewCell.swift
//  Pinterest
//
//  Created by Oka Yuya on 2016/09/24.
//  Copyright © 2016年 nnsnodnb.moe. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var animalImageView: UIImageView!
    @IBOutlet weak var animalNameLabel: UILabel!
    @IBOutlet weak var animalDescriptionLabel: UILabel!
    
    func setConfigure(model: ImageModel) {
        animalImageView.image = UIImage(named: model.image)
        animalNameLabel.text = model.caption
        animalDescriptionLabel.text = model.comment
    }    
}
