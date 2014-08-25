//
//  ViewController.swift
//  Class Roster Part 2
//
//  Created by Matthew Brightbill on 8/17/14.
//  Copyright (c) 2014 Matthew Brightbill. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var classRoster = [[Person](), [Person]()] as Array
    
    let namesPath = NSBundle.mainBundle().pathForResource("names", ofType: "plist")

    var sectionArr = ["Students", "Teachers"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var showsVerticalScrollIndicator: Bool = true
        
        self.tableView.dataSource = self
        
        let nameArr = NSArray(contentsOfFile: self.namesPath)
        
        self.makeList(nameArr)
    }
    
    func makeList(rosterArr: NSArray) {
        for name in rosterArr {
            var testPerson = Person(fName: name["firstName"] as String, lName: name["lastName"] as String, idNumber: name["id"] as String, role: name["role"] as String)
            
            if testPerson.role == "student" {
                classRoster[0].append(testPerson)
            }
            if testPerson.role == "teacher" {
                classRoster[1].append(testPerson)
            }
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView!) -> Int {
        return self.classRoster.count
    }
    
    func tableView(tableView: UITableView!, titleForHeaderInSection section: Int) -> String {
        if (section == 0) {
            return "Students"
        } else {
            return "Teachers"
        }
    }
    
    func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int {
        return self.classRoster[section].count
    }
    
    func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell
        
        var person = self.classRoster[indexPath.section][indexPath.row].fullName()
        cell.textLabel.text = person
        return cell
    }
    
    
    
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        if segue.identifier == "ShowPerson" {
            let indexPath = self.tableView.indexPathForSelectedRow()
            var detailVC = segue.destinationViewController as DetailViewController
            detailVC.selectedPerson = classRoster[indexPath.section][indexPath.row]
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

