//
//  BEEMLoginViewController.swift
//  Beem
//
//  Created by Abhishek Shukla on 23/01/17.
//  Copyright © 2017 mobulous. All rights reserved.
//

import UIKit

class BEEMLoginViewController: UIViewController {
    
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordView: UIView!
    @IBOutlet weak var email_PhoneTextField: UITextField!
    @IBOutlet weak var email_PhoneView: UIView!
    @IBOutlet var mainContentView: UIView!
    @IBOutlet weak var loginButtonView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeUIView()
    }
    
    func initializeUIView() {
        
        self.navigationController?.navigationBar.isHidden = true
        
        self.passwordView.layer.cornerRadius = 20
        self.passwordView.layer.borderColor = UIColor.lightGray.cgColor
        self.passwordView.layer.borderWidth = 1.0
        
        self.email_PhoneView.layer.cornerRadius = 20
        self.email_PhoneView.layer.borderColor = UIColor.lightGray.cgColor
        self.email_PhoneView.layer.borderWidth = 1.0
        
        
        
        let image: UIImage = UIImage(named: "bg.png")!
        
        
        self.mainContentView.backgroundColor = UIColor(patternImage: image)
        self.mainContentView.contentMode = .scaleAspectFill
        
        let button = UIButton().getBEEMButtonUI("Login")
        let selector = #selector(buttonClicked)
        button.addTarget(target, action: selector, for: UIControlEvents.touchUpInside)
        self.loginButtonView .addSubview(button)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func buttonClicked(_ sender: Any) {
        print("login button clicked")
    }
    
}
