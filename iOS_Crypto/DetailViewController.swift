//
//  DetailViewController.swift
//  iOS_Crypto
//
//  Created by Theovady Moutty on 18/03/2021.
//  Copyright © 2021 Jimmy Lai. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {

    @IBOutlet weak var TitleCrypto: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var imageCrypto: UIImageView!
    
    var image = UIImage()
    var name = ""
    var id = ""
    
    var crypto: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        TitleCrypto.text = name
        imageCrypto.image = image
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        let url = URL(string: "https://api.coingecko.com/api/v3/coins/\(id)")!
        
        let config = URLSessionConfiguration.default
        let sessions = URLSession(configuration: config)
        
        let task = sessions.dataTask(with: url) { (data, response, error) in
            if error != nil {
                print(error!.localizedDescription)
            } else {
                
                if let json = try? JSONSerialization.jsonObject(with: data!, options: .mutableContainers) {
                    if let data = json as? [String: AnyObject] {
                        let market = data["market_data"] as! [String: AnyObject]
                        let mar = market["current_price"] as! [String: AnyObject]
                        self.crypto.append(data["symbol"] as! String)
                        self.crypto.append((mar["eur"] as! NSNumber).stringValue)
                        self.crypto.append(data["last_updated"] as! String)
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                        }
                        
                    }
                }
            }
        }
        task.resume()
    }
    
   func numberOfSections(in tableView: UITableView) -> Int {
       return 1
   }
   // Number of Rows in each Section
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return self.crypto.count
   }

   
   // Sets the content of each cell
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "detailCell", for: indexPath as IndexPath)
        cell.textLabel?.text = self.crypto[indexPath.row]
       return cell
   }
        // Do any additional setup after loading the view.
}
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


