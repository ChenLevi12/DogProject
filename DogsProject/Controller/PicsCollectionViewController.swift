//
//  PicsCollectionViewController.swift
//  DogsProject
//
//  Created by chen levi on 17.12.2017.
//  Copyright © 2017 chen levi. All rights reserved.
//

import UIKit


class PicsCollectionViewController: UICollectionViewController {
    var selectedDog : String!
    var allPics: [String] = []
    var dogsUrlPics: [String] = []
    var selectedImageString : String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ApiRequest.shared.getDogImages(name: selectedDog) { (data) in
            self.allPics = data
            self.addToArray()
            self.collectionView?.reloadData()
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        let width = self.view.frame.width
        let pass : CGFloat = 10
        let layout = self.collectionViewLayout as! UICollectionViewFlowLayout
        
        
        if UIDeviceOrientationIsPortrait(UIDevice.current.orientation){
            layout.itemSize.width = width / 2 - pass
            layout.itemSize.height = width / 2 - pass
        }else{
            layout.itemSize.width = width / 3 - pass
            layout.itemSize.height = width / 3 - pass
        }
    }
    
    
    var countInAllPics = 0
    func addToArray() -> [IndexPath]{
        var indexPath : [IndexPath] = []
        print("add list")
        
        for _ in 1...10{
            if dogsUrlPics.count == allPics.count{return indexPath}
            dogsUrlPics.append(allPics[countInAllPics])
            let index = IndexPath(item: countInAllPics, section: 0)
            indexPath.append(index)
            countInAllPics += 1
            
        }
        
        return indexPath
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return dogsUrlPics.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellPics", for: indexPath) as! PicsCollectionViewCell
        
        let url = URL(string: dogsUrlPics[indexPath.item])!
        URLSession.shared.dataTask(with: url) { (data, res, err) in
            guard let data = data else{return}
            DispatchQueue.main.async {
                let image = UIImage(data: data)
                cell.image.image = image
            }
            
        }.resume()
        
        return cell
    }

    let threshold = CGFloat(0)
    var isLoadingMore = false
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.isDragging{
            let contentOffset = scrollView.contentOffset.y
            let maxOffset = scrollView.contentSize.height - scrollView.frame.size.height
            
            if !isLoadingMore && (maxOffset - contentOffset <= threshold){
                if allPics.count != dogsUrlPics.count{
                    self.isLoadingMore = true
                    let indexPath = addToArray()
                    
                    
                    DispatchQueue.main.async {
                        
                        self.collectionView?.insertItems(at: indexPath)
                        
                        // self.collectionView?.reloadData()
                    }
                    
                    self.isLoadingMore = false
                }
            }
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let dest = segue.destination as? PicViewController{
            dest.selectedPic = selectedImageString
        }
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        selectedImageString = dogsUrlPics[indexPath.item]
        performSegue(withIdentifier: "toPic", sender: nil)
    }
    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
