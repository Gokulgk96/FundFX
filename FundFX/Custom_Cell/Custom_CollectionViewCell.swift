//
//  Custom_CollectionViewCell.swift
//  FundFX
//
//  Created by Gokul Gopalakrishnan on 01/01/22.
//

import UIKit

class Custom_CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var Collection_view_label: UILabel!
    
    @IBOutlet weak var Collection_view_image: UIImageView!
    
    
    
  func set_custom_layer(text_label: String, image_label: String?)
    {
    Collection_view_image.layer.cornerRadius = 15
    
        Collection_view_label.text = text_label
    
    if(image_label == nil)
    {
        self.Collection_view_image.image = UIImage(named: "missing_image")
    }
    else
    {
        let link = URL(string: image_label!)
        
        DispatchQueue.global().async {
            
            if let imagedata = try? Data(contentsOf: link!)
            {
                DispatchQueue.main.async {
                    self.Collection_view_image.image = UIImage(data: imagedata)
                                         }
            }
        }

    }
        
    }
}
