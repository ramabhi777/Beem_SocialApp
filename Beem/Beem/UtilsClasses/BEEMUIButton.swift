//
//  BEEMUIButton.swift
//  Beem
//
//  Created by Abhishek Shukla on 24/01/17.
//  Copyright © 2017 mobulous. All rights reserved.
//

import UIKit

extension UIButton {
    
    func getBEEMButtonUI(_ buttonTitle: String) -> UIButton {
        
        let buttonRect = CGRect(x: 0, y: 0, width: 160, height: 40)
        let loginButton = UIButton.init(frame: buttonRect)
        loginButton.setTitle(buttonTitle, for: .normal)
        loginButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 21)
        loginButton.setTitleColor(UIColor.white, for: .normal)
        loginButton.layer.backgroundColor = UIColor.beemButtonColor.cgColor
        loginButton.layer.cornerRadius = 20.0
        
        return loginButton
    }
}
