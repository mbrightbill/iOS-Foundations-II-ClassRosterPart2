//
//  ViewController.swift
//  Class Roster Part 2
//
//  Created by Matthew Brightbill on 8/17/14.
//  Copyright (c) 2014 Matthew Brightbill. All rights reserved.
//

import UIKit

//Step 3. conform to protocol.
class ViewController: UIViewController, UITableViewDataSource {
    
    // Step 2. After adding Table View to View Controller in storyboard(with nav controller), create outlet.
    @IBOutlet weak var tableView: UITableView!
    
    // Step 5
    var people = [Person]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Step 3. table view is datasource.
        self.tableView.dataSource = self
        
        self.people = self.createPeople()
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    // Step 4. define table view functionality with 2 necessary parts.
    func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int {
        return self.people.count
    }
    
    func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell
        // Step 5. Create cell indentifier, empty people array, and set a person's property to occupy the cell.
        var person = self.people[indexPath.row]
        cell.textLabel.text = person.firstName
        return cell
    }
    
    // Step 6. define the method to create people. return type is person object(instance of the person class) in the array.
    
    func createPeople() -> [Person] {
        var people = [Person]()
        var matthew = Person(fName: "Matthew", lName: "Brightbill")
        var beastMode = Person(fName: "Marshawn", lName: "Lynch")
        var russell = Person(fName: "Russell", lName: "Wilson")
        
        //push those
        
        people.append(matthew)
        people.append(beastMode)
        people.append(russell)
        
        return people
        
        // after this, when we call the people array at the top, it will have these values.
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Step 9. Prepare this view controller to be displayed with whatever data we need to pass it.
        var detailVC = segue.destinationViewController as DetailViewController
        
        //grab the selected indexPath from our tableview and grab the selected person using the indexPath as the index in our people array
        var selectedPeep = self.people[self.tableView.indexPathForSelectedRow().row]
        
        //set the destinationVC's person property to reference the selectedPerson
        detailVC.selectedPerson = selectedPeep
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

