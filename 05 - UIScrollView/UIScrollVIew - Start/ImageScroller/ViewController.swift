/// Copyright (c) 2018 Razeware LLC
/// 
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
/// 
/// The above copyright notice and this permission notice shall be included in
/// all copies or substantial portions of the Software.
/// 
/// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
/// distribute, sublicense, create a derivative work, and/or sell copies of the
/// Software in any work that is designed, intended, or marketed for pedagogical or
/// instructional purposes related to programming, coding, application development,
/// or information technology.  Permission for such use, copying, modification,
/// merger, publication, distribution, sublicensing, creation of derivative works,
/// or sale is expressly withheld.
/// 
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.

import UIKit

class ViewController: UIViewController {
  
  // MARK: - Outlets
  
  @IBOutlet weak var imageView: UIImageView!
  @IBOutlet weak var scrollView: UIScrollView!
  
  // MARK: - View Life Cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // The order of methods called is important. When not set this way centering does not work.
    scrollView.delegate = self
    imageView.frame.size = imageView.image!.size
    setZoomParameters(scrollView.bounds.size)
    centerImageView()
  }
  
  override func viewWillLayoutSubviews() {
    // Override Necessary for laying out view when device rotates
    setZoomParameters(scrollView.bounds.size)
    centerImageView()
  }
  
  // MARK: - Helper methods
  
  private func centerImageView() {
    let scrollViewSize = scrollView.bounds.size
    let imageSize = imageView.frame.size
    
    let horizontalSpace = imageSize.width < scrollViewSize.width ? (scrollViewSize.width - imageSize.width) / 2 : 0
    let verticalSpace = imageSize.height < scrollViewSize.height ? (scrollViewSize.height - imageSize.height) / 2 : 0
    
    scrollView.contentInset = UIEdgeInsets(top: verticalSpace,
                                           left: horizontalSpace,
                                           bottom: verticalSpace,
                                           right: horizontalSpace)
  }
  
  private func setZoomParameters(_ scrollViewSize: CGSize) {
    let imageSize = imageView.bounds.size
    let widthScale = scrollViewSize.width / imageSize.width
    let heightScale = scrollViewSize.height / imageSize.height
    let minScale = min(widthScale, heightScale)
    
    scrollView.zoomScale = minScale
    scrollView.maximumZoomScale = 3.0
    scrollView.minimumZoomScale = minScale
  }
}

extension ViewController: UIScrollViewDelegate {
  
  func viewForZooming(in scrollView: UIScrollView) -> UIView? {
    return imageView
  }
}
