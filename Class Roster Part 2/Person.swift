//
//  Person.swift
//  Class Roster Part 2
//
//  Created by Matthew Brightbill on 8/17/14.
//  Copyright (c) 2014 Matthew Brightbill. All rights reserved.
//

import Foundation
import UIKit

// Step 1. Create person class with defined properties and init.
class Person {
    var firstName: String
    var lastName: String
    var image: UIImage?
    var idNumber: String
    var role: String
    
    init(fName: String, lName: String, idNumber: String, role: String) {
        self.firstName = fName
        self.lastName = lName
        self.idNumber = idNumber
        self.role = role
    }
    
    func fullName() -> String {
        return "\(firstName) \(lastName)"
    }
}