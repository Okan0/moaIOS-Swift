//
//  ViewController.swift
//  BeerGameKA
//
//  Created by John on 10.02.16.
//  Copyright © 2016 John. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    @IBOutlet weak var host: UITextField!
    @IBOutlet weak var myTableView: UITableView!
    
    
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
    
     //Wird fuer die TableView benoetigt
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //Anzahl der Elemente in der TableView
        return ips.count
    }
    
    //Diese Funktion füllt die Tabelle mit "Leben"
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        //Der Identifier "Cell" ist fuer die Prototype Cell
        let cell = self.myTableView.dequeueReusableCellWithIdentifier("Cell",forIndexPath: indexPath) as UITableViewCell
        
        var ip : String
        ip = ips[indexPath.row]
        
        cell.textLabel?.text = ip
        
        return cell
    }
    
    //Diese Funktion wird ausgeführt, wenn ein Element in der Tabelle ausgewählt wird
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        host.text = ips[indexPath.row]
        print(ips[indexPath.row])
    }
    
    //Diese Funktion wid ausgeführt, wenn die View geladen wird
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Start")
        myTableView.dataSource=self
        myTableView.delegate=self
   
    }
    
    func get(url : String , headers :  [String : String] ) -> Bool {
    
        var hostTest : Bool = false
        if hostTest == false {
        
        Manager.request(.GET, "https://"+url+":8443/MoaIosBeer/rest/v1.01/users", headers: headers).responseJSON {
    
            response in
    
            let rescode : Int
            if response.response?.statusCode != nil {
                rescode  = response.response!.statusCode
            }
            else{
                rescode = 666
            }
            //
            if rescode != 200 {
                print("!=200 --> ⁄(rescode)")
                hostTest = false
            }
            else if rescode == 200 {
                print(" =200 -->⁄(rescode)")
                hostTest = true
            }
            
        }
           
            
        }
        
         return hostTest
       
    }
    
    
    //Diese Funktion wird ausgeführt, wenn eine andere View aufgerufen werden soll und...
    //...überprüft ob dies erlaubt ist oder nicht
    override func shouldPerformSegueWithIdentifier(identifier: String, sender: AnyObject!) -> Bool {
        if identifier == "hostForward" {
            
            let headers = ["Authorization": "Basic SWNoOjEyMzQ="]
            
            if (host.text!.isEmpty) {
                let alert=UIAlertController(title: "Keine IP", message: "Bitte geben Sie eine IP-Adresse ein", preferredStyle: UIAlertControllerStyle.Alert);
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil));
                showViewController(alert, sender: self);
                
                return false
            }
            else if get(host.text!, headers: headers) == false {
                let alert=UIAlertController(title: "Kein gültige Hostadresse!", message: "Bitte geben Sie eine gültige IP-Adresse ein", preferredStyle: UIAlertControllerStyle.Alert);
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil));
                showViewController(alert, sender: self);
                
                return false
            }
            
            
        }
        return true
    }
    
    //Diese Funktion wird ausgeführt, wenn eine andere View aufgerufen werden soll und...
    //...die Überprüfung erfolgreich war.
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if (segue.identifier == "hostForward") {
            let login = segue.destinationViewController as! LoginView
            login.host = host.text!
        }
    }

    var ips = ["192.168.137.1","192.168.173.1"]
}

//// Konstante zur Verbindung fuer die Hostconnection
//let serverTrustPolicies: [String: ServerTrustPolicy] = [
//    "192.168.137.1:8443": .DisableEvaluation]
//let headers = ["Authorization": "Basic SWNoOjEyMzQ="]
//
//Manager.request(.GET, "https://192.168.173.1:8443/MoaIosBeer", headers: headers)
//    .responseJSON { response in
//        print(response.request)  // original URL request
//        print(response.response) // URL response
//        print(response.data)     // server data
//        print(response.result)   // result of response serialization
//        
//        if let JS = response.result.value {
//            //print("JSON: \(JS)")
//            for user in JS.array {
//                print("user: \(user)")
//            }
//        }
//}


