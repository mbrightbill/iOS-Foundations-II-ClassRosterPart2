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
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.firstNameTextField.delegate = self
        self.lastNameTextField.delegate = self
        var placeholderImage = UIImage(named: "placeholder")
        
        if self.selectedPerson.image != nil {
            self.imageView.image = self.selectedPerson.image
        } else {
            self.imageView.image = placeholderImage
        }
        
        
        
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 100.0
        imageView.layer.borderWidth = 1.0
        
        
        // Do any additional setup after loading the view.
    }
    
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.label.text = self.selectedPerson.fullName()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: UITextFieldDelegate
    
    func textFieldShouldReturn(textField: UITextField!) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(textField: UITextField!) {
        println(textField.text)
    }
    
    
    @IBAction func photoButtonPressed(sender: AnyObject) {
    
        var imagePickerController = UIImagePickerController()
        
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true
        
        imagePickerController.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        
        
        self.presentViewController(imagePickerController, animated: true, completion: nil)
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
    

}
