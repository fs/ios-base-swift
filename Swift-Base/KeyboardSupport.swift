//
//  KeyboardSupport.swift
//  Swift-Base
//
//  Created by Kruperfone on 09.11.15.
//  Copyright © 2015 Flatstack. All rights reserved.
//

import UIKit

/*
    You must did not forget to call keyboardSupportKeyboardWillHide: method in your `deinit`
*/

protocol KeyboardSupport {
    var keyboardSupportScrollView   : UIScrollView? {get}
    var keyboardSupportActiveField  : UIView? {get}
    
    func keyboardSupportRegisterForNotifications ()
    func keyboardSupportRemoveNotifications ()
    
    func keyboardSupportKeyboardWillShow (notif: NSNotification)
    func keyboardSupportKeyboardWillHide (notif: NSNotification)
}

extension KeyboardSupport {
    var keyboardSupportActiveField  : UIView? {
        return nil
    }
}

extension KeyboardSupport where Self: AnyObject {
    
    func keyboardSupportRegisterForNotifications () {
        let center = NSNotificationCenter.defaultCenter()
        
        center.addObserver(self, selector: "keyboardWillShow:", name:UIKeyboardWillShowNotification, object: nil)
        center.addObserver(self, selector: "keyboardWillHide:", name:UIKeyboardWillHideNotification, object: nil)
    }
    
    func keyboardSupportRemoveNotifications () {
        let center = NSNotificationCenter.defaultCenter()
        
        center.removeObserver(self, name: UIKeyboardWillShowNotification, object: nil)
        center.removeObserver(self, name: UIKeyboardWillHideNotification, object: nil)
    }
}

extension KeyboardSupport where Self: UIViewController {
    
    func keyboardSupportKeyboardWillShow (notif: NSNotification) {
        
        guard let scrollView = self.keyboardSupportScrollView else {return}
        
        guard let info = notif.userInfo else {return}
        guard let value = info[UIKeyboardFrameEndUserInfoKey] as? NSValue else {return}
        
        let keyboardFrame = value.CGRectValue()
        let contentInsets = UIEdgeInsetsMake(0.0, 0.0, keyboardFrame.height, 0.0)
        
        scrollView.contentInset             = contentInsets
        scrollView.scrollIndicatorInsets    = contentInsets
        
        // If active text field is hidden by keyboard, scroll it so it's visible
        // Your app might not need or want this behavior.
        guard let activeField = self.keyboardSupportActiveField else {return}
        
        var viewRect = self.view.frame
        viewRect.size.height -= keyboardFrame.height
        
        if !CGRectContainsPoint(viewRect, activeField.frame.origin)  {
            scrollView.scrollRectToVisible(activeField.frame, animated: true)
        }
    }
    
    func keyboardSupportKeyboardWillHide (notif: NSNotification) {
        
        guard let scrollView = self.keyboardSupportScrollView else {return}
        
        let contentInsets = UIEdgeInsetsZero
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
    }
}

extension KeyboardSupport where Self: UITableViewController {
    var keyboardSupportScrollView: UIScrollView? {
        return self.tableView
    }
}

extension KeyboardSupport where Self: UICollectionViewController {
    var keyboardSupportScrollView: UIScrollView? {
        return self.collectionView
    }
}
