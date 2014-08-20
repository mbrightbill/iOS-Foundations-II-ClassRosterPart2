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
    
    var classRoster = [[Person]]()
    var studentArr = [Person]()
    var teacherArr = [Person]()
    var sectionArr = ["Students", "Teachers"]
    
    var nate = Person(fName: "Nate", lName: "Birkholz")
    var matthew = Person(fName: "Matthew", lName: "Brightbill")
    var jeff = Person(fName: "Jeff", lName: "Chavez")
    var christie = Person(fName: "Christie", lName: "Ferderer")
    var david = Person(fName: "David", lName: "Fry")
    var adrian = Person(fName: "Adrian", lName: "Petrica Gherle")
    var jake = Person(fName: "Jake", lName: "Hawken")
    var shams = Person(fName: "Shams", lName: "Kazi")
    var cameron = Person(fName: "Cameron", lName: "Klein")
    var kori = Person(fName: "Kori", lName: "Kolodziejczak")
    var parker = Person(fName: "Parker", lName: "Lewis")
    var nathan = Person(fName: "Nathan", lName: "Ma")
    var casey = Person(fName: "Casey", lName: "MacPhee")
    var brendan = Person(fName: "Brendan", lName: "McAleer")
    var brian = Person(fName: "Brian", lName: "Mendez")
    var mark = Person(fName: "Mark", lName: "Morris")
    var rowan = Person(fName: "Rowan", lName: "North")
    var kevin = Person(fName: "Kevin", lName: "Pham")
    var will = Person(fName: "Will", lName: "Richman")
    var heather = Person(fName: "Heather", lName: "Thueringer")
    var tuan = Person(fName: "Tuan", lName: "Vu")
    var zack = Person(fName: "Zack", lName: "Walkingstick")
    var sara = Person(fName: "Sara", lName: "Wong")
    var hongyao = Person(fName: "Hongyao", lName: "Zhang")
    var john = Person(fName: "John", lName: "Clem")
    var brad = Person(fName: "Brad", lName: "Johnson")
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var showsVerticalScrollIndicator: Bool = true
        
        self.tableView.dataSource = self
        
        studentArr = [nate, matthew, jeff, christie, david, adrian, jake, shams, cameron, kori, parker, nathan, casey, brendan,
            brian, mark, rowan, kevin, will, heather, tuan, zack, sara, hongyao]
        teacherArr = [john, brad]
        
        classRoster = [studentArr, teacherArr]
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func numberOfSectionsInTableView(tableView: UITableView!) -> Int {
        return self.classRoster.count
    }
    
    func tableView(tableView: UITableView!, titleForHeaderInSection section: Int) -> String! {
        return self.sectionArr[section]
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
        let indexPath = self.tableView.indexPathForSelectedRow()
        var detailVC = segue.destinationViewController as DetailViewController
        detailVC.selectedPerson = classRoster[indexPath.section][indexPath.row]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

