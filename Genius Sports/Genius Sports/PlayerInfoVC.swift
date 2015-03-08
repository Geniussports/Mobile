//
//  PlayerInfoVC.swift
//  Genius Sports
//
//  Created by Richard Tyran on 3/7/15.
//  Copyright (c) 2015 Richard Tyran. All rights reserved.
//

import UIKit

class PlayerInfoVC: UIViewController,
    UIImagePickerControllerDelegate {

    @IBOutlet var teamName: UILabel!
    
    @IBOutlet var childName: UILabel!
    
    @IBOutlet var parentName1Label: UILabel!
    
    @IBOutlet var phone1Label: UILabel!
    
    @IBOutlet var parentName2Label: UILabel!
    
    @IBOutlet var phone2Label: UILabel!
    
    @IBOutlet var emergencyContactLabel: UILabel!
    
    @IBOutlet var emergencyPhoneLabel: UILabel!
    
    @IBOutlet var allergiesLabel: UILabel!
    
    
    @IBOutlet var playerImage: UIImageView!
    
    var imagePicker = UIImagePickerController()
    
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        
        var image = info[UIImagePickerControllerOriginalImage] as UIImage
        
//        self.seatImageView.image = image
        
        picker.dismissViewControllerAnimated(true, completion: nil)
        
    }

    func resizeImage(image: UIImage, withSize size: CGSize) -> UIImage {
        
        UIGraphicsBeginImageContext(size)
        image.drawInRect(CGRectMake(0, 0, size.width, size.height))
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
        
        
        //        UIGraphicsBeginImageContextWithOptions(newSize, NO, 0.0);
        //        [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
        //        UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
        //        UIGraphicsEndImageContext();
        //        return newImage;
        
        
    }
    

    
    override func viewDidLoad() {
        super.viewDidLoad()

//        imagePicker.delegate = self
//        imagePicker.sourceType = .Camera

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
