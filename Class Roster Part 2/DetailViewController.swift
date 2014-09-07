//
//  DetailViewController.swift
//  Class Roster Part 2
//
//  Created by Matthew Brightbill on 8/17/14.
//  Copyright (c) 2014 Matthew Brightbill. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var selectedPerson = Person(fName: "John", lName: "Doe", idNumber: "Anything", role: "student")
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var gitHubUserNameTextField: UITextField!
    @IBOutlet weak var gitHubProfilePicture: UIImageView!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.firstNameTextField.delegate = self
        self.lastNameTextField.delegate = self
        self.gitHubUserNameTextField.delegate = self
        var placeholderImage = UIImage(named: "placeholder")
        
        if self.selectedPerson.image != nil {
            self.imageView.image = self.selectedPerson.image
        } else {
            self.imageView.image = placeholderImage
        }
        
        if self.selectedPerson.profileImage != nil {
            self.gitHubProfilePicture.image = self.selectedPerson.profileImage
            
        } else {
            self.gitHubProfilePicture.image = placeholderImage
        }
        
        
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = imageView.frame.width / 2
        imageView.layer.borderWidth = 0.5
        
        gitHubProfilePicture.layer.masksToBounds = true
        gitHubProfilePicture.layer.cornerRadius = gitHubProfilePicture.frame.width / 2
        gitHubProfilePicture.layer.borderWidth = 0.5
        
        
        
        // Do any additional setup after loading the view.
    }
    
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.label.text = self.selectedPerson.fullName()
        self.firstNameTextField.text = self.selectedPerson.firstName
        self.lastNameTextField.text = self.selectedPerson.lastName
        if let gitHubUserName = self.selectedPerson.gitHubUserName {
           self.gitHubUserNameTextField.text = gitHubUserName
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: UITextFieldDelegate
    
    func textFieldDidEndEditing(textField: UITextField!) {
        self.selectedPerson.firstName = self.firstNameTextField.text
        self.selectedPerson.lastName = self.lastNameTextField.text
        self.selectedPerson.gitHubUserName = self.gitHubUserNameTextField.text
    }
    
    func textFieldShouldReturn(textField: UITextField!) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @IBAction func photoButtonPressed(sender: AnyObject) {
    
        var imagePickerController = UIImagePickerController()
        
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true
        
        imagePickerController.sourceType = UIImagePickerControllerSourceType.SavedPhotosAlbum
        
        
        self.presentViewController(imagePickerController, animated: true, completion: nil)
        
        println("Did press button")
    }

    
    //MARK: UIImagePickerControllerDelegate
    
    func imagePickerController(picker: UIImagePickerController!, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]!) {
        picker.dismissViewControllerAnimated(true, completion: nil)
        println("user picked an image")
        var editedImage = info[UIImagePickerControllerOriginalImage] as UIImage
        self.imageView?.image = editedImage
        self.selectedPerson.image = editedImage
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController!) {
        picker.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func gitHubButton(sender: AnyObject) {
        var userNamePrompt = UIAlertController(title: "GitHub Username", message: "Enter your GitHub Username", preferredStyle: UIAlertControllerStyle.Alert)
        userNamePrompt.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: nil))
        userNamePrompt.addAction(UIAlertAction(title: "Enter", style: UIAlertActionStyle.Default) { (UIAlertAction) -> Void in
            var promptTextField = userNamePrompt.textFields.first as UITextField
            self.selectedPerson.gitHubUserName = promptTextField.text
            promptTextField.text = self.gitHubUserNameTextField.text
            self.retrieveGitHubImage(self.selectedPerson.gitHubUserName!)
                
        })
        userNamePrompt.addTextFieldWithConfigurationHandler({(textField: UITextField!) in
                textField.placeholder = "Username Here"
        })
        presentViewController(userNamePrompt, animated: true, completion: nil)
    }
    
    func retrieveGitHubImage(retrievedUserName : String) {
        
        let profileURL = NSURL(string: "https://api.github.com/users/\(retrievedUserName)")
        var profilePhotoURL = NSURL()
        let session = NSURLSession.sharedSession()
        
        var retrievalTask = session.dataTaskWithURL(profileURL, completionHandler: { (data, response, error) -> Void in
            
            if error != nil {
                println(error.localizedDescription)
            }
            
            var err = NSError?()
            
            var jsonResult = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: &err) as NSDictionary
            let avatarURL = jsonResult["avatar_url"] as? String
            profilePhotoURL = NSURL(string: avatarURL)
            
            var profilePhotoData = NSData(contentsOfURL: profilePhotoURL)
            
            var profilePhoto = UIImage(data: profilePhotoData)
            
            NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                println("main queue")
                self.gitHubProfilePicture.image = profilePhoto as UIImage
                self.selectedPerson.profileImage = profilePhoto as UIImage
            })
            
        })
    
        retrievalTask.resume()
    }
}