//
//  ViewController.swift
//  BeerGameKA
//
//  Created by John on 10.02.16.
//  Copyright © 2016 John. All rights reserved.
//

import UIKit
import Alamofire
import JSONLib

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    @IBOutlet weak var host: UITextField!
    @IBOutlet weak var myTableView: UITableView!
    //Wird fuer die TableView benoetigt
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //Anzahl der Elemente in der TableView
        return ips.count
    }
    
    //Wird fuer die TableView benoetigt
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        //Der Identifier "Cell" ist fuer die Prototype Cell
        let cell = self.myTableView.dequeueReusableCellWithIdentifier("Cell",forIndexPath: indexPath) as UITableViewCell
        
        var ip : String
        ip = ips[indexPath.row]
        
        cell.textLabel?.text = ip
        
        return cell
    }
    
    func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!) {
        host.text = ips[indexPath.row]
        print(ips[indexPath.row])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Start")
        myTableView.dataSource=self
        myTableView.delegate=self
    }

    var ips = ["192.168.137.1","192.168.173.1"]
    
    private var Manager : Alamofire.Manager = {
        // Create the server trust policies
        let serverTrustPolicies: [String: ServerTrustPolicy] = [
            "192.168.137.1": .DisableEvaluation
        ]
        // Create custom manager
        let configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
        configuration.HTTPAdditionalHeaders = Alamofire.Manager.defaultHTTPHeaders
        let man = Alamofire.Manager(
            configuration: NSURLSessionConfiguration.defaultSessionConfiguration(),
            serverTrustPolicyManager: ServerTrustPolicyManager(policies: serverTrustPolicies)
        )
        return man
    }()
    
//        
//        let serverTrustPolicies: [String: ServerTrustPolicy] = [
//        "192.168.137.1:843": .DisableEvaluation]
//        let headers = ["Authorization": "Basic SWNoOjEyMzQ="]
//        print("Ich bin dumm!")
//        Manager.request(.GET, "https://192.168.137.1:8443/MoaIosBeer/rest/v1.01/users", headers: headers)
//            .responseJSON { response in
//                print(response.request)  // original URL request
//                print(response.response) // URL response
//                print(response.data)     // server data
//                print(response.result)   // result of response serialization
//                
//                if let JS = response.result.value {
//                    //print("JSON: \(JS)")
//                    for user in JS.array {
//                        print("user: \(user)")
//                    }
//                }
//        }
}
