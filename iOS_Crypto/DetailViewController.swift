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
    @IBOutlet weak var cryptoDetailCell: UITableView!
    @IBOutlet weak var imageCrypto: UIImageView!
    @IBOutlet weak var nameCrypto: UILabel!
    
    var image = UIImage()
    var name = ""
    var id = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameCrypto.text = name
        imageCrypto.image = image
        print(id)

        let id = "bitcoin"
        let url = URL(string: "https://api.coingecko.com/api/v3/coins/\(id)")!
        
        let config = URLSessionConfiguration.default
        let sessions = URLSession(configuration: config)
       
        let task = sessions.dataTask(with: url) { (data, response, error) in
            if error != nil {
                print(error!.localizedDescription)
            } else {
                
                if let json = try? JSONSerialization.jsonObject(with: data!, options: .mutableContainers) {
                    if let data = json as? [String: AnyObject] {
                        DispatchQueue.main.async{
                            self.TitleCrypto.text = data["name"]! as? String
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


