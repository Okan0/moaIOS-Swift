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
    static var token : String = ""

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
    
    static func createGame(gameName: String, roleId: Int) -> Alamofire.Request
    {
        self.headers = ["Authorization":"Basic \(self.token)","content-type":"application/json"]
        var trys : Int = 0
        let req = self.Con.request(.POST, "https://"+self.hostUrl+":8443/MoaIosBeer/rest/v1.01/games/\(self.token)/create=\(gameName)/as=\(roleId)", headers : self.headers, parameters:["":""])
        while trys != 3 {
            sleep(1)
            if req.response?.statusCode != nil{
                print("createGame(): ")
                print("Status Code: \(req.response!.statusCode)  Versuch: \(++trys)")
                break
            }
            else{
                trys++
            }
        }
        return req
    }
    
    static func getMyGames(callback: ((resp: AnyObject?)->Void)?){
        self.headers = ["Authorization":"Basic \(self.token)"]
        self.Con.request(.GET, "https://"+self.hostUrl+":8443/MoaIosBeer/rest/v1.01/users/\(self.token)/games", headers : self.headers).responseJSON{ response in
                callback?(resp: response.result.value)
        }
    }
    
    static func getOpenGames(callback: ((resp: AnyObject?)->Void)?){
        self.headers = ["Authorization":"Basic \(self.token)"]
        self.Con.request(.GET, "https://"+self.hostUrl+":8443/MoaIosBeer/rest/v1.01/games/\(self.token)/open", headers : self.headers).responseJSON{ response in
            callback?(resp: response.result.value)
        }
    }
    
    static func getGameInfo(gameId: String,callback: ((resp: AnyObject?)->Void)?)
    {
        self.headers = ["Authorization":"Basic \(self.token)"]
        self.Con.request(.GET, "https://"+self.hostUrl+":8443/MoaIosBeer/rest/v1.01/games/\(self.token)/myplaysheet=\(gameId)", headers : self.headers).responseJSON{ response in
            callback?(resp: response.result.value)
        }
    }
    
    static func joinGame(gameId: String, roleId: Int) -> Alamofire.Request
    {
        self.headers = ["Authorization":"Basic \(self.token)","content-type":"application/json"]
        var trys : Int = 0
        let req = self.Con.request(.POST, "https://"+self.hostUrl+":8443/MoaIosBeer/rest/v1.01/games/\(self.token)/join=\(gameId)/as=\(roleId)", headers : self.headers, parameters : ["":""])
        while trys != 3 {
            sleep(1)
            if req.response?.statusCode != nil{
                print("joinGame(): ")
                print("Status Code: \(req.response!.statusCode)  Versuch: \(++trys)")
                break
            }
            else{
                trys++
            }
        }
        
        return req
    }
    
    static func login() -> Alamofire.Request
    {
        var trys : Int = 0
        let req = self.Con.request(.GET, "https://"+self.hostUrl+":8443/MoaIosBeer/rest/v1.01/login", headers : self.headers)
        while trys != 3 {
            sleep(1)
            if req.response?.statusCode != nil{
                print("login(): ")
                print("Status Code: \(req.response!.statusCode)  Versuch: \(++trys)")
                break
            }
            else{
                trys++
            }
        }
        return req
    }
    
    static func register() -> Alamofire.Request
    {
        self.headers = ["Authorization":"Basic cmVnaXN0ZXI6cmVnaXN0ZXI=","content-type":"application/json"]
        var trys : Int = 0
        let req = self.Con.request(.POST, "https://"+self.hostUrl+":8443/MoaIosBeer/rest/v1.01/users/"+self.token+"/new", headers : self.headers, parameters:["":""])
        while trys != 3 {
            sleep(1)
            if req.response?.statusCode != nil{
                print("register(): ")
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