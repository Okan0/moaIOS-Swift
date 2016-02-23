//
//  dashBoard.swift
//  BeerGameKA
//
//  Created by John on 22.02.16.
//  Copyright © 2016 John. All rights reserved.
//

import UIKit


class dashBoard : UIViewController, UITableViewDelegate, UIPickerViewDataSource, UIPickerViewDelegate{
    

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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for(var i: Int = 0 ; i <= 1000; i++){
            arra.addObject(i)
        }
  
    }
    
    //Diese Funktion wird ausgeführt wenn auf "Bestellen" geklickt wird...
    //..Sie überprüft ob die "Weiterleitung" ausgeführt wird oder nicht
    override func shouldPerformSegueWithIdentifier(identifier: String, sender: AnyObject?) -> Bool {
        
        if identifier == "createSegue" {
            

            var zahl = Int(neueBestellung.text!)
            
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
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return " \(arra[row])"
    }
}