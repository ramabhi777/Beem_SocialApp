//
//  BEEMSignUpViewController.swift
//  Beem
//
//  Created by Abhishek Shukla on 25/01/17.
//  Copyright © 2017 mobulous. All rights reserved.
//

import UIKit

class BEEMSignUpViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeUI()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

// MARK:- Extension
extension BEEMSignUpViewController {
    
    func initializeUI() {
        self.navigationController?.navigationBar.tintColor = UIColor.BEEMApplicationColor
//        self.navigationController?.title = "BEEM"
        self.navigationItem.title = "BEEM"
        
        
    }
}
