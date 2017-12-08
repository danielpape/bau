//
//  WelcomeViewController.swift
//  bau
//
//  Created by Daniel Pape on 08/12/2017.
//  Copyright © 2017 Razeware LLC. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController {
    
    var defaults = UserDefaults.standard
    var coins = 0
    
    @IBOutlet weak var barItem: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        defaults.removeObject(forKey: "completedLevels")
//        defaults.removeObject(forKey: "coins")
        if(defaults.object(forKey: "coins")==nil){
            coins = 0
        }else{
            coins = defaults.object(forKey: "coins") as! Int
        }
        barItem.title = "Coins: \(coins)"

        
    }

    override func viewWillAppear(_ animated: Bool) {
        if(defaults.object(forKey: "coins")==nil){
            coins = 0
        }else{
            coins = defaults.object(forKey: "coins") as! Int
        }
        barItem.title = "Coins: \(coins)"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
