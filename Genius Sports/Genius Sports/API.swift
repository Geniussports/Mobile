//
//  API.swift
//  Genius Sports
//
//  Created by Nick Cowart on 3/7/15.
//  Copyright (c) 2015 Richard Tyran. All rights reserved.
//

import Foundation

let API_URL = "https://geniussports.herokuapp.com/"


protocol SignedInProtocol {
    func goToApp()
    func signInUnsuccesful(error: String)
    
}

typealias ResponseBlock = (responseInfo: [String : AnyObject]) -> ()

class APIRequest {
    
    // (responseInfo: [String : AnyObject]) -> ()
    
    class func requestWithEndpoint(endpoint: String, method: String, completion:ResponseBlock) {
        
        var options = [
            
            "endpoint" : endpoint,
            "method" : method,
            "body" : [
                
                "user" : ["authentication_token" : User.currentUser().token!]
            ]
            
            ] as [String:AnyObject]
        
        requestWithOptions(options, andCompletion: completion)
        
        
    }
    
    class func  requestWithOptions(options: [String : AnyObject], andCompletion completion: (responseInfo: [String : AnyObject]) -> ()) {
        
        var url = NSURL(string: API_URL + (options["endpoint"] as String)) //ask about parenth
        
        var request = NSMutableURLRequest(URL: url!)
        
        request.HTTPMethod = options["method"] as String
        
        //// BODY
        
        let bodyInfo = options["body"] as [String:AnyObject]
        
        let requestData = NSJSONSerialization.dataWithJSONObject(bodyInfo, options: NSJSONWritingOptions.allZeros, error: nil)
        
        let jsonString = NSString(data: requestData!, encoding: NSUTF8StringEncoding)
        
        let postLength = "\(jsonString!.length)"
        
        request.setValue(postLength, forHTTPHeaderField: "Content-Length")
        
        let postData = jsonString?.dataUsingEncoding(NSASCIIStringEncoding, allowLossyConversion: true)
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        request.HTTPBody = postData
        
        
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) { (response, data, error) -> Void in
            
            if error == nil{
                
                // do something with data
                let json = NSJSONSerialization.JSONObjectWithData(data, options: .MutableContainers, error: nil) as [String:AnyObject]
                
                completion(responseInfo: json)
                
            }else{
                
                println(error)
                
            }
        }
        
    }
    
}

private let _currentUser = User()

class User {
    
    
    var delegate: LoginVC?
    
    var token: String?{
        
        didSet {
            
            let defaults = NSUserDefaults.standardUserDefaults()
            defaults.setObject(token, forKey: "token")
            defaults.synchronize()
            
            println(token)
            
            
        }
    }
    
    init(){
        
        let defaults = NSUserDefaults.standardUserDefaults()
        token = defaults.objectForKey("token") as? String
        
    }
    
    class func currentUser() -> User { return _currentUser }
    
    // Change To GET INSTEAD OF POST
    func getUserToken(email: String, password: String) {
        
        
        // the key names are for us (we chose the name of the keynames, the values are going to be used for url request)
        let options: [String:AnyObject] = [
            
            "endpoint": "users",
            "method": "POST",
            "body": [
                
                "user": [ "email": email, "password": password ]
                
                
            ]
        ]
        
        
        // responseInfo will be set at the end of the requestwithoptions function: (completion: requestWithoptions), then we will print responseInfo
        APIRequest.requestWithOptions(options, andCompletion: { (responseInfo) -> () in
            
            
            println(responseInfo)
            
            //            if error != nil {
            //
            //                println("Error != nil")
            //                self.delegate?.signInUnsuccesful(error!)
            //            }
            
            //            else {
            
            
            //                println(responseInfo!)
            if let dataInfo: AnyObject = responseInfo["user"] {
                if let token = dataInfo["authentication_token"] as? String {
                    self.token = token
                }
                
                
                
                
                self.delegate?.goToApp()
                
            }
                
                
                
                
                
            else {
                
                println("No data Info")
                self.delegate?.signInUnsuccesful(responseInfo.description)
            }
            //            }
            
            // do something here after request is done
            
        })
    }
    
    func login(email: String, password: String){
        
        let options: [String:AnyObject] = [
            
            "endpoint": "users/sign_in",
            "method": "POST",
            "body": [
                
                "user": [ "email": email, "password": password ]
                
                
            ]
        ]
        
        
        // responseInfo will be set at the end of the requestwithoptions function: (completion: requestWithoptions), then we will print responseInfo
        APIRequest.requestWithOptions(options, andCompletion: { (responseInfo) -> () in
            
            
            println(responseInfo)
            
            //            if error != nil {
            //
            //                println("Error != nil")
            //                self.delegate?.signInUnsuccesful(error!)
            //            }
            
            //            else {
            
            
            //                println(responseInfo!)
            if let dataInfo: AnyObject = responseInfo["user"] {
                if let token = dataInfo["authentication_token"] as? String {
                    self.token = token
                }
                
                
                
                
                self.delegate?.goToApp()
                
            }
                
                
                
                
                
            else {
                
                println("No data Info")
                self.delegate?.signInUnsuccesful(responseInfo.description)
            }
            //            }
            
            // do something here after request is done
            
        })
    }
    
}
