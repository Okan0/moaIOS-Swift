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
    
    //Diese Funktion wird ausgeführt, wenn eine andere View aufgerufen werden soll und...
    //...überprüft ob dies erlaubt ist oder nicht
    override func shouldPerformSegueWithIdentifier(identifier: String, sender: AnyObject!) -> Bool {

        if identifier == "hostForward" {
            
            if (host.text!.isEmpty) {
                let alert=UIAlertController(title: "Keine IP", message: "Bitte geben Sie eine IP-Adresse ein", preferredStyle: UIAlertControllerStyle.Alert);
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil));
                showViewController(alert, sender: self);
                
                return false
            }
            
            RestClient.hostUrl = host.text!
            //let headers = ["Authorization": "Basic SWNoOjEyMzQ="]
            let req = RestClient.connCheck().responseJSON {
                response in
                
            }
            
            if  req.response?.statusCode != 200 {
                let alert=UIAlertController(title: "Kein gültige Hostadresse!", message: "Bitte geben Sie eine gültige IP-Adresse ein", preferredStyle: UIAlertControllerStyle.Alert);
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil));
                showViewController(alert, sender: self);
                
                return false
            }
            else{
                return true
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

