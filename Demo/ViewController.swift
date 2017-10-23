/*********************************************
 
 MIT License
 
 Copyright (c) 2017 XavierDK
 
 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in all
 copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 SOFTWARE.
 
 *********************************************/

import UIKit
import MultipleTabs

class ViewController: MultipleTabsViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    register(type: Cell1.self, identifier: "Cell1")
    register(type: Cell2.self, identifier: "Cell2")
    delegate = self
    dataSource = self
    
    // The line can change the current tab index to 1
    // change(toIndex: 1)
  }
}

extension ViewController: MultipleTabsViewControllerDataSource {
  
  /// The number of tabs you want
  func numberOfTabs(forMultipleTabs multipleTabs: MultipleTabsViewController) -> Int {
    return 2
  }
  
  /// The title for each tab
  func title(forMultipleTabs multipleTabs: MultipleTabsViewController, atTabIndex index: Int) -> String {
    return "Title"
  }
  
  /// Return the container cell you want for the tabIndex
  func cell(forMultipleTabs multipleTabs: MultipleTabsViewController, atTabIndex index: Int) -> UICollectionViewCell {
    
    let cell: UICollectionViewCell
    
    if index == 0 {
      cell = dequeue(identifier: "Cell1", index: index)
    }
    else {
      cell = dequeue(identifier: "Cell2", index: index)
    }
    
    return cell
  }
}

extension ViewController: MultipleTabsViewControllerDelegate {
  
  func moved(forMultipleTabs: MultipleTabsViewController, atTabIndex index: Int) {
    print("New tab index is \(index)")
  }
}

final class Cell1: UICollectionViewCell {
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    backgroundColor = .red
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

final class Cell2: UICollectionViewCell {
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    backgroundColor = .orange
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

