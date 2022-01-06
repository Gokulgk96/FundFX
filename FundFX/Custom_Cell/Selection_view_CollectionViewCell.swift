//
//  Selection_view_CollectionViewCell.swift
//  FundFX
//
//  Created by Gokul Gopalakrishnan on 06/01/22.
//

import UIKit

class Selection_view_CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var image_view: UIImageView!
    
    @IBOutlet weak var Label_View: UILabel!
    
    
    func set_custom_collection(text_label: String, image_label: String?)
    {
        
        
                Label_View.text = text_label
                
                let image_labels = image_label
                
                if(image_label == nil)
                {
                    image_view.image = UIImage(named: "missing_image")
                }
                else
                {
                    let link = URL(string: image_labels!)
                    
                    DispatchQueue.global().async {
                        
                        if let imagedata = try? Data(contentsOf: link!)
                        {
                            DispatchQueue.main.async {
                                self.image_view.image = UIImage(data: imagedata)
                                                     }
                        }
                    }

                }

            
        
    }
}
