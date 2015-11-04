//
//  UserInfoViewController.swift
//  Pods
//
//  Created by Sebastian Drew on 11/3/15.
//
//

import UIKit
import Parse

class UserInfoViewController: UIViewController {

    @IBOutlet weak var firstNameLabel: UILabel!
    @IBOutlet weak var lastNameLabel: UILabel!
    @IBOutlet weak var bloodTypeLabel: UILabel!
    
  
    var user = PFUser.currentUser()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        var query = PFQuery(className:"Simple")

        query.whereKey("user", equalTo: (user?.objectId)!)
        
        query.findObjectsInBackgroundWithBlock { (objects, error) -> Void in
            
            if let objects = objects {
                
                
                for object in objects {
                    
                    var firstname = object["firstname"] as! String
                    var lastname = object["lastname"] as! String
                    var bloodtype = object["bloodtype"] as! String
                    
                    // print(firstname)
                    
                    self.firstNameLabel.text = firstname
                    self.lastNameLabel.text = lastname
                    self.bloodTypeLabel.text = bloodtype
                    
                }


            } else {
                
                //..
                
            }
        }



        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func editAccountButtonDidTouch(sender: AnyObject) {
        
        performSegueWithIdentifier("editAccountSegue", sender: self)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
