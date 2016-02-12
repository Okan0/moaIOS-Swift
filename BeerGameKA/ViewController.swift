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

class ViewController: UIViewController {
    
    @IBOutlet weak var display: UILabel!
    
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
    
    @IBAction func TestRequest(sender: UIButton) {
        let title = sender.currentTitle
        display.text="Ich habe \(title) gedrueckt"
//        
//        let serverTrustPolicies: [String: ServerTrustPolicy] = [
//        "192.168.137.1:843": .DisableEvaluation]
        let headers = ["Authorization": "Basic SWNoOjEyMzQ="]
        print("Ich bin dumm!")
        Manager.request(.GET, "https://192.168.137.1:8443/MoaIosBeer/rest/v1.01/users", headers: headers)
            .responseJSON { response in
                print(response.request)  // original URL request
                print(response.response) // URL response
                print(response.data)     // server data
                print(response.result)   // result of response serialization
                
                if let JS = response.result.value {
                    //print("JSON: \(JS)")
                    for user in JS.array {
                        print("user: \(user)")
                    }
                }
        }
        
        
        
        //        {   id = 6;
        //            password = 1234;
        //            roles = ();
        //            username = JonFire;}
        
        
        
    }
}
