//
//  PicViewController.swift
//  DogsProject
//
//  Created by chen levi on 17.12.2017.
//  Copyright © 2017 chen levi. All rights reserved.
//

import UIKit

class PicViewController: UIViewController {

    var selectedPic: String!
    
    @IBOutlet weak var image: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let url = URL(string: selectedPic)!
        URLSession.shared.dataTask(with: url) { (data, res, err) in
            guard let data = data else{return}
            
            DispatchQueue.main.async {
                self.image.image = UIImage(data: data)
            }
        }.resume()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func saveButton(_ sender: Any) {
        let pic = Photo(pic: image.image!)
        DBManager.shared.add(pic: pic)
        self.navigationController?.popViewController(animated: true)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
