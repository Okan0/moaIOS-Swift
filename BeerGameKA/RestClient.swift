//
//  HTTPClient.swift
//  BeerGameKA
//
//  Created by John on 16.02.16.
//  Copyright © 2016 John. All rights reserved.
//

import Foundation
import Alamofire

class RestClient {
    
    static var hostUrl : String = ""// Hostadresse ohne Port

    /*Wichtig Alle Funktionen dieser Klasse die eine Http Verbindung mittels Alamofire aufbauen, sind Asynchron*/
    
    /*Diese Funktion dient allein zum Testen ob der Host erreichbar ist und Antwortet 
    => Antwort: Http 200 OK = erreichbar
    => Antwort: Http != 200 = nicht erreichbar*/
    static func connCheck() -> Alamofire.Request{
        
        var trys : Int = 0
        let req = self.Con.request(.GET, "https://"+self.hostUrl+":8443/MoaIosBeer")
        while trys != 3 {
            sleep(1)
            if req.response?.statusCode != nil{
                print("Status Code: \(req.response!.statusCode)  Versuch: \(trys)")
                break
            }
            else{
                trys++
            }
        }
        return req
    }
    
    //TODO Weitere Funktion fuer die benoetigten Rest Calls gegen die API schreiben
    static func authCheck(headers :  [String : String] ) -> Alamofire.Request{
        
        var trys : Int = 0
        let req = self.Con.request(.GET, "https://"+self.hostUrl+":8443/MoaIosBeer/rest/v1.01/users", headers: headers)
        while trys != 3 {
            sleep(1)
            if req.response?.statusCode != nil{
                print("Status Code: \(req.response!.statusCode)  Versuch: \(trys)")
                break
            }
            else{
                trys++
            }
        }
        return req
    }
    
    // Vertrauenswuerdige Server
    static var Con: Alamofire.Manager = {
        var serverTrustPolicies: [String: ServerTrustPolicy] = [
            "192.168.137.1": .DisableEvaluation,
            "192.168.137.1:8443": .DisableEvaluation,
            "192.168.137.1:8080": .DisableEvaluation,
            "192.168.137.1:80": .DisableEvaluation,
            "192.168.173.1": .DisableEvaluation,
            "192.168.173.1:8443": .DisableEvaluation,
            "192.168.173.1:8080": .DisableEvaluation,
            "192.168.173.1:80": .DisableEvaluation]
        
        var configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
        configuration.HTTPAdditionalHeaders = Alamofire.Manager.defaultHTTPHeaders
        
        return Alamofire.Manager(configuration: configuration, serverTrustPolicyManager: ServerTrustPolicyManager(policies: serverTrustPolicies))
    }()
} // Client Ende