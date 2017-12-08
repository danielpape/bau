//
//  ClassesTableViewController.swift
//  bau
//
//  Created by Daniel Pape on 06/12/2017.
//  Copyright © 2017 Razeware LLC. All rights reserved.
//

import UIKit

class ClassesTableViewController: UITableViewController {
    
    var teachersArray = ["Gropius","Kandinsky","Breuer"]
    var completedLevels = [""]
    var unlockedTeachers = ["Gropius"]
    var defaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        var emptyLevelsArray = [""]
        if(defaults.object(forKey: "completedLevels")==nil){
            defaults.set(emptyLevelsArray, forKey: "completedLevels")
        }else{
            completedLevels = defaults.object(forKey: "completedLevels") as! Array<String>
        }
        print(completedLevels)
        if defaults.object(forKey: "coins") == nil{
            defaults.set(0, forKey: "coins")
        }
        if defaults.object(forKey: "unlockedTeachers") == nil{
            defaults.set(unlockedTeachers, forKey: "unlockedTeachers")
        }
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewDidLoad()
        tableView.reloadData()
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
        return teachersArray.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        var completedInSet = 0
        // Configure the cell...
        var completedLevels = defaults.object(forKey: "completedLevels") as! Array<String>
        for level in completedLevels{
            if level.contains("_\(indexPath.row+1)_"){
                completedInSet = completedInSet+1
            }
        }
        
        if(!unlockedTeachers.contains(teachersArray[indexPath.row])){
            cell.textLabel?.textColor = UIColor.lightGray
            cell.detailTextLabel?.text = "100 Coins"
        }else{
            cell.detailTextLabel?.text = "\(completedInSet)/10"
        }
        
        
        cell.textLabel?.text = teachersArray[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.performSegue(withIdentifier: "segue2", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)   {
        
        if (segue.identifier == "segue2") {
            
            //prepare for segue to the details view controller
            
            let levelsVC = segue.destination as!  LevelsViewController
            
            let indexPath = self.tableView.indexPathForSelectedRow?.row
            levelsVC.teacher = indexPath!+1
            
        }
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
