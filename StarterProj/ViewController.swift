//
//  ViewController.swift
//  StarterProj
//
//  Created by Gurdeep on 15/12/16.
//  Copyright © 2016 Gurdeep. All rights reserved.
//

import UIKit
import SwiftyJSON

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        WebServices.login(parameters: ["username":"john"], success: { (user : UserModel) -> Void in
        
            print("************")
            print(user.username)
            print("************")
            
        }, failure: { (Error) -> Void in
        
            
        })
    
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
