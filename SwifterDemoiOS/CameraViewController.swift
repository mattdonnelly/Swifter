//
//  ViewController.swift
//  Taking Photos with the Camera
//
//  Created by Vandad Nahavandipoor on 7/10/14.
//  Copyright (c) 2014 Pixolity Ltd. All rights reserved.
//
//  These example codes are written for O'Reilly's iOS 8 Swift Programming Cookbook
//  If you use these solutions in your apps, you can give attribution to
//  Vandad Nahavandipoor for his work. Feel free to visit my blog
//  at http://vandadnp.wordpress.com for daily tips and tricks in Swift
//  and Objective-C and various other programming languages.
//
//  You can purchase "iOS 8 Swift Programming Cookbook" from
//  the following URL:
//  http://shop.oreilly.com/product/0636920034254.do
//
//  If you have any questions, you can contact me directly
//  at vandad.np@gmail.com
//  Similarly, if you find an error in these sample codes, simply
//  report them to O'Reilly at the following URL:
//  http://www.oreilly.com/catalog/errata.csp?isbn=0636920034254

import UIKit
import MobileCoreServices
import PhotoboothiOS


class CameraViewController: UIViewController,
UINavigationControllerDelegate, UIImagePickerControllerDelegate /*, UITextViewDelegate */ {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var takePhotoButton: UIButton!
    @IBOutlet weak var statusTextField: UITextView!
    @IBOutlet weak var sendTweetButton: UIButton!
    
    /* We will use this variable to determine if the viewDidAppear:
    method of our view controller is already called or not. If not, we will
    display the camera view */
    var beenHereBefore = false
    var controller: UIImagePickerController?
    
    func isCameraAvailable() -> Bool{
        return UIImagePickerController.isSourceTypeAvailable(.Camera)
    }
    
    func cameraSupportsMedia(mediaType: String,
        sourceType: UIImagePickerControllerSourceType) -> Bool{
            
            let availableMediaTypes =
            UIImagePickerController.availableMediaTypesForSourceType(sourceType) as
            [String]?
            
            if let types = availableMediaTypes{
                for type in types{
                    if type == mediaType{
                        return true
                    }
                }
            }
            
            return false
    }
    
    func doesCameraSupportTakingPhotos() -> Bool{
        return cameraSupportsMedia(kUTTypeImage as String, sourceType: .Camera)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        if beenHereBefore{
            /* Only display the picker once as the viewDidAppear: method gets
            called whenever the view of our view controller gets displayed */
            return;
        } else {
            beenHereBefore = true
        }
        
        self.showPhotoModal();
        
    }
    
    func showPhotoModal() {
        
        controller = UIImagePickerController()
            
        if let theController = controller{
                
            if isCameraAvailable() && doesCameraSupportTakingPhotos(){
                theController.sourceType = .Camera
            } else {
                theController.sourceType = .PhotoLibrary
            }
            
            theController.mediaTypes = [kUTTypeImage as String]
            
            theController.allowsEditing = true
            theController.delegate = self
            
            presentViewController(theController, animated: true, completion: nil)
        }
            
    }
    
    func imagePickerController(picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [NSObject : AnyObject]){
            
            println("Picker returned successfully")
            
            let mediaType:AnyObject? = info[UIImagePickerControllerMediaType]
            
            if let type:AnyObject = mediaType{
                
                if type is String{
                    let stringType = type as String
                    
                    if stringType == kUTTypeMovie as String{
                        let urlOfVideo = info[UIImagePickerControllerMediaURL] as NSURL
                        //                        if let url = urlOfVideo {
                        //                            println("Video URL = \(url)")
                        //                        }
                    }
                        
                    else if stringType == kUTTypeImage as String{
                        /* Let's get the metadata. This is only for images. Not videos */
                        let metadata = info[UIImagePickerControllerMediaMetadata]
                            as? NSDictionary
                        if let theMetaData = metadata{
                            let image = info[UIImagePickerControllerOriginalImage]
                                as? UIImage
                            if let theImage = image{
                                println("Image Metadata = \(theMetaData)")
                                println("Image = \(theImage)")
                                
                                imageView.image = image
                                picker.dismissViewControllerAnimated(true, completion: nil)
                            }
                        }
                    }
                    
                }
            }
            
            picker.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        println("Picker was cancelled")
        picker.dismissViewControllerAnimated(true, completion: nil)
    }

    @IBAction func didTouchUpInsidePhotoButton(sender: AnyObject) {
        let failureHandler: ((NSError) -> Void) = {
            error in
            
            self.alertWithTitle("Error", message: error.localizedDescription)
        }
        
        println("didTouchUpInsidePhotoButton")
        
        self.showPhotoModal()
        
    }
    
    // hide keyboard for UITextView
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        view.endEditing(true)
        super.touchesBegan(touches, withEvent: event)
    }
    
    @IBAction func didTouchUpInsideTweetButton(sender: AnyObject) {
        let failureHandler: ((NSError) -> Void) = {
            error in
            
            self.alertWithTitle("Error", message: error.localizedDescription)
        }

        let uiImage = self.imageView.image
        println("Image = \(uiImage)")

        let imageData = UIImageJPEGRepresentation(uiImage, 0.5)

        let status = self.statusTextField.text
        
        if status != nil && imageData != nil {

            let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
            appDelegate.swifter.postStatusUpdate(self.statusTextField.text, media:imageData, inReplyToStatusID: nil, lat: nil, long: nil, placeID: nil, displayCoordinates: nil, trimUser: nil, success: {
                (status: Dictionary<String, JSONValue>?) in
                
                dispatch_async(dispatch_get_main_queue(), {

                    let controller = TweetViewController()
                    self.presentViewController(controller, animated: true, completion: nil)

                });

                }, failure: failureHandler)

        }

        println("didTouchUpInsideTweetButton")

    }
    
    @IBAction func showTweets(){
        
        dispatch_async(dispatch_get_main_queue(), {
            
            let controller = TweetViewController()

            // trying to do the following to maintain the navigation bar:
            // 1. create a new container that is a UIViewController
            // 2. inside that have a view
            // 3. set that view to be my TweetViewController
            let container = self.storyboard!.instantiateViewControllerWithIdentifier("ContainerController") as ContainerController
            
            self.presentViewController(controller, animated: true, completion: nil)

        });

        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        println("Found \(segue.identifier) to \(segue.destinationViewController)")
        if segue.identifier == "ViewTweets"
        {
            if let destinationVC = segue.destinationViewController as? UIViewController {
                println("Targeted")
                
            }
        }

    }
    
    func alertWithTitle(title: String, message: String) {
        var alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
}
