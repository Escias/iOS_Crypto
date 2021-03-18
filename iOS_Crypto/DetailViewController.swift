//
//  DetailViewController.swift
//  iOS_Crypto
//
//  Created by Theovady Moutty on 18/03/2021.
//  Copyright © 2021 Jimmy Lai. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var TitleCrypto: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let id = "bitcoin"
        let url = URL(string: "https://api.coingecko.com/api/v3/coins/\(id)")!
        
        let config = URLSessionConfiguration.default
        let sessions = URLSession(configuration: config)
       
        let task = sessions.dataTask(with: url) { (data, response, error) in
            if error != nil {
                print(error!.localizedDescription)
            } else {
                if let json = try? JSONSerialization.jsonObject(with: data!, options: .mutableContainers) {
                    if let data = json as? [[String: AnyObject]] {
                            for coin in data {
                            print(coin)
                        } 
                    }
                }
            }
        }
        task.resume()
        
        
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


