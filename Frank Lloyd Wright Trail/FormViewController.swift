//
//  SampleRequestViewController.swift
//  BradelyCorpMaterials
//
//  Created by Kyle Zawacki on 1/24/16.
//  Copyright © 2016 University Of Wisconsin Parkside. All rights reserved.
//
import UIKit
class FormViewController: UITableViewController, UITextFieldDelegate {
    
    // MARK: Properties
    var amountMoved: CGFloat = 0
    var currentTextField: UITextField?
    var keyboardHeight: CGFloat = 0
    
    // MARK: Initialization
    override func viewDidLoad() {
        subscribeToKeyBoardNotifications()
    }
    
    override func viewWillDisappear(animated: Bool) {
        if let currentTextField = currentTextField {
            currentTextField.resignFirstResponder()
        }
    }
    
    private func subscribeToKeyBoardNotifications() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "textFieldPressed:", name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "textFieldHiding:", name: UIKeyboardWillHideNotification, object: nil)
    }
    
    
    func textFieldDidBeginEditing(textField: UITextField) {
        currentTextField = textField
    }
    
    // MARK: Textfield Notifications
    func textFieldPressed(sender: NSNotification) {
        let userInfo = sender.userInfo!
        let keyboardRect = userInfo[UIKeyboardFrameBeginUserInfoKey]!.CGRectValue
        keyboardHeight = keyboardRect.height
        
        if amountMoved == 0 {
            amountMoved = keyboardHeight
            
            adjustForTextField(withKeyboardHeight: keyboardHeight)
        }
    }
    
    func textFieldHiding(sender: NSNotification) {
        unadjustForTextField()
    }
    
    func adjustForTextField(withKeyboardHeight keyboardHeight: CGFloat) {
        UIView.animateWithDuration(0.3) { 
            self.view.frame = CGRect(x: self.view.frame.origin.x, y: self.view.frame.origin.y,
                                     width: self.view.frame.width,
                                     height: self.view.frame.height - keyboardHeight)
        }
    }

    
    func unadjustForTextField() {
        UIView.animateWithDuration(0.3) {
            self.view.frame = CGRect(x: self.view.frame.origin.x, y: self.view.frame.origin.y,
                                     width: self.view.frame.width,
                                     height: self.view.frame.height + self.amountMoved)
        }
        
        amountMoved = 0
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}
