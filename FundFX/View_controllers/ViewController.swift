//
//  ViewController.swift
//  FundFX
//
//  Created by Gokul Gopalakrishnan on 23/12/21.
//

import UIKit


var apicaller: articles = articles(topNews: [], totals: [], dailybrief: [], technicalAnalysis: [], specialReport: [])

var Top_header = ["Top News", "Daily Briefings", "Technical Analysis", "Special Report"]

class ViewController: UIViewController {
    
    @IBOutlet var Table_View: UITableView!
    
    @IBOutlet weak var UIserch_bar_button: UIBarButtonItem!
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 1, green: 0.8949728608, blue: 0.8193944097, alpha: 1)
        UIserch_bar_button.tintColor = .systemRed
        title = "FundFX"
        JsonDownloader{
             
            self.Table_View.reloadData()

            apicaller.totals = Array(Set(apicaller.totals))
            
        }
    }
    
  
    
    func JsonDownloader(completed: @escaping () -> ())
    {
            
    let url = URL(string: "https://content.dailyfx.com/api/v1/dashboard")!


      let task = URLSession.shared.dataTask(with: url)
                {
                    data, response, error in
                    
                    if let data = data
                    {
                        do
                        {
                            apicaller = try JSONDecoder().decode(articles.self, from: data)
                          
                            DispatchQueue.main.async {
                                completed()
                            }
                        }catch
                        {
                            print("Error")
                            print(error.localizedDescription)
                        }
                    }
                }
                task.resume()
         
    }
    
    
    func pushtoselectedviewcontroller(table_index: Int, collection_index: Int)
    {
        guard let vc = storyboard?.instantiateViewController(identifier: "Selected_view_controller") as? Selected_view_controller
        else
        {
            return
        }
        
        vc.table_index = table_index
        vc.collection_index = collection_index
        navigationController?.pushViewController(vc, animated: true)
    }
    

}

extension ViewController: UITableViewDelegate, UITableViewDataSource
{

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Top_header.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! Custom_Table_view_Cell
        
     
        
        cell.set_label(text_label: Top_header[indexPath.row])
        
        cell.tableview_index = indexPath.row
        
        
    
        switch(indexPath.row)
        {
        case 0: cell.tableview_tag = apicaller.topNews.count
        case 1: cell.tableview_tag = apicaller.dailybrief.count
        case 2: cell.tableview_tag = apicaller.technicalAnalysis.count
        case 3: cell.tableview_tag = apicaller.specialReport.count
        default:  print("Error")
        }
    
        cell.selected_view = { table_index, collection_index in
            if let tableIndex = table_index, let collectionindex = collection_index
            {
                
                self.pushtoselectedviewcontroller(table_index: tableIndex, collection_index: collectionindex)
            }
    
        }
        
       return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 330
    }
    
}

