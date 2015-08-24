//
//  PINsTableViewController.swift
//  PINKeeper
//
//  Created by Alexey Tsymlov on 8/13/15.
//  Copyright (c) 2015 Alexey Tsymlov. All rights reserved.
//

import UIKit

class PINsTableViewController: UITableViewController {
    
    private struct Storyboard {
        static let showNewPINDetailsSegueID = "Show New PIN Details"
        static let showDetailsOfPINSegueID = "Show Details of PIN"
    }
    
    private var pins = [[PIN]()]

    override func viewDidLoad() {
        super.viewDidLoad()
        self.pins[0] = PIN.MR_findAll() as! [PIN]
        println("Found \(pins[0].count) records in database")
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.setHidesBackButton(true, animated: false)
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return pins.count
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pins[section].count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(PINTableViewCell.reuseID, forIndexPath: indexPath) as! PINTableViewCell
        cell.pin = pins[indexPath.section][indexPath.row]
        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == nil {
            println("Error! Unknown nil segue identifier.")
            return
        }
        switch segue.identifier!{
        case Storyboard.showNewPINDetailsSegueID:
            let newPIN = PIN.MR_createEntity()
            pins[0].append(newPIN)
            (segue.destinationViewController as! PINDetailTableViewController).pin = newPIN
        case Storyboard.showDetailsOfPINSegueID:
            let cell = sender as! UITableViewCell
            let indexPath = tableView.indexPathForCell(cell)!
            let pin = pins[indexPath.section][indexPath.row]
            (segue.destinationViewController as! PINDetailTableViewController).pin = pin
        default:
            break
            
        }
    }

    
    // MARK: - Actions

}
