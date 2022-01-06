//
//  Custom_Table_view_Cell.swift
//  FundFX
//
//  Created by Gokul Gopalakrishnan on 01/01/22.
//

import UIKit
import Foundation


typealias Selected_collectionview = ((_ table_index:Int?, _ Collection_indx: Int?) -> Void)


class Custom_Table_view_Cell: UITableViewCell {
    
    @IBOutlet weak var Collection_works: UICollectionView!
    
    @IBOutlet weak var Title_Label: UILabel!
    
    var tableview_index: Int = 0
    var tableview_tag: Int = 0
    
    var testing_work = 0
    
    var selected_view : Selected_collectionview?
    
   override func awakeFromNib() {
        super.awakeFromNib()
        
    Collection_works.dataSource = self
    Collection_works.delegate = self

    
    }
    
        func set_label(text_label: String)
        {
        
                Title_Label.text = text_label
            
                Collection_works.reloadData()
                 
        }


}

extension Custom_Table_view_Cell : UICollectionViewDelegate, UICollectionViewDataSource
{
   
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        selected_view?(tableview_index, indexPath.row)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       
        return tableview_tag
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let collection = collectionView.dequeueReusableCell(withReuseIdentifier: "Collection_cell", for: indexPath) as! Custom_CollectionViewCell
    
        
        switch(tableview_index)
        {
        case 0: collection.set_custom_layer(text_label: (apicaller.topNews[indexPath.row]?.title)!, image_label: (apicaller.topNews[indexPath.row]?.headlineImageUrl) ?? nil)

        case 1:
            collection.set_custom_layer(text_label: (apicaller.dailybrief[indexPath.row]?.title)!, image_label: (apicaller.dailybrief[indexPath.row]?.headlineImageUrl) ?? nil)
         
        case 2: collection.set_custom_layer(text_label:
                (apicaller.technicalAnalysis[indexPath.row]?.title)!, image_label: (apicaller.technicalAnalysis[indexPath.row]?.headlineImageUrl) ?? nil)
            
        case 3:collection.set_custom_layer(text_label: (apicaller.specialReport[indexPath.row]?.title)!, image_label: (apicaller.specialReport[indexPath.row]?.headlineImageUrl) ?? nil)
            
        default: print("error")
        
        }
        
      
        
        return collection
        
    }
  
}
