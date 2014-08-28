//
//  Person.swift
//  Class Roster Part 2
//
//  Created by Matthew Brightbill on 8/17/14.
//  Copyright (c) 2014 Matthew Brightbill. All rights reserved.
//

import Foundation
import UIKit

class Person : NSObject, NSCoding {
    var firstName: String
    var lastName: String
    var image: UIImage?
    var idNumber: String
    var role: String
    var gitHubUserName : String?
    
    required init(coder aDecoder: NSCoder) {
        self.firstName = aDecoder.decodeObjectForKey("firstName") as String
        self.image = aDecoder.decodeObjectForKey("image") as? UIImage
        self.lastName = aDecoder.decodeObjectForKey("lastName") as String
        self.idNumber = aDecoder.decodeObjectForKey("idNumber") as String
        self.role = aDecoder.decodeObjectForKey("role") as String
        super.init()
    }
    
    init(fName: String, lName: String, idNumber: String, role: String) {
        self.firstName = fName
        self.lastName = lName
        self.idNumber = idNumber
        self.role = role
    }
    
    func encodeWithCoder(aCoder: NSCoder!) {
        aCoder.encodeObject(self.firstName, forKey: "firstName")
        aCoder.encodeObject(self.lastName, forKey: "lastName")
        aCoder.encodeObject(self.image, forKey: "image")
        aCoder.encodeObject(self.idNumber, forKey: "idNumber")
        aCoder.encodeObject(self.role, forKey: "role")
    }
    
    func fullName() -> String {
        return "\(firstName) \(lastName)"
    }
}