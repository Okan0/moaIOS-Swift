//
//  chooseRole.swift
//  BeerGameKA
//
//  Created by John on 14.02.16.
//  Copyright © 2016 John. All rights reserved.
//

import UIKit

class chooseRoleView : UIViewController, UICollectionViewDataSource, UICollectionViewDelegate{
    var items = ["Retailer","Wholesaler","Distributor","Factory"]
    var pics = ["einkaufswagen.png","wholesale.png","lorry_green_64.png","factory.png"]
    var selected = -1
    
    var token = String()
    var host = String()
    var gameID = String()
    
    @IBOutlet weak var navTitle: UINavigationItem!
    @IBOutlet weak var roleCollectionView: UICollectionView!
    
    //Diese Funktion wid ausgeführt, wenn die View geladen wird
    override func viewDidLoad() {
        super.viewDidLoad()
        roleCollectionView.dataSource=self
        roleCollectionView.delegate=self
        
        print("Received-ID  : \(gameID)")
        
        //TODO myPlaysheet=gameID abfragen, um die verfügbaren Rollen zu erhalten
    }
    
    //Diese Funktion gibt an, wie viele Elemente in der Collection View enthalten sind
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.items.count
    }
    
    //Füllt alle Cells der Collection View
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as! myCollectionViewCell

        cell.myLabel.text = self.items[indexPath.row]
        
        let origImage = UIImage(named: pics[indexPath.row]);
        
        //TODO falls die rolle vergeben ist...
        if indexPath.row%2==0 {
            let tintedImage = origImage?.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
            cell.myImage.image = tintedImage
            cell.myImage.tintColor = UIColor.grayColor()
        }
        else{
            cell.myImage.image = origImage
        }
        return cell
    }
    
    //Diese Funktion wird ausgeführt, wenn die Wahl eines Elements aufgehoben wird
    func collectionView(collectionView: UICollectionView, didDeselectItemAtIndexPath indexPath: NSIndexPath) {
        print("You deselected cell #\(indexPath.item)!")
        let cell : UICollectionViewCell = collectionView.cellForItemAtIndexPath(indexPath)!
        cell.backgroundColor = UIColor.clearColor()
    }
    
    //Diese Funktion wird ausgeführt wenn ein neues Element ausgewählt wird...
    //...Sie überprüft ob didSelectItemAtIndexPath und didDeselectItemAtIndexPath...
    //...ausgeführt werden
    func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        if indexPath.row%2==0{
            return false
        }
        return true
    }
    
    //Diese Funktion wird ausgeführt wenn ein neues Element ausgewählt wird...
    //...und shouldSelectItemAtIndexPath erfolgreich war
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let cell : UICollectionViewCell = collectionView.cellForItemAtIndexPath(indexPath)!
        cell.backgroundColor = UIColor.greenColor()
    }

    //Diese Funktion wird ausgeführt wenn auf "Join" geklickt wird...
    //..Sie überprüft ob die "Weiterleitung" ausgeführt wird oder nicht
    override func shouldPerformSegueWithIdentifier(identifier: String, sender: AnyObject?) -> Bool {
        
        if identifier == "joinSegue" {
            if(selected<0){
                let alert=UIAlertController(title: "Keine Rolle", message: "Bitte wählen Sie eine Rolle aus!", preferredStyle: UIAlertControllerStyle.Alert);
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil));
                showViewController(alert, sender: self);
                return false
            }
            
            //TODO Spiel beitreten und auf den Status-Code holen
            //  OK    -> /
            //  Sonst -> return false
        }
        return true
    }
    
    //Diese Funktion wird ausgeführt wenn auf "Join" geklickt wird...
    //...und shouldPerformSegueWithIdentifier erfolgreich war
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if (segue.identifier == "joinSegue") {
            let temp = segue.destinationViewController as! myGames
            temp.host = host
            temp.token = token
        }
    }

    
}
