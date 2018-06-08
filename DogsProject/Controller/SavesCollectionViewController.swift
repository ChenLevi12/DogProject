//
//  SavesCollectionViewController.swift
//  DogsProject
//
//  Created by chen levi on 18.12.2017.
//  Copyright © 2017 chen levi. All rights reserved.
//

import UIKit


class SavesCollectionViewController: UICollectionViewController {

    var data : [Photo] = []
    
    override func viewWillAppear(_ animated: Bool) {
        data = try! DBManager.shared.getPhotos()
        self.collectionView?.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        data = try! DBManager.shared.getPhotos()
        self.collectionView?.reloadData()
        
        var items : [UIBarButtonItem] = []
        items.append(UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil))
        items.append(UIBarButtonItem(barButtonSystemItem: .trash, target:self, action: #selector(trush)))
        items.append(UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil))
        
        self.setToolbarItems(items, animated: false)
        
        self.navigationItem.rightBarButtonItem = self.editButtonItem

        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes

        // Do any additional setup after loading the view.
    }

    override func setEditing(_ editing: Bool, animated: Bool) {
       super.setEditing(editing, animated: animated)
        print("is editing", editing)
        collectionView?.visibleCells.forEach({ (cell) in
            if let cell = cell as? SaveCollectionViewCell{
                cell.isEditing = editing
            }
        })
        collectionView?.allowsMultipleSelection = editing
    }
    
    @objc func trush(){
        print("trushhhhhhhhhhhhhhhhhh")
        let indices : [IndexPath] = collectionView?.indexPathsForSelectedItems ?? []
        
        indices.map{data[$0.item]}.forEach { (photo) in
            if let i = data.index(of: photo){
                data.remove(at: i)
                DBManager.shared.context.delete(photo)
            }
        }
        DBManager.shared.saveContext()
        collectionView?.deleteItems(at: indices)
        self.navigationController?.setToolbarHidden(true, animated: true)

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
        
        layout.itemSize.width = width / 2 - pass
        layout.itemSize.height = width / 2 - pass
        
        
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
        return data.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "saveCell", for: indexPath) as! SaveCollectionViewCell
        
        cell.image.image = UIImage(data: data[indexPath.item].pic as Data)
        cell.isEditing = self.isEditing
        // Configure the cell
    
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let selectedCount = collectionView.indexPathsForSelectedItems?.count ?? 0
        self.navigationController?.setToolbarHidden(selectedCount == 0, animated: true)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if isEditing{
            self.navigationController?.setToolbarHidden(false, animated: true)
            return
        }
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
