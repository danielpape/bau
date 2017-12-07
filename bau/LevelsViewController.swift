//
//  LevelsViewController.swift
//  bau
//
//  Created by Daniel Pape on 03/12/2017.
//  Copyright © 2017 Razeware LLC. All rights reserved.
//

import UIKit

class LevelsViewController: UITableViewController {
    
    var levels:Array = ["1","2","3","4","5","6","7","8","9","10"]
    var defaults = UserDefaults.standard
    var teacher = 0
    var completedLevels:Array<String> = []

    override func viewDidLoad() {
        super.viewDidLoad()
        completedLevels = defaults.object(forKey: "completedLevels") as! Array<String>
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
        print("teacher is \(teacher)")
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return levels.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:LevelTableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! LevelTableViewCell
        
        var fileName = "Level_\(teacher)_\(levels[indexPath.row ])"
        if(completedLevels.contains(fileName)){
            cell.levelNameLabel?.textColor =  UIColor.lightGray
        }
        cell.levelNameLabel?.text = "Level "+levels[indexPath.row ]
        return cell
    }
    
   override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        self.performSegue(withIdentifier: "segue", sender: self)
    }
 

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?)   {
        
        if (segue.identifier == "segue") {
            
            //prepare for segue to the details view controller
            
            let detailsVC = segue.destination as!  GameViewController
            
            let indexPath = self.tableView.indexPathForSelectedRow?.row
            detailsVC.teacherName = teacher
            detailsVC.LevelNumber = indexPath!+1
            
        }
    }
 

}
