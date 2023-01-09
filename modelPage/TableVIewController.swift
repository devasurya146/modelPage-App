//
//  TableVIewControllert.swift
//  modelPage
//
//  Created by Dinesh on 05/01/23.
//

import Foundation
import UIKit

class TableViewController:UITableViewController{
    
    struct Person : Codable{
        var name  : String
        var email : String
        var phone : String
    }
    var myArray = [Person(name: "", email: "", phone: "")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        userPage()
        
        
        print("hello")
        print(myArray)
        print(myArray.count)
    }
    func userPage()  {
        myArray = [Person(name: "", email: "", phone: "")]
        let url = URL(string: "https://lmachpay.nexdha.com/api/test101")
        guard url != nil else{
            print("erorr")
            return
        }
        var request = URLRequest(url: url!, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10)
        let headers = ["Content-Type" : "application/json",
                       "Authorization": "token 7147da357eedbe71245b1f9eef8cd313d8e7637e"]
        request.httpMethod = "POST"
        
        request.allHTTPHeaderFields = headers
        do{
            let requestBody = try JSONSerialization.data(withJSONObject: headers, options: .fragmentsAllowed)
            request.httpBody = requestBody
            print(headers)
        }catch{
            print("erorr")
        }
        let session = URLSession.shared
        print(session)
        
        let dataTask = session.dataTask(with: request) {  [self]data, responce, error in
            do{
                
                let json = try JSONSerialization.jsonObject(with: data!)
                if let jsonArray = json as? [[String:Any]] {
                    print(jsonArray)
                    for i in jsonArray{
                        print(i["name"]!)
                        self.myArray.append(Person(name: i["name"] as! String, email: i["email"] as! String, phone: i["phone"] as! String))
                    }
                    
                    print(myArray)
                    print(myArray.count)
                    self.myArray.remove(at: 0)
                    DispatchQueue.main.async {
                        self.tableView .reloadData()
                    }
                    
                    
                } else if let jsonDictionary = json as? [String:Any] {
                    print("json is dictionary", jsonDictionary)
                } else {
                    print("This should never be displayed")
                }
            }catch{
                print("erorr")
            }
        }
        dataTask.resume()
    }
    
    
   
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomViewController
        self.tableView.rowHeight = 151
   
        let person1 = myArray[indexPath.row]
        cell.nameTextLabel?.text = person1.name
        
        cell.emailTextLabel?.text = person1.email
        
        cell.numberTextLabel?.text = person1.phone
        
        
   
        
        
        print(person1.name)
        return cell
    }
    
    
}
class CustomViewController:UITableViewCell{

    
    @IBOutlet weak var labelField: UIView!
    @IBOutlet weak var nameTextLabel: UILabel!
    
    @IBOutlet weak var numberTextLabel: UILabel!
    
    
    @IBOutlet weak var emailTextLabel: UILabel!
    
    
    
  
}
