//
//  LoginVC.swift
//  Genius Sports
//
//  Created by Richard Tyran on 3/7/15.
//  Copyright (c) 2015 Richard Tyran. All rights reserved.
//

import UIKit

class LoginVC: UIViewController,SignedInProtocol {

    @IBOutlet var emailField: UITextField!
    @IBOutlet var passwordField: UITextField!
    
    @IBAction func loginPressed(sender: AnyObject) {
        
        var message = ""
        
        if emailField.text?.lengthOfBytesUsingEncoding(NSUTF8StringEncoding) == 0 {
            message = "Please provide email"
        }
        
        if passwordField.text?.lengthOfBytesUsingEncoding(NSUTF8StringEncoding) == 0 {
            message = "Please provide password"
        }
        
        
        if message.lengthOfBytesUsingEncoding(NSUTF8StringEncoding) != 0 {
            var alert:UIAlertView = UIAlertView(title: "Message", message: message, delegate: nil, cancelButtonTitle: "Ok")
            
            alert.show()
        }
            
        else {
            User.currentUser().login(emailField.text, password: passwordField.text)
        }
        
        
    }
    
 
    
    @IBAction func createAccountPressed(sender: AnyObject) {
        
        var message = ""
        
        if emailField.text?.lengthOfBytesUsingEncoding(NSUTF8StringEncoding) == 0 {
            message = "Please provide email"
        }
        
        if passwordField.text?.lengthOfBytesUsingEncoding(NSUTF8StringEncoding) == 0 {
            message = "Please provide password"
        }
        
        
        if message.lengthOfBytesUsingEncoding(NSUTF8StringEncoding) != 0 {
            var alert:UIAlertView = UIAlertView(title: "Message", message: message, delegate: nil, cancelButtonTitle: "Ok")
            
            alert.show()
        }
            
        else {
            User.currentUser().getUserToken(emailField.text, password: passwordField.text)
        }
        
        
    }
    
    func goToApp() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil);
        let vc = storyboard.instantiateViewControllerWithIdentifier("Main") as UINavigationController
        
        
        
        UIApplication.sharedApplication().keyWindow?.rootViewController = vc
    }
    
    func signInUnsuccesful(error: String) {
        var alert:UIAlertView = UIAlertView(title: "SignIn Unsuccesful", message: error, delegate: nil, cancelButtonTitle: "Ok")
        
        alert.show()
    }
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        User.currentUser().delegate = self
        
        if let token = User.currentUser().token {
            
            
            goToApp()
            
            
        }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
