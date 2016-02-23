//
//  dashBoard.swift
//  BeerGameKA
//
//  Created by John on 22.02.16.
//  Copyright © 2016 John. All rights reserved.
//

import UIKit
import SwiftyJSON

struct playSheet{
     var owner_id:String
     var backorder:String
     var round:String
}
class dashBoard : UIViewController, UITableViewDelegate{
    

    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var roleField: UILabel!
    @IBOutlet weak var roundField: UILabel!
    @IBOutlet weak var inventoryField: UILabel!
    @IBOutlet weak var backorderField: UILabel!
    @IBOutlet weak var costsField: UILabel!
    @IBOutlet weak var nextIncomingField: UILabel!
    @IBOutlet weak var averageOrderField: UILabel!
    @IBOutlet weak var neueBestellung: UITextField!
    @IBOutlet weak var bestellButton: UIButton!
    @IBOutlet weak var valuePicker: UIPickerView!
    
    var arra:NSMutableArray = []
    var newOrder : String = ""
    var gameID = String()
    var sheet : [playSheet] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for(var i: Int = 0 ; i <= 1000; i++){
            arra.addObject(i)
        }
        
        _ = RestClient.getGameInfo(self.gameID).responseJSON{
            response in
            
            if let val = response.result.value {
                let json = JSON(val)
                for (var i : Int = 0; i < json.count; i++ ){
                    
                    self.roleField.text = self.roleField.text! + json[i, "Role"].stringValue
                    self.averageOrderField.text = self.averageOrderField.text! + json[i, "average_order"].stringValue
                    self.costsField.text = self.costsField.text! + json[i, "costs"].stringValue
                    self.inventoryField.text = self.inventoryField.text! + json[i, "aviable"].stringValue
                    self.nextIncomingField.text = self.nextIncomingField.text! + json[i, "next_inc"].stringValue
                    self.newOrder = json[i, "delivered"].stringValue
                    self.sheet.append(playSheet(owner_id: json[i, "owner_id"].stringValue, backorder: json[i, "backorder"].stringValue, round: json[i, "round"].stringValue))
                    //self.closed.append(role)
                }
            }
            //self.roleCollectionView.reloadData()
        }
        
        //self.backorderField.text = self.backorderField.text! +
    }
    
    //Diese Funktion wird ausgeführt wenn auf "Bestellen" geklickt wird...
    //..Sie überprüft ob die "Weiterleitung" ausgeführt wird oder nicht
    override func shouldPerformSegueWithIdentifier(identifier: String, sender: AnyObject?) -> Bool {
        
        if identifier == "createSegue" {
            

            let zahl = Int(neueBestellung.text!)
            
            if (neueBestellung.text!.isEmpty) {
                let alert=UIAlertController(title: "Keine Wert", message: "Bitte geben Sie einen Menge für die Bestellung ein", preferredStyle: UIAlertControllerStyle.Alert);
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil));
                showViewController(alert, sender: self);
                
                return false
            }
            if(zahl < 0){
                let alert=UIAlertController(title: "Falscher Wert", message: "Bitte geben Sie eine Zahl ein!", preferredStyle: UIAlertControllerStyle.Alert);
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil));
                showViewController(alert, sender: self);
                return false
            }
            if(zahl < 0){
                let alert=UIAlertController(title: "Falscher Wert", message: "Bitte geben Sie eine positive Zahl ein!", preferredStyle: UIAlertControllerStyle.Alert);
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil));
                showViewController(alert, sender: self);
                return false
            }
            
            //return RestClient.createGame(gameName.text!, roleId: selected).response?.statusCode==1001
        }
        
        return true
    }
    
}