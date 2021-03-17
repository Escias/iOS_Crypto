//
//  ViewController.swift
//  iOS_Crypto
//
//  Created by Jimmy Lai on 16/03/2021.
//  Copyright © 2021 Jimmy Lai. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var crypto = [Any]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let url = URL(string: "https://api.coingecko.com/api/v3/coins/markets?vs_currency=eur&order=market_cap_desc&per_page=100&page=1&sparkline=false")!
        
        let config = URLSessionConfiguration.default
        let sessions = URLSession(configuration: config)
       
        let task = sessions.dataTask(with: url) { (data, response, error) in
            if error != nil {
                print(error!.localizedDescription)
            } else {
                if let json = try? JSONSerialization.jsonObject(with: data!, options: .mutableContainers) {
                    if let data = json as? [[String: AnyObject]] {
                            for coin in data {
                                print(coin["name"]!)
                                self.crypto.append(coin)
                                DispatchQueue.main.async {
                                    self.tableView.reloadData()
                                }
                        }
                    }
                }
            }
        }
        task.resume()
        
        
    }
    
    class coinTableView: UITableViewCell {
        @IBOutlet weak var labelCoin: UILabel!
        @IBOutlet weak var imageCoin: UIImageView!
        
    }
    
    // Number of Sections In Table
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    // Number of Rows in each Section
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return crypto.count
    }

    // Sets the content of each cell
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {


        let cell = tableView.dequeueReusableCell(withIdentifier: "coinCell", for: indexPath as IndexPath)
        cell.textLabel?.text = crypto[indexPath.row] as? String
        return cell

    }

    
    
    /*
    getJson { (json) in
        print("finised")
    }
    showError()
    
    func getJson(completion: @escaping (Response) -> ()) {
        let UrlString = "https://api.coingecko.com/api/v3/coins/list"
        if let url = URL(string: UrlString) {
            URLSessionTask.shared.dataTask(with: url) {
                data, res, err in if let data = data
                print("hey")
                
                let decoder = JSONDecoder()
                if let json = try? decoder.decode(Response.self, from: data) {
                    completion(json)
                }
            }
        }.resume()
    }
 */

}

