//
//  chooseRole.swift
//  BeerGameKA
//
//  Created by John on 14.02.16.
//  Copyright © 2016 John. All rights reserved.
//

import UIKit
import SwiftyJSON

class chooseRoleView : UIViewController, UICollectionViewDataSource, UICollectionViewDelegate{
    var items = ["Wholesaler","Distributor", "Retailer", "Factory"]
    var pics = ["wholesale.png","lorry_green_64.png","einkaufswagen.png", "factory.png"]
    var selected = -1
    var closed : [String] = []
    
    var token = String()
    var host = String()
    var gameID = String()
    
    @IBOutlet weak var navTitle: UINavigationItem!
    @IBOutlet weak var roleCollectionView: UICollectionView!
    
//    func handler(val: AnyObject?){
//        if (val != nil)
//        {
//            let json = JSON(val!)
//            for (var i : Int = 0; i < json.count; i++ ){
//                let role = json[i, "Role"].stringValue
//                self.closed.append(role)
//            }
//        }
//        self.roleCollectionView.reloadData()
//    }
    
    //Diese Funktion wid ausgeführt, wenn die View geladen wird
    override func viewDidLoad() {
        super.viewDidLoad()
        roleCollectionView.dataSource=self
        roleCollectionView.delegate=self
        
        print("Received-ID  : \(gameID)")
        print("items  : \(items[0])")

        
        _ = RestClient.getGameInfo(self.gameID).responseJSON{
            response in
            
            if let val = response.result.value {
                    let json = JSON(val)
                    for (var i : Int = 0; i < json.count; i++ ){
                        let role = json[i, "Role"].stringValue
                        self.closed.append(role)
                    }
                }
                self.roleCollectionView.reloadData()
        }
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
        if closed.contains(items[indexPath.row]) {
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
        print("items  : \(indexPath.row)")
        let cell : UICollectionViewCell = collectionView.cellForItemAtIndexPath(indexPath)!
        cell.backgroundColor = UIColor.clearColor()
    }
    
    //Diese Funktion wird ausgeführt wenn ein neues Element ausgewählt wird...
    //...Sie überprüft ob didSelectItemAtIndexPath und didDeselectItemAtIndexPath...
    //...ausgeführt werden
    func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        if closed.contains(items[indexPath.row]){
            return false
        }
        return true
    }
    
    //Diese Funktion wird ausgeführt wenn ein neues Element ausgewählt wird...
    //...und shouldSelectItemAtIndexPath erfolgreich war
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let cell : UICollectionViewCell = collectionView.cellForItemAtIndexPath(indexPath)!
        cell.backgroundColor = UIColor.greenColor()
        selected = indexPath.row
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
            
            return RestClient.joinGame(self.gameID, roleId: self.selected).response?.statusCode == 200
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
