//
//  LoginView.swift
//  BeerGameKA
//
//  Created by John on 11.02.16.
//  Copyright © 2016 John. All rights reserved.
//

import UIKit
import Alamofire

class LoginView : UIViewController {
    
    
    @IBOutlet weak var NameField: UITextField!
    @IBOutlet weak var PasswField: UITextField!
    @IBOutlet weak var LoginButton: UIButton!
    @IBOutlet weak var RegButton: UIButton!
    
    var host = String()
    private var token = String()
    
    let Manager : Alamofire.Manager = {
        // Create the server trust policies
        let serverTrustPolicies: [String: ServerTrustPolicy] = [
            "192.168.137.1": .DisableEvaluation,
            "192.168.137.1:8443": .DisableEvaluation,
            "192.168.137.1:8080": .DisableEvaluation,
            "192.168.137.1:80": .DisableEvaluation,
            "192.168.173.1": .DisableEvaluation,
            "192.168.173.1:8443": .DisableEvaluation,
            "192.168.173.1:8080": .DisableEvaluation,
            "192.168.173.1:80": .DisableEvaluation]
        
        // Create custom manager
        let configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
        configuration.HTTPAdditionalHeaders = Alamofire.Manager.defaultHTTPHeaders
        let man = Alamofire.Manager(
            configuration: NSURLSessionConfiguration.defaultSessionConfiguration(),
            serverTrustPolicyManager: ServerTrustPolicyManager(policies: serverTrustPolicies)
        )
        return man
    }()
    
    //Diese Funktion wird ausgeführt, wenn eine andere View aufgerufen werden soll und...
    //...überprüft ob dies erlaubt ist oder nicht
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
            
            let url : String = ""
            let headers = ["Authorization": "Basic SWNoOjEyMzQ="]
            
            if identifier == "registerSegue"{
                temp="register:register"
                data=temp.dataUsingEncoding(NSUTF8StringEncoding)
                //TODO überprüfen ob registriert werden kann
                //  OK    -> /
                //  Sonst -> return false
            }
            else{
                //TODO überprüfen ob eingelogt werden kann
                //  OK    -> /
                //  Sonst -> return false
                
                Manager.request(.GET, "https://"+url+":8443/MoaIosBeer/rest/v1.01/users", headers: headers).responseJSON {
                    response in
                    
  
                    
                }
            }
            token = temptoken!
            return true
        }
        return true
    }
    
    //Diese Funktion wird ausgeführt, wenn eine andere View aufgerufen werden soll und...
    //...die Überprüfung erfolgreich war.
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if (segue.identifier == "hostForward") {
            let menu = segue.destinationViewController as! MenueView
            menu.host = host
            menu.token = token
            
        }
    }
}
