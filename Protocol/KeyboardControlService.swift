//
//  Keyboard.swift
//  BBS
//
//  Created by 이광용 on 2018. 7. 3..
//  Copyright © 2018년 이광용. All rights reserved.
//

import UIKit

typealias KeyboardInfo = (CGRect, TimeInterval)->()
protocol KeyboardControlService: class {
    func setKeyboardControl(willShow: KeyboardInfo?, willHide: KeyboardInfo?)
    func removeKeyboardControl()
}

extension KeyboardControlService where Self: UIViewController {
    func setKeyboardControl(willShow: KeyboardInfo? = nil, willHide: KeyboardInfo? = nil) {
        NotificationCenter.default.addObserver(forName: .UIKeyboardWillShow, object: nil, queue: nil) { (notification) in
            self.keyboardWillShow(notification, willShow: willShow)
        }
        NotificationCenter.default.addObserver(forName: .UIKeyboardWillHide, object: nil, queue: nil) { (notification) in
            self.kyeboardWillHide(notification, willHide: willHide)
        }
    }
    
    func removeKeyboardControl() {
        NotificationCenter.default.removeObserver(self)
    }
    
    func keyboardWillShow(_ notification: Notification, willShow: KeyboardInfo? = nil)
    {
        guard let keyboardSize = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {return}
        guard let animationDuration = notification.userInfo?[UIKeyboardAnimationDurationUserInfoKey] as? TimeInterval else {return}
        guard let willShow = willShow else {return}
        willShow(keyboardSize, animationDuration)
    }
    
    func kyeboardWillHide(_ notification: Notification, willHide: KeyboardInfo? = nil)
    {
        guard let keyboardSize = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {return}
        guard let animationDuration = notification.userInfo?[UIKeyboardAnimationDurationUserInfoKey] as? TimeInterval else {return}
        guard let willHide = willHide else {return}
        willHide(keyboardSize, animationDuration)
    }
    
    
}
/* Example
 class ViewController: UIViewController, KeyboardControlService {
 override func viewDidLoad() {
 super.viewDidLoad()
 self.setKyeboardControl(willShow: setKeyboardWillShow(), willHide: setKyeboarWillHide())
 }
 
 func setKeyboardWillShow() -> KeyboardInfo{
 return { rect, duration in
 print("keyboard will show - frame : \(rect), duration : \(duration)")
 }
 }
 
 func setKyeboarWillHide() -> KeyboardInfo{
 return { rect, duration in
 print("keyboard will hide - frame : \(rect), duration : \(duration)")
 }
 }
 deinit {
 self.removeKeyboardControl()
 }
 }
 */
