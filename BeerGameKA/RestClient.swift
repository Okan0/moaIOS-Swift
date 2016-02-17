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
    
    static var headers : [String : String] = ["" : ""]// Authorization
    

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
                print("connCheck(): ")
                print("Status Code: \(req.response!.statusCode)  Versuch: \(++trys)")
                break
            }
            else{
                trys++
            }
        }
        return req
    }
    
    //TODO Weitere Funktion fuer die benoetigten Rest Calls gegen die API schreiben
    static func authCheck() -> Alamofire.Request{
        
        var trys : Int = 0
        let req = self.Con.request(.GET, "https://"+self.hostUrl+":8443/MoaIosBeer/rest/v1.01/users", headers : self.headers)
        while trys != 3 {
            sleep(1)
            if req.response?.statusCode != nil{
                print("authCheck(): ")
                print("Status Code: \(req.response!.statusCode)  Versuch: \(++trys)")
                break
            }
            else{
                trys++
            }
        }
        return req
    }
    /*
    
    Alamofire.request(.GET, url).validate().responseJSON{ response in
        switch response.result {
            case .Success:  // Serverantwort erhalten.
                if let value = response.result.value{
                    let json = JSON(value)
                    print("JSON: \(json)")
                }
            case .Failure(let error):   // Server antwortet nicht.
                print(error)
        }
    }
    
    */
    
    
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