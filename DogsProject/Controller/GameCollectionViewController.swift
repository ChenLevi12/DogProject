//
//  GameCollectionViewController.swift
//  DogsProject
//
//  Created by chen levi on 22.12.2017.
//  Copyright © 2017 chen levi. All rights reserved.
//

import UIKit


class GameCollectionViewController: UICollectionViewController {
    var data : [Photo] = []
    var chosenPics : [Photo] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        data = try! DBManager.shared.getPhotos()
        self.collectionView?.reloadData()
        
        self.collectionView?.allowsMultipleSelection = true
        
        
        var items : [UIBarButtonItem] = []
        items.append(UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil))
        items.append(UIBarButtonItem(barButtonSystemItem: .done, target:self, action: #selector(play)))
        items.append(UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil))
        self.setToolbarItems(items, animated: false)
    }

    @objc func play(){
        let indices : [IndexPath] = collectionView?.indexPathsForSelectedItems ?? []
        for index in indices{
            chosenPics.append(data[index.row])
        }
        self.navigationController?.setToolbarHidden(true, animated: true)
        self.performSegue(withIdentifier: "game", sender: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        data = try! DBManager.shared.getPhotos()
        self.collectionView?.reloadData()
        
        let alert = UIAlertController(title: "New Game", message: "choose 6 picturs and press Done!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "ok", style: .cancel, handler: { (alert) in
            self.dismiss(animated: true, completion: nil)
        }))
        present(alert, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let dest = segue.destination as? GameViewController{
            dest.pics = chosenPics
        }
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        let width = self.view.frame.width
        let pass : CGFloat = 10
        let layout = self.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize.width = width / 2 - pass
        layout.itemSize.height = width / 2 - pass
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return data.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "gameCell", for: indexPath) as! GameCollectionViewCell
        
        guard let image = UIImage(data: data[indexPath.item].pic as Data) else{return cell}
        cell.image.image = image
    
        // Configure the cell
    
        return cell
    }

    override func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let selectedCount = collectionView.indexPathsForSelectedItems?.count ?? 0
        self.navigationController?.setToolbarHidden(selectedCount != 6, animated: true)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedCount = collectionView.indexPathsForSelectedItems?.count ?? 0
        self.navigationController?.setToolbarHidden(selectedCount != 6, animated: true)
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
