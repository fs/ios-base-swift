//
//  KeyboardScrollSupport.swift
//  Swift-Base
//
//  Created by Kruperfone on 09.11.15.
//  Copyright © 2015 Flatstack. All rights reserved.
//

import UIKit

/*
    You must did not forget to call KeyboardScrollSupportKeyboardWillHide: method in your `deinit`
*/

protocol KeyboardScrollSupport {
    var keyboardScrollSupportScrollView   : UIScrollView?   {get}
    var keyboardScrollSupportActiveField  : UIView?         {get}
    
    func keyboardScrollSupportRegisterForNotifications  ()
    func keyboardScrollSupportRemoveNotifications       ()
    
    func keyboardScrollSupportKeyboardWillShow (notif: NSNotification)
    func keyboardScrollSupportKeyboardWillHide (notif: NSNotification)
}

extension KeyboardScrollSupport {
    var keyboardScrollSupportActiveField  : UIView? {
        return nil
    }
}

extension KeyboardScrollSupport where Self: AnyObject {
    
    func keyboardScrollSupportRegisterForNotifications () {
        
        let center = NSNotificationCenter.defaultCenter()
        
        center.addObserver(self, selector: "keyboardScrollSupportKeyboardWillShow:", name:UIKeyboardWillShowNotification, object: nil)
        center.addObserver(self, selector: "keyboardScrollSupportKeyboardWillHide:", name:UIKeyboardWillHideNotification, object: nil)
    }
    
    func keyboardScrollSupportRemoveNotifications () {
        
        let center = NSNotificationCenter.defaultCenter()
        
        center.removeObserver(self, name: UIKeyboardWillShowNotification, object: nil)
        center.removeObserver(self, name: UIKeyboardWillHideNotification, object: nil)
    }
}

extension KeyboardScrollSupport where Self: UIViewController {
    
    func keyboardScrollSupportKeyboardWillShow (notif: NSNotification) {
        
        guard let scrollView = self.keyboardScrollSupportScrollView else {return}
        
        guard let info = notif.userInfo else {return}
        guard let value = info[UIKeyboardFrameEndUserInfoKey] as? NSValue else {return}
        
        let keyboardFrame = value.CGRectValue()
        let contentInsets = UIEdgeInsetsMake(0.0, 0.0, keyboardFrame.height, 0.0)
        
        scrollView.contentInset             = contentInsets
        scrollView.scrollIndicatorInsets    = contentInsets
        
        // If active text field is hidden by keyboard, scroll it so it's visible
        // Your app might not need or want this behavior.
        guard let activeField = self.keyboardScrollSupportActiveField else {return}
        
        var viewRect = self.view.frame
        viewRect.size.height -= keyboardFrame.height
        
        if !CGRectContainsPoint(viewRect, activeField.frame.origin)  {
            scrollView.scrollRectToVisible(activeField.frame, animated: true)
        }
    }
    
    func keyboardScrollSupportKeyboardWillHide (notif: NSNotification) {
        
        guard let scrollView = self.keyboardScrollSupportScrollView else {return}
        
        let contentInsets = UIEdgeInsetsZero
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
    }
}

extension KeyboardScrollSupport where Self: UITableViewController {
    var keyboardScrollSupportScrollView: UIScrollView? {
        return self.tableView
    }
}

extension KeyboardScrollSupport where Self: UICollectionViewController {
    var keyboardScrollSupportScrollView: UIScrollView? {
        return self.collectionView
    }
}
