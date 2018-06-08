//
//  ApiRequest.swift
//  DogsProject
//
//  Created by chen levi on 8.6.2018.
//  Copyright © 2018 chen levi. All rights reserved.
//

import UIKit

fileprivate let instance = ApiRequest()

class ApiRequest: NSObject{
    
    
    typealias JSON = [String:Any]

    
    
    public class var shared : ApiRequest{
        return instance
    }
    
    func getDogsList(complition: @escaping (_ data: [String]) -> Void){
        let urlListString  = "https://dog.ceo/api/breeds/list"
        let urlList = URL(string: urlListString)!
        URLSession.shared.dataTask(with: urlList) { (data, response, error) in
            guard let data = data else{return}
            guard let jsonData = try? JSONSerialization.jsonObject(with: data, options: []) as? JSON else{return}
            guard let list = jsonData?["message"] as? [String] else{return}
            print(list)
            DispatchQueue.main.async {
                complition(list)
            }
            
            }.resume()
        
    }
    
    
    func getDogImages(name: String, complition: @escaping (_ data : [String]) -> Void){
        
        let urlString = "https://dog.ceo/api/breed/" + name + "/images"

        
        let urlList = URL(string: urlString)!
        URLSession.shared.dataTask(with: urlList) { (data, response, error) in
            guard let data = data else{return}
            guard let jsonData = try? JSONSerialization.jsonObject(with: data, options: []) as? JSON else{return}
            guard let list = jsonData?["message"] as? [String] else{return}
            DispatchQueue.main.async {
                complition(list)
            }
            
            }.resume()

    }
    
    
    func getRandomImage(complition: @escaping (_ img: UIImage?) -> Void){
        let urlString = "https://dog.ceo/api/breeds/image/random"
        let url = URL(string: urlString)!
        URLSession.shared.dataTask(with: url) { (data, res, err) in
            guard let data = data else{return}
            let json = try? JSONSerialization.jsonObject(with: data, options: []) as! JSON
            let urlImageString = json?["message"] as! String
            let urlIMG = URL(string: urlImageString)!
            URLSession.shared.dataTask(with: urlIMG, completionHandler: { (dataa, res, err) in
                guard let data = dataa else{return}
                DispatchQueue.main.async {
                    let image = UIImage(data: data)
                    complition(image)
                }
            }).resume()
            }.resume()
    }
    
    
    
    
}
