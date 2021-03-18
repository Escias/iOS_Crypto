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
    
    struct cryptoDetail {
       
        let symbol: String
        //let current_price: String
        //let market_cap_rank: String
        //let price_change_percentage_24h: String
        let last_updated: String
        let total_volume: String
        let high_24h: String
        let low_24h: String
    }

    var cryptoD = [cryptoDetail]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        TitleCrypto.text = name
        imageCrypto.image = image
        
        
        let url = URL(string: "https://api.coingecko.com/api/v3/coins/\(id)")!
        
        let config = URLSessionConfiguration.default
        let sessions = URLSession(configuration: config)
        
        let task = sessions.dataTask(with: url) { (data, response, error) in
            if error != nil {
                print(error!.localizedDescription)
            } else {
                
                if let json = try? JSONSerialization.jsonObject(with: data!, options: .mutableContainers) {
                    if let data = json as? [String: AnyObject] {
                            self.cryptoD.append(cryptoDetail(symbol: data["symbol"] as! String,
                                           last_updated: data["last_updated"] as! String ,
                                           total_volume: data["total_volume"] as! String,
                                           high_24h: data["high_24h"] as! String,
                                           low_24h: data["low_24h"] as! String))
                            DispatchQueue.main.async {
                                self.tableView.reloadData()
                            }
                        }
                    }
                }
            }
        
        task.resume()
        
        //current_price: data["market_data"]!["current_price"] as! String,
        //market_cap_rank: data["market_cap_rank"] as! String,
        //price_change_percentage_24h: data["price_change_percentage_24h"] as! String,
        
    }
    
   func numberOfSections(in tableView: UITableView) -> Int {
       return 1
   }
   // Number of Rows in each Section
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return self.cryptoD.count
   }

   
   // Sets the content of each cell
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       let cell = tableView.dequeueReusableCell(withIdentifier: "detailCell", for: indexPath as IndexPath)
        cell.textLabel?.text = self.cryptoD[indexPath.row].symbol
        //cell.textLabel?.text = self.cryptoD[indexPath.row].current_price
        //cell.textLabel?.text = self.cryptoD[indexPath.row].market_cap_rank
        //cell.textLabel?.text = self.cryptoD[indexPath.row].price_change_percentage_24h
        cell.textLabel?.text = self.cryptoD[indexPath.row].last_updated
        cell.textLabel?.text = self.cryptoD[indexPath.row].total_volume
        cell.textLabel?.text = self.cryptoD[indexPath.row].high_24h
        cell.textLabel?.text = self.cryptoD[indexPath.row].low_24h

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


