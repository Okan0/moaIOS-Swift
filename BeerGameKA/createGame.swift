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
    
    @IBOutlet weak var gameName: UITextField!
    var items = ["Wholesaler","Distributor","Retailer", "Factory"]
    var pics = ["wholesale.png","lorry_green_64.png","einkaufswagen.png", "factory.png"]
    var selected = -1
    
    var token = String()
    var host = String()
    
    @IBOutlet weak var myCollectionView: UICollectionView!
    
    //Diese Funktion wid ausgeführt, wenn die View geladen wird
    override func viewDidLoad() {
        super.viewDidLoad()
        self.myCollectionView.dataSource=self
        myCollectionView.delegate=self
    }
    
    //Diese Funktion gibt an, wie viele Elemente in der Collection View enthalten sind
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.items.count
    }
    
    //Füllt alle Cells der Collection View
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as! myCollectionViewCell
        
        cell.myLabel.text = self.items[indexPath.row]
        cell.myImage.image = UIImage(named: pics[indexPath.row])

        return cell
    }
    
    //Diese Funktion wird ausgeführt, wenn die Wahl eines Elements aufgehoben wird
    func collectionView(collectionView: UICollectionView, didDeselectItemAtIndexPath indexPath: NSIndexPath) {
        print("You deselected cell #\(indexPath.item)!")
        let cell : UICollectionViewCell = collectionView.cellForItemAtIndexPath(indexPath)!
        cell.backgroundColor = UIColor.clearColor()
    }
    
    //Diese Funktion wird ausgeführt wenn ein neues Element ausgewählt wird
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        print("You selected cell #\(indexPath.item)!")
        let cell : UICollectionViewCell = collectionView.cellForItemAtIndexPath(indexPath)!
        cell.backgroundColor = UIColor.greenColor()
        
        selected = indexPath.row
    }
    
    //Diese Funktion wird ausgeführt wenn auf "Create" geklickt wird...
    //..Sie überprüft ob die "Weiterleitung" ausgeführt wird oder nicht
    override func shouldPerformSegueWithIdentifier(identifier: String, sender: AnyObject?) -> Bool {
        
        if identifier == "createSegue" {
            if (gameName.text!.isEmpty) {
                let alert=UIAlertController(title: "Keine Name", message: "Bitte geben Sie einen Namen für das Spiel ein", preferredStyle: UIAlertControllerStyle.Alert);
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil));
                showViewController(alert, sender: self);
                
                return false
            }
            if(selected<0){
                let alert=UIAlertController(title: "Keine Rolle", message: "Bitte wählen Sie eine Rolle aus!", preferredStyle: UIAlertControllerStyle.Alert);
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil));
                showViewController(alert, sender: self);
                return false
            }
            
            return RestClient.createGame(gameName.text!, roleId: selected).response?.statusCode==1001
        }
        
        return true
    }
    
    //Diese Funktion wird ausgeführt wenn auf "Join" geklickt wird...
    //...und shouldPerformSegueWithIdentifier erfolgreich war
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if (segue.identifier == "createSegue") {
            let temp = segue.destinationViewController as! myGames
            temp.host = host
            temp.token = token
        }
    }
}
