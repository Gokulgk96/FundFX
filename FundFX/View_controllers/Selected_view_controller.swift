//
//  Selected_view_controller.swift
//  FundFX
//
//  Created by Gokul Gopalakrishnan on 05/01/22.
//

import UIKit
import SafariServices

var main_index = 0

class Selected_view_controller: UIViewController {

    @IBOutlet weak var Collection_View: UICollectionView!
    
    @IBOutlet weak var Title_image_view: UIImageView!
    
    @IBOutlet weak var Name_title: UILabel!
  
    
    @IBOutlet weak var Profession_title: UILabel!
    
    @IBOutlet weak var Title_view_work: UILabel!
    
    @IBOutlet weak var Title_description: UILabel!
    
    var total_table_view: Int = 0
  
    var table_index : Int?
    
    var collection_index : Int?
    
    var url_link : String?
    
    var bio_url_link : String?
    
    let randomInumber = Int.random(in: 0..<4)
    
    var randomInt : Int?
    
 
  
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        Collection_View.reloadData()
        
        randomInt = self.randomInumber
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
         randomInt = self.randomInumber

        self.navigationController?.isNavigationBarHidden = false
        
        let logoutBarButtonItem = UIBarButtonItem(title: "<< Back", style: .done, target: self, action: #selector(logoutUser))
            self.navigationItem.leftBarButtonItem = logoutBarButtonItem
        
       
        Collection_View.reloadData()
        
   
        switch(table_index!)
        {
        case 0: display(Images: (apicaller.topNews[collection_index!]?.headlineImageUrl)!,
             Title: (apicaller.topNews[collection_index!]?.title)!,
             Description: (apicaller.topNews[collection_index!]?.description)!,
             author_name: (apicaller.topNews[collection_index!]?.authors[0]?.name)!,
             author_profession: (apicaller.topNews[collection_index!]?.authors[0]?.title)!)
             url_link = apicaller.topNews[collection_index!]?.url
            bio_url_link = apicaller.topNews[collection_index!]?.authors[0]?.bio
            
            main_index = collection_index!
            
        case 1: display(Images: (apicaller.dailybrief[collection_index!]?.headlineImageUrl), Title: ((apicaller.dailybrief[collection_index!]?.title)!), Description: (apicaller.dailybrief[collection_index!]?.description)!, author_name: (apicaller.dailybrief[collection_index!]?.authors[0]?.name)! ,author_profession: (apicaller.dailybrief[collection_index!]?.authors[0]?.title)!)
            url_link = apicaller.dailybrief[collection_index!]?.url
            bio_url_link = apicaller.dailybrief[collection_index!]?.authors[0]?.bio
            main_index = collection_index!
            
        case 2: display(Images: (apicaller.technicalAnalysis[collection_index!]?.headlineImageUrl) , Title: (apicaller.technicalAnalysis[collection_index!]?.title)!, Description: (apicaller.technicalAnalysis[collection_index!]?.description)!, author_name: (apicaller.technicalAnalysis[collection_index!]?.authors[0]?.name)! ,author_profession: (apicaller.technicalAnalysis[collection_index!]?.authors[0]?.title)!)
            url_link = apicaller.technicalAnalysis[collection_index!]?.url
            bio_url_link = apicaller.technicalAnalysis[collection_index!]?.authors[0]?.bio
            main_index = collection_index!
            
        case 3: display(Images: (apicaller.specialReport[collection_index!]?.headlineImageUrl), Title: (apicaller.specialReport[collection_index!]?.title)!, Description: (apicaller.specialReport[collection_index!]?.description)!, author_name: (apicaller.specialReport[collection_index!]?.authors[0]?.name)! ,author_profession: (apicaller.specialReport[collection_index!]?.authors[0]?.title)!)
            url_link = apicaller.specialReport[collection_index!]?.url
            bio_url_link = apicaller.specialReport[collection_index!]?.authors[0]?.bio
            main_index = collection_index!
            
        case apicaller.totals.count:
            display(Images: (apicaller.totals[total_table_view]?.headlineImageUrl), Title: (apicaller.totals[total_table_view]?.title)!, Description: (apicaller.totals[total_table_view]?.description)!, author_name: (apicaller.totals[total_table_view]?.authors[0]?.name)! ,author_profession: (apicaller.totals[total_table_view]?.authors[0]?.title)!)
                url_link = apicaller.totals[total_table_view]?.url
            main_index = total_table_view
            
            bio_url_link = apicaller.totals[total_table_view]?.authors[0]?.bio
            
             
        default:  print("Error")
         }
        
    }
       
    @objc func logoutUser(){
            navigationController?.popToRootViewController(animated: true)
        }
        
    
    @IBAction func Bio_button_Click(_ sender: Any) {
        
        
       guard let url = URL(string: bio_url_link! ) else
        {
            return
        }
        let vc = SFSafariViewController(url: url)
        present(vc, animated: true)
        
    }
    
    @IBAction func Full_news_Button(_ sender: Any) {
        
       guard let url = URL(string: url_link! ) else
        {
            return
        }
        let vc = SFSafariViewController(url: url)
        present(vc, animated: true)
    }
    
    
    func display(Images: String?, Title: String, Description: String, author_name: String ,author_profession: String)
    {
        Title_view_work.text = Title
        
        Title_description.text = Description
       
        Name_title.text = author_name + ","
        
        Profession_title.text = author_profession
       
        
        if(Images == nil)
        {
            self.Title_image_view.image = UIImage(named: "missing_image")
        }
        else
        {
            let link = URL(string: Images!)
            
            DispatchQueue.global().async {
                
                if let imagedata = try? Data(contentsOf: link!)
                {
                    DispatchQueue.main.async {
                        self.Title_image_view.image = UIImage(data: imagedata)
                                             }
                }
            }

        }
    }


}


extension Selected_view_controller: UICollectionViewDelegate, UICollectionViewDataSource
{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
     let vc = storyboard?.instantiateViewController(identifier: "Selected_view_controller") as? Selected_view_controller
      
        print("the tableview: \(randomInt!), the collection_index : \(indexPath.row)")
        
        
      
        vc!.table_index = randomInt!
        vc!.collection_index = indexPath.row
       
        navigationController?.pushViewController(vc!, animated: true)
    
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        switch(randomInt)
        {
        case 0: return apicaller.topNews.count
        case 1: return apicaller.dailybrief.count
        case 2: return apicaller.specialReport.count
        case 3: return apicaller.technicalAnalysis.count
        default : return 0 ;print("error")
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Recent_view", for: indexPath) as! Selection_view_CollectionViewCell
        
        switch(randomInt!)
        {
        case 0: cell.set_custom_collection(text_label: (apicaller.topNews[indexPath.row]?.title)!, image_label: apicaller.topNews[indexPath.row]?.headlineImageUrl)
            
        case 1: cell.set_custom_collection(text_label: (apicaller.dailybrief[indexPath.row]?.title)!, image_label: apicaller.dailybrief[indexPath.row]?.headlineImageUrl)
            
        case 2: cell.set_custom_collection(text_label: (apicaller.technicalAnalysis[indexPath.row]?.title)!, image_label: apicaller.technicalAnalysis[indexPath.row]?.headlineImageUrl)
            
        case 3: cell.set_custom_collection(text_label: (apicaller.specialReport[indexPath.row]?.title)!, image_label: apicaller.specialReport[indexPath.row]?.headlineImageUrl)
            
        default : print("error")
        }
        
    
        return cell
    }
    
    
}
