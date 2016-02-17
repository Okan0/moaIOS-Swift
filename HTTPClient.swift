//
//  HTTPClient.swift
//  BeerGameKA
//
//  Created by John on 16.02.16.
//  Copyright © 2016 John. All rights reserved.
//

import Alamofire

class HTTPClient {
    
    init(){
    }
    var hostUrl : String = ""
    // 192.168.137.1:8443/MoaIosBeer/
    
    func sethostUrl (url : String){
        self.hostUrl = url
    }
    
    func gethostUrl() -> String{
        return self.hostUrl
    }
    
    let Con: Alamofire.Manager = {
        let serverTrustPolicies: [String: ServerTrustPolicy] =  [   "192.168.137.1": .DisableEvaluation,
            "192.168.137.1:8443": .DisableEvaluation,
            "192.168.137.1:8080": .DisableEvaluation,
            "192.168.137.1:80": .DisableEvaluation,
            "192.168.173.1": .DisableEvaluation,
            "192.168.173.1:8443": .DisableEvaluation,
            "192.168.173.1:8080": .DisableEvaluation,
            "192.168.173.1:80": .DisableEvaluation
        ]
        
        let configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
        configuration.HTTPAdditionalHeaders = Alamofire.Manager.defaultHTTPHeaders
        
        return Alamofire.Manager(   configuration: configuration,
            serverTrustPolicyManager: ServerTrustPolicyManager(policies: serverTrustPolicies)
        )
    }()
    
    
    
} // Client Ende

