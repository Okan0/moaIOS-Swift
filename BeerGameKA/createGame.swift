//
//  createGame.swift
//  BeerGameKA
//
//  Created by John on 10.02.16.
//  Copyright © 2016 John. All rights reserved.
//

import UIKit

class myCollectionViewCell : UICollectionViewCell{

    @IBOutlet weak var myImage: UIImageView!
    @IBOutlet weak var myLabel: UILabel!
}

class createGame : UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    var items = ["Retailer","Wholesaler","Distributor","Factory"]
    var pics = ["einkaufswagen.png","wholesale.png","lorry_green_64.png","factory.png"]
    
    @IBOutlet weak var myCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.myCollectionView.dataSource=self
        myCollectionView.delegate=self
    }
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.items.count
    }
    
    // make a cell for each cell index path
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        // get a reference to our storyboard cell
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as! myCollectionViewCell
        
        // Use the outlet in our custom class to get a reference to the UILabel in the cell
        cell.myLabel.text = self.items[indexPath.row]
        let origImage = UIImage(named: pics[indexPath.row]);
        //falls die rolle vergeben ist...
        if indexPath.row%2==0 {
            let tintedImage = origImage?.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
            cell.myImage.image = tintedImage
            cell.myImage.tintColor = UIColor.grayColor()
        }
        else{
            cell.myImage.image = origImage
        }
        
        //cell.tintColor = UIColor.grayColor()
        return cell
    }
    
    // MARK: - UICollectionViewDelegate protocol
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        // handle tap events
        print("You selected cell #\(indexPath.item)!")
    }
}
