/*
 * Copyright (c) 2017 Razeware LLC
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

import UIKit

class ViewController: UIViewController {
  @IBOutlet weak var fgScrollView: UIScrollView!
  @IBOutlet weak var felipeImageView: UIImageView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // adjust scroll view insets
    fgScrollView.contentInset = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
    
    // animate the wings
    var animationFrames = [UIImage]()
    for i in 0...3 {
      if let image = UIImage(named: "Bird\(i)") {
        animationFrames.append(image)
      }
    }
    
    // Add Observers for Keyboard Notifications
    NotificationCenter.default.addObserver(self, selector: #selector(adustInsetForKeyboardInset(_:)),
                                           name: UIResponder.keyboardWillShowNotification,
                                           object: nil)
    
    NotificationCenter.default.addObserver(self, selector: #selector(adustInsetForKeyboardInset(_:)),
                                           name: UIResponder.keyboardWillHideNotification,
                                           object: nil)
    
    felipeImageView.animationImages = animationFrames
    felipeImageView.animationDuration = 0.4
    felipeImageView.startAnimating()
  }
  
  
  // MARK: - Helper Methods
  
  @objc private func adustInsetForKeyboardInset(_ notification: Notification) {
    guard let userInfo = notification.userInfo else { return }
    let keyboardFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
    
    let show = (notification.name == UIResponder.keyboardWillShowNotification) ? true : false
    
    let adjustmentHeight = (keyboardFrame.height + 10) * (show ? 1: 0)
    fgScrollView.contentInset.bottom = adjustmentHeight
    fgScrollView.scrollIndicatorInsets.bottom = adjustmentHeight
  }
}

extension ViewController: UIScrollViewDelegate { }

extension ViewController: UITextFieldDelegate {
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    textField.resignFirstResponder()
    return true
  }
}
