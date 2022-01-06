//
//  Search_Bar_Controller.swift
//  FundFX
//
//  Created by Gokul Gopalakrishnan on 04/01/22.
//

import UIKit

class Search_Bar_Controller: UIViewController {

    @IBOutlet weak var Text_View_search_bar: UITextField!
    @IBOutlet weak var Table_View: UITableView!
    
    var query = ""
    var text_value = ""
    var filtered = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    


}


extension Search_Bar_Controller: UITableViewDelegate, UITableViewDataSource,UITextFieldDelegate
{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        
        search_detail.removeAll()
        
        if let text = Text_View_search_bar.text
        {
           text_value = text
           if (string == "")
           {
            query = text+string
            query.removeLast()
           }
           else
           {
           query = text+string
           }
            
            filtered = true
        }
        
    
        for (i,strings) in apicaller.totals.enumerated()
        {
            if let strings = strings
            {
                if(strings.title!.uppercased().starts(with: query.uppercased()) || strings.title!.uppercased().contains(query.uppercased()) )
                {
                 //   search_detail.append(news_search(title: (strings.title!),index: i))
                    search_detail.append(news_search(total: strings, index: i))
                }
            }
        }
 
        
        Table_View.reloadData()
        
        return true

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if(!filtered)
        {
            return apicaller.totals.count
        }
        else
        {
            return search_detail.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Search_Cell", for: indexPath)
       
        
    
        if(!filtered)
        {

            
            cell.textLabel?.text = apicaller.totals[indexPath.row]?.title
    
        }else
        {
          
            cell.textLabel?.text = search_detail[indexPath.row].total.title
        }
        
        
        
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let vc = storyboard?.instantiateViewController(identifier: "Selected_view_controller") as? Selected_view_controller
        else
        {
            return
        }
        if(!filtered)
        {
            vc.total_table_view = indexPath.row
        }
        else
        {
            vc.total_table_view = search_detail[indexPath.row].index
        }
        
        vc.table_index = apicaller.totals.count
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
}
