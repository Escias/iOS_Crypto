//
//  ViewController.swift
//  iOS_Crypto
//
//  Created by Jimmy Lai on 16/03/2021.
//  Copyright © 2021 Jimmy Lai. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let url = URL(string: "https://api.coingecko.com/api/v3/coins/list")!
        
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
                        }
                    }
                }
            }
        }
        task.resume()
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

