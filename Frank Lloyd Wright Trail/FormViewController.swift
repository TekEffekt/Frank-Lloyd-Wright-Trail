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
    
    override func viewWillDisappear(_ animated: Bool) {
        if let currentTextField = currentTextField {
            currentTextField.resignFirstResponder()
        }
    }
    
    fileprivate func subscribeToKeyBoardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(FormViewController.textFieldPressed(_:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(FormViewController.textFieldHiding(_:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        currentTextField = textField
    }
    
    // MARK: Textfield Notifications
    func textFieldPressed(_ sender: Notification) {
        let userInfo = sender.userInfo!
        let keyboardRect = (userInfo[UIKeyboardFrameBeginUserInfoKey]! as AnyObject).cgRectValue
        keyboardHeight = (keyboardRect?.height)!
        
        if amountMoved == 0 {
            amountMoved = keyboardHeight
            
            adjustForTextField(withKeyboardHeight: keyboardHeight)
        }
    }
    
    func textFieldHiding(_ sender: Notification) {
        unadjustForTextField()
    }
    
    func adjustForTextField(withKeyboardHeight keyboardHeight: CGFloat) {
        UIView.animate(withDuration: 0.3, animations: { 
            self.view.frame = CGRect(x: self.view.frame.origin.x, y: self.view.frame.origin.y,
                                     width: self.view.frame.width,
                                     height: self.view.frame.height - keyboardHeight)
        }) 
    }

    
    func unadjustForTextField() {
        UIView.animate(withDuration: 0.3, animations: {
            self.view.frame = CGRect(x: self.view.frame.origin.x, y: self.view.frame.origin.y,
                                     width: self.view.frame.width,
                                     height: self.view.frame.height + self.amountMoved)
        }) 
        
        amountMoved = 0
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}
