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
    
    var Hostadresse = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let url = NSURL(string: "http://192.168.137.1:8443/MoaIosBeer/rest/v1.01/users")
        
        let task = NSURLSession.sharedSession().dataTaskWithURL(url!) {(data, response, error) in
            print(NSString(data: data!, encoding: NSUTF8StringEncoding))
        }
        
        task.resume()
    }
    
    
}
