//
//  ViewController.swift
//  Demo
//
//  Created by Xavier De Koninck on 14/09/2017.
//  Copyright © 2017 PagesJaunes. All rights reserved.
//

import UIKit
import MultipleTabs

class ViewController: UIViewController {
  
  var multipleTabsViewController: MultipleTabsViewController?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    if let multipleTabsViewController = childViewControllers.first as? MultipleTabsViewController {
      self.multipleTabsViewController = multipleTabsViewController
      multipleTabsViewController.register(type: Cell1.self, identifier: "Cell1")
      multipleTabsViewController.register(type: Cell2.self, identifier: "Cell2")
      multipleTabsViewController.dataSource = self
    }
  }
}

extension ViewController: MultipleTabsViewControllerDataSource {
  
  func numberOfTabs() -> Int {
    return 2
  }
  
  func title(forTabIndex index: Int) -> String {
    return "Title"
  }
  
  func cell(forTabIndex index: Int) -> UICollectionViewCell {

    let cell: UICollectionViewCell
    
    if index == 0 {
      cell = multipleTabsViewController!.dequeue(identifier: "Cell1", index: index)
    }
    else {
      cell = multipleTabsViewController!.dequeue(identifier: "Cell2", index: index)
    }
    
    return cell
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

