//
//  ViewController.swift
//  iOS_Crypto
//
//  Created by Jimmy Lai on 16/03/2021.
//  Copyright © 2021 Jimmy Lai. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
   
    @IBOutlet weak var labelCoin: UILabel!
    @IBOutlet weak var imageCoin: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    
    struct crypto {
       
        let name: String
        let symbol: String
        let image: String
        let id: String
        
    }
    
    var cryptoName: [String] = []
    var  cryptoImage: [String] = []
    
    var coins = [crypto]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Crypto Watcher"
        self.tableView.delegate = self
        self.tableView.dataSource = self
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
                                self.coins.append(crypto(name: coin["name"] as! String,
                                                         symbol: coin["symbol"] as! String,
                                                         image: coin["image"] as! String,
                                                         id: coin["id"] as! String))

                                //self.cryptoName.append(coin["name"]! as! String)
                                //self.cryptoImage.append(coin["image"] as! String)
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

     
    // Number of Sections In Table
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    // Number of Rows in each Section
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.coins.count
    }

    
    // Sets the content of each cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "coinCell", for: indexPath as IndexPath)
        cell.textLabel?.text = self.coins[indexPath.row].name
        let url = URL(string: self.coins[indexPath.row].image)
        let data = try? Data(contentsOf: url!)
        cell.imageView?.image = UIImage(data: data!)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "showdetail", sender: self)
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
