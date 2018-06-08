//
//  GameViewController.swift
//  DogsProject
//
//  Created by chen levi on 22.12.2017.
//  Copyright © 2017 chen levi. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {

    var pics : [Photo]!
    var myPics : [UIImage] = []
    @IBOutlet var cards: [UIButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for pic in pics{
            let image = UIImage(data: pic.pic as Data)!
            myPics.append(image)
        }
        
        var gameCard = myPics + myPics
        gameCard.sort { (_, _) -> Bool in
            return rand(max: 2) == 0
        }
        
        for card in cards{

            card.setImage(gameCard.remove(at: 0), for: .disabled)
        }

        // Do any additional setup after loading the view.
    }
    
    func rand(max : Int)-> Int{
        return Int(arc4random_uniform(UInt32(max)))
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    var previousCard : UIButton? = nil
    var numOfFlipCards = 0
    var stopReactToFlip = false
    
    @IBAction func card(_ sender: UIButton) {
    
        
        if previousCard == nil{
            previousCard = sender
            UIView.animate(withDuration: 0.3, animations: {
                self.previousCard?.transform = CGAffineTransform(scaleX: 0.01, y: 1)
                UIView.animate(withDuration: 0.3, delay: 0.5, animations: {
                    self.previousCard?.transform = CGAffineTransform.identity
                })
                
            }, completion: { (_) in
                self.previousCard?.isEnabled = false

            })
            

               
            
            
        }else{
            
            if stopReactToFlip == true{
                return
            }
            stopReactToFlip = true
                UIView.animate(withDuration: 0.3, animations: {
                    sender.transform = CGAffineTransform(scaleX: 0.01, y: 1)
                    UIView.animate(withDuration: 0.3, delay: 0.5, animations: {
                        sender.transform = CGAffineTransform.identity
                    })
                    
                }, completion: { (_) in
                    sender.isEnabled = false
                    
                })

            
            
            if previousCard?.image(for: .disabled) != sender.image(for: .disabled){
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0, execute: {
                    UIView.animate(withDuration: 0.3, animations: {
                        self.previousCard?.transform = CGAffineTransform(scaleX: 0.01, y: 1)
                        UIView.animate(withDuration: 0.3, delay: 0.5, animations: {
                            self.previousCard?.transform = CGAffineTransform.identity
                        })
                        
                    }, completion: { (_) in
                        self.previousCard?.isEnabled = true
                        
                    })

                    UIView.animate(withDuration: 0.3, animations: {
                        sender.transform = CGAffineTransform(scaleX: 0.01, y: 1)
                        UIView.animate(withDuration: 0.3, delay: 0.5, animations: {
                            sender.transform = CGAffineTransform.identity
                        })
                        
                    }, completion: { (_) in
                        sender.isEnabled = true
                    self.stopReactToFlip = false
                        
                    })
                    
                    
                    
                    
                })
            }else{
                numOfFlipCards += 1
                
                if numOfFlipCards == 6{
                    let alert = UIAlertController(title: "Game Ended", message: "You win start over", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "ok", style: .cancel, handler: { (alert) in
                        self.navigationController?.popViewController(animated: true)
                    }))
                    
                    
                    
                    present(alert, animated: true, completion: nil)
                }
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5, execute: {
                self.previousCard = nil
                self.stopReactToFlip = false
            })
        }
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
