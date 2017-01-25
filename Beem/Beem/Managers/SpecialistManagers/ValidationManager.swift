//
//  ValidationManager.swift
//  Beem
//
//  Created by Abhishek Shukla on 25/01/17.
//  Copyright © 2017 mobulous. All rights reserved.
//

import Foundation

class ValidationManager {
    
    open static func validate(emailId id: String) -> (ErrorModel, Bool) {
        let errorModel: ErrorModel!
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        let result = emailTest.evaluate(with: id)
        if result {
            errorModel = ErrorModel(errorId: 0, errorMessage: "")
            return (errorModel, true)
        }
        errorModel = ErrorModel(errorId: 3001, errorMessage: "Invalid Email Id")
        return (errorModel, false)
    }
    
    open static func validate(phoneNumber number: String) -> (ErrorModel, Bool) {
        
        let errorModel: ErrorModel!
        let phoneNumberRegEx = "^[7-9][0-9]{9}$"
        let numberTest = NSPredicate(format:"SELF MATCHES %@", phoneNumberRegEx)
        let result = numberTest.evaluate(with: number)
        if result {
            errorModel = ErrorModel(errorId: 0, errorMessage: "")
            return (errorModel, true)
        }
        errorModel = ErrorModel(errorId: 3001, errorMessage: "Invalid Phone Number")
        return (errorModel, false)
    }
    
}
