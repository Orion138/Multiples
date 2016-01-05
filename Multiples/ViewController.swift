//
//  ViewController.swift
//  Multiples
//
//  Created by Nathan Boosinger on 12/10/15.
//  Copyright © 2015 Nathan Boosinger. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var multiplesLogo: UIImageView!
    @IBOutlet weak var multiplesTxtField: UITextField!
    @IBOutlet weak var playButton: UIButton!
    
    @IBOutlet weak var addLbl: UILabel!
    @IBOutlet weak var addButton: UIButton!
    
    var enteredMultiple = 0
    var number = 0
    var currentNumber = 0
    var maxCount = 5
    var count = 1
    var sum = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillShow:"), name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillHide:"), name: UIKeyboardWillHideNotification, object: nil)
        
        //Looks for single or multiple taps.
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
    }
    
    //Calls this function when the tap is recognized.
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    func keyboardWillShow(notification: NSNotification) {
        
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.CGRectValue() {
            self.view.frame.origin.y -= keyboardSize.height
        }
        
    }
    
    func keyboardWillHide(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.CGRectValue() {
            self.view.frame.origin.y += keyboardSize.height
        }
    }
    
    @IBAction func playButtonTapped(sender: UIButton) {
        
        if multiplesTxtField.text != nil && multiplesTxtField.text != "" {
            
            multiplesLogo.hidden = true
            multiplesTxtField.hidden = true
            playButton.hidden = true
            
            addLbl.hidden = false
            addButton.hidden = false
            
            dismissKeyboard()
        }
    }
    
    @IBAction func addButtonTapped(sender: UIButton) {
        if count > maxCount {
            resetGame()
        } else {
            calculateMultiple()
        }
    }

    func calculateMultiple() {
        enteredMultiple = Int(multiplesTxtField.text!)!
        sum = currentNumber + enteredMultiple
        addLbl.text = "\(currentNumber) + \(enteredMultiple) = \(sum)"
        currentNumber += enteredMultiple
        
        print(currentNumber)
        count++
    }
    
    func resetGame() {
        enteredMultiple = 0
        number = 0
        currentNumber = 0
        maxCount = 5
        count = 1
        sum = 0
        multiplesTxtField.text = ""
        addLbl.text = "Press Add to add!"
        
        multiplesLogo.hidden = false
        multiplesTxtField.hidden = false
        playButton.hidden = false
        
        addLbl.hidden = true
        addButton.hidden = true
    }
}

