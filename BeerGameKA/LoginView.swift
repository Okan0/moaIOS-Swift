//
//  LoginView.swift
//  BeerGameKA
//
//  Created by John on 11.02.16.
//  Copyright © 2016 John. All rights reserved.
//

import UIKit

class LoginView : UIViewController {
    
    
    @IBOutlet weak var NameField: UITextField!
    @IBOutlet weak var PasswField: UITextField!
    @IBOutlet weak var LoginButton: UIButton!
    @IBOutlet weak var RegButton: UIButton!
    
    var host = String()
    private var token = String()
    
    override func shouldPerformSegueWithIdentifier(identifier: String, sender: AnyObject!) -> Bool {
        if identifier == "registerSegue" || identifier == "loginSegue" {
            
            if (NameField.text!.isEmpty || PasswField.text!.isEmpty) {
                let alert=UIAlertController(title: "Fehlende Login-Daten", message: "Bitte geben Sie sowohl einen Username, als auch ein Passwort ein!", preferredStyle: UIAlertControllerStyle.Alert);
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil));
                showViewController(alert, sender: self);
                
                return false
            }
            var temp=NameField.text!+":"+PasswField.text!
            var data = temp.dataUsingEncoding(NSUTF8StringEncoding)
            let temptoken = data?.base64EncodedStringWithOptions(NSDataBase64EncodingOptions.Encoding64CharacterLineLength)
            if identifier == "registerSegue"{
                temp="register:register"
                data=temp.dataUsingEncoding(NSUTF8StringEncoding)
                //TODO überprüfen ob registriert werden kann
            }
            else{
                //TODO überprüfen ob eingelogt werden kann
            }
            token = temptoken!
            return true
        }
        
        // by default, transition
        return true
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if (segue.identifier == "hostForward") {
            let menu = segue.destinationViewController as! MenueView
            menu.host = host
            menu.token = token
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
}
