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
    @IBOutlet weak var showPasswordButton: UIButton!
    @IBOutlet weak var showHidePasswordImageView: UIImageView!
    
   

    override func viewDidLoad() {
        super.viewDidLoad()
        self.initializeUIView()
        self.hideKeyboardWhenTappedAround()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
        
        //Register Keyboard Observer
        registerKeyboardNotifications()
        
        //Resign
        resignAllResponder()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = false
        self.unregisterKeyboardNotifications()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func showPassword_ButtonClicked(_ sender: UIButton) {
        
        let hideShowPasswordImageViewOrigin = showHidePasswordImageView.frame.origin
        let xOrigin = hideShowPasswordImageViewOrigin.x
        let yOrigin = hideShowPasswordImageViewOrigin.y
        
        if sender.state.contains(.selected) {
            showHidePasswordImageView.image = #imageLiteral(resourceName: "hide_password")
            showPasswordButton.isSelected = false
            passwordTextField.isSecureTextEntry = true
            showHidePasswordImageView.frame = CGRect(x: xOrigin-1, y: yOrigin-2, width: 14, height: 12)
        }
        else {
            passwordTextField.isSecureTextEntry = false
            showHidePasswordImageView.image = #imageLiteral(resourceName: "show_password")
            showPasswordButton.isSelected = true
            showHidePasswordImageView.frame = CGRect(x: xOrigin+1, y: yOrigin+2, width: 12, height: 8)
        }
    }
    
    @IBAction func forgotPassword_ButtonClicked(_ sender: Any) {
        
    }
    
    @IBAction func createAccount_ButtonClicked(_ sender: Any) {
    }
    
    func buttonClicked(_ sender: Any) {
        
        self.email_PhoneView.layer.borderColor = UIColor.lightGray.cgColor
        self.passwordView.layer.borderColor = UIColor.lightGray.cgColor
        guard email_PhoneTextField.text != nil else {
            return
        }
        
        guard passwordTextField.text != nil else {
            return
        }
        self.loginToBEEM()
//        self.textFieldManipulation()
        
        
        
    }
}

// MARK:- Extension
extension BEEMLoginViewController {
    
    func initializeUIView() {
        
        showPasswordButton.isSelected = false
        
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
    
    func textFieldManipulation() {
        let value: (ErrorModel, Bool)?
        let isNumber = self.isNumber(withString: email_PhoneTextField.text!)
        if isNumber == true{
            value = ValidationManager.validate(phoneNumber: email_PhoneTextField.text!)
        }
        else {
            value = ValidationManager.validate(emailId: email_PhoneTextField.text!)
        }
        
        if !(value?.1)! {
            self.email_PhoneView.layer.borderColor = UIColor.red.cgColor
            self.email_PhoneTextField.text = ""
            self.email_PhoneTextField.placeholder = value?.0.errorMessage
            self.animateTextField(withViewFrame: email_PhoneView.frame, viewToAnimate: self.email_PhoneView)
            return
        }
        self.passwordTextField.becomeFirstResponder()
        
        let passwordLength = passwordTextField.text?.characters.count
        if passwordLength! < 6 {
            self.passwordView.layer.borderColor = UIColor.red.cgColor
            self.passwordTextField.text = ""
            self.passwordTextField.placeholder = "> 6 characters"
            self.animateTextField(withViewFrame: self.passwordView.frame, viewToAnimate: self.passwordView)
            return
        }
        
//        self.loginToBEEM()
        
    }
    func isNumber(withString number: String) -> Bool {
        let numberCharacters = NSCharacterSet.decimalDigits.inverted
        if !number.isEmpty && number.rangeOfCharacter(from: numberCharacters) == nil {
            return true
        } else {
            return false
        }
    }
    
    func animateTextField(withViewFrame viewFrame: CGRect, viewToAnimate animateView: UIView) {
        let viewSize = viewFrame.size
        let viewOrigin = viewFrame.origin
        UIView.animate(withDuration: 0.001, delay: 0.0, options: UIViewAnimationOptions.curveEaseOut, animations: {
            animateView.frame = CGRect(x: 12, y: viewOrigin.y, width: viewSize.width, height: viewSize.height)
        }, completion: { (result) in
            animateView.frame = CGRect(x: viewOrigin.x, y: viewOrigin.y, width: viewSize.width, height: viewSize.height)
        })
    }
    
    //MARK:- Keyboard Observer
    func registerKeyboardNotifications() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(BEEMLoginViewController.keyboardDidShow(notification:)), name: Notification.Name.UIKeyboardDidShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(BEEMLoginViewController.keyboardWillBeHidden(notification:)), name: Notification.Name.UIKeyboardWillHide, object: nil)
    }
    
    // MARK:- Keyboard Event
     func keyboardDidShow(notification: NSNotification) {
        
    }
    
    func keyboardWillBeHidden(notification: NSNotification) {
        
    }
    
    
    func resignAllResponder(){
        
        self.view.endEditing(true)
    }
    
    // TODO:- Login Details Send to BEEM
    func loginToBEEM() {
        let signUpVC = self.storyboard?.instantiateViewController(withIdentifier: "SignUpVC")
        self.navigationController?.pushViewController(signUpVC!, animated: true)
    }
}
