//
//  MultipleTabsViewController.swift
//  MultipleTabs
//
//  Created by Xavier De Koninck on 14/09/2017.
//  Copyright © 2017 PagesJaunes. All rights reserved.
//

import UIKit

public final class MultipleTabsViewController: UIViewController {
  
  var titlesHeight: CGFloat = 50
  var titleBorderColor: UIColor = .black
  var titleBorderHeight: CGFloat = 5
  var titleSelectedColor: UIColor = .black
  var titleUnselectedColor: UIColor = .darkGray
  var titleSelectedFont: UIFont = .boldSystemFont(ofSize: 14)
  var titleUnselectedFont: UIFont = .systemFont(ofSize: 14)
  var borderWidthMultiplier: CGFloat = 0.8
  
  fileprivate var borderXConstraint: NSLayoutConstraint?
  
  public var dataSource: MultipleTabsViewControllerDataSource? {
    didSet {
      setup()
    }
  }
  
  public func register<T>(type: T.Type, identifier: String) where T: UICollectionViewCell {
    collectionView.register(type, forCellWithReuseIdentifier: identifier)
  }
  
  public func dequeue(identifier: String, index: Int) -> UICollectionViewCell {
    
    let ip = IndexPath(row: index, section: 0)
    return collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: ip)
  }
  
  fileprivate lazy var border: UIView = { [weak self] in
    
    let view = UIView(frame: .zero)
    
    view.backgroundColor = self?.titleBorderColor
    
    self?.borderView.addSubview(view)
    
    return view
    }()
  
  fileprivate lazy var buttonsView: UIView = { [weak self] in
    
    let view = UIView(frame: .zero)
    
    self?.titlesView.addSubview(view)
    
    if let strongSelf = self,
      let titlesView = self?.titlesView {
      view.translatesAutoresizingMaskIntoConstraints = false
      view.leadingAnchor.constraint(
        equalTo: titlesView.leadingAnchor).isActive = true
      view.trailingAnchor.constraint(
        equalTo: titlesView.trailingAnchor).isActive = true
      view.topAnchor.constraint(
        equalTo: titlesView.topAnchor).isActive = true
      view.bottomAnchor.constraint(
        equalTo: strongSelf.borderView.topAnchor).isActive = true
    }
    
    return view
    }()
  
  fileprivate lazy var borderView: UIView = { [weak self] in
    
    let view = UIView(frame: .zero)
    
    self?.titlesView.addSubview(view)
    
    if let strongSelf = self,
      let titlesView = self?.titlesView {
      view.translatesAutoresizingMaskIntoConstraints = false
      view.leadingAnchor.constraint(
        equalTo: titlesView.leadingAnchor).isActive = true
      view.trailingAnchor.constraint(
        equalTo: titlesView.trailingAnchor).isActive = true
      view.bottomAnchor.constraint(
        equalTo: titlesView.bottomAnchor).isActive = true
      view.heightAnchor.constraint(
        equalToConstant: strongSelf.titleBorderHeight).isActive = true
    }
    
    return view
    }()
  
  fileprivate lazy var titlesView: UIView = { [weak self] in
    
    let view = UIView(frame: .zero)
    
    self?.view.addSubview(view)
    
    if let strongSelf = self {
      view.translatesAutoresizingMaskIntoConstraints = false
      view.leadingAnchor.constraint(
        equalTo: strongSelf.view.leadingAnchor).isActive = true
      view.trailingAnchor.constraint(
        equalTo: strongSelf.view.trailingAnchor).isActive = true
      view.topAnchor.constraint(
        equalTo: strongSelf.view.topAnchor).isActive = true
      view.heightAnchor.constraint(
        equalToConstant: strongSelf.titlesHeight).isActive = true
    }
    
    return view
    }()
  
  
  fileprivate lazy var collectionView: UICollectionView = { [weak self] in
    
    let layout = UICollectionViewFlowLayout()
    layout.minimumLineSpacing = 0
    layout.minimumInteritemSpacing = 0
    layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)

    layout.scrollDirection = .horizontal
    
    let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
    
    cv.dataSource = self
    cv.delegate = self
    
    cv.isPagingEnabled = true
    cv.bounces = false
    cv.showsHorizontalScrollIndicator = false
    
    self?.view.addSubview(cv)
    
    if let strongSelf = self {
      cv.translatesAutoresizingMaskIntoConstraints = false
      cv.leadingAnchor.constraint(
        equalTo: strongSelf.view.leadingAnchor).isActive = true
      cv.trailingAnchor.constraint(
        equalTo: strongSelf.view.trailingAnchor).isActive = true
      cv.topAnchor.constraint(
        equalTo: strongSelf.titlesView.bottomAnchor).isActive = true
      cv.bottomAnchor.constraint(
        equalTo: strongSelf.view.bottomAnchor).isActive = true
    }
    
    return cv
    }()
  
  private func setup() {
    
    reset()        
    
    setupButtons()
    setupBorder()
    
    collectionView.cellForItem(at: IndexPath(row: 1, section: 0))
  }
  
  private func setupButtons() {
    
    if let nbItems = dataSource?.numberOfTabs(),
      nbItems > 0 {
      
      for index in 0 ..< nbItems {
        
        let button = UIButton(type: .custom)
        button.setTitle(dataSource?.title(forTabIndex: index), for: .normal)
        button.setTitleColor((index == 0) ? (titleSelectedColor) : (titleUnselectedColor), for: .normal)
        button.titleLabel?.font = (index == 0) ? (titleSelectedFont) : (titleUnselectedFont)
        
        buttonsView.addSubview(button)
        button.tag = index
        button.addTarget(self, action: #selector(self.buttonPressed), for: .touchDown)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        if index == 0 {
          button.leadingAnchor.constraint(
            equalTo: buttonsView.leadingAnchor).isActive = true
        }
        else {
          button.leadingAnchor.constraint(
            equalTo: buttonsView.subviews[index - 1].trailingAnchor).isActive = true
          button.widthAnchor.constraint(
            equalTo: buttonsView.subviews[index - 1].widthAnchor).isActive = true
        }
        
        button.topAnchor.constraint(
          equalTo: buttonsView.topAnchor).isActive = true
        button.bottomAnchor.constraint(
          equalTo: buttonsView.bottomAnchor).isActive = true
        
        if index == nbItems - 1 {
          button.trailingAnchor.constraint(
            equalTo: buttonsView.trailingAnchor).isActive = true
        }
      }
    }
  }
  
  private func setupBorder() {
    
    if let nbItems = dataSource?.numberOfTabs(),
      nbItems > 0 {
      
      border.translatesAutoresizingMaskIntoConstraints = false
      
      if let firstButton = buttonsView.subviews.first {
        self.borderXConstraint = border.centerXAnchor.constraint(
          equalTo: firstButton.centerXAnchor, constant: 0)
        self.borderXConstraint?.isActive = true
      }
      
      border.heightAnchor.constraint(
        equalTo: borderView.heightAnchor).isActive = true
      border.centerYAnchor.constraint(
        equalTo: borderView.centerYAnchor).isActive = true
      
      if let buttonView = buttonsView.subviews.first {
        border.widthAnchor.constraint(
          equalTo: buttonView.widthAnchor, multiplier: borderWidthMultiplier).isActive = true
      }
    }
  }
  
  @objc private func buttonPressed(_ button: UIButton) {
    
    let indexPath = IndexPath(row: button.tag, section: 0)
    collectionView.scrollToItem(at: indexPath, at: .left, animated: true)
    moved(toIndex: button.tag)
  }
  
  fileprivate func moved(toIndex index: Int) {
    
    buttonsView.subviews.forEach({
      if let button = $0 as? UIButton {
        button.setTitleColor((button.tag == index) ? (titleSelectedColor) : (titleUnselectedColor), for: .normal)
        button.titleLabel?.font = (button.tag == index) ? (titleSelectedFont) : (titleUnselectedFont)
      }
    })
    
    UIView.animate(withDuration: 0.3) { [weak self] in
      
      guard let strongSelf = self else { return }
      
      if let constraint = self?.borderXConstraint {
        self?.borderXConstraint?.isActive = false
        self?.border.removeConstraint(constraint)
      }
      self?.borderXConstraint = self?.border.centerXAnchor.constraint(
        equalTo: strongSelf.buttonsView.subviews[index].centerXAnchor, constant: 0)
      self?.borderXConstraint?.isActive = true
      self?.view.layoutIfNeeded()
    }
  }
  
  private func reset() {
    
    border.removeConstraints(border.constraints)
    buttonsView.subviews.forEach({ $0.removeFromSuperview() })
    collectionView.reloadData()
  }
  
  override public func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
    super.viewWillTransition(to: size, with: coordinator)
    coordinator.animate(alongsideTransition: nil, completion: { [weak self] _ in
      
      self?.collectionView.collectionViewLayout.invalidateLayout()
      
      if self?.dataSource?.numberOfTabs() ?? 0 > 0 {
        let indexPath = IndexPath(row: 0, section: 0)
        self?.collectionView.scrollToItem(at: indexPath, at: .left, animated: false)
      }
    })
  }
}

extension MultipleTabsViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UIScrollViewDelegate {
  
  public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    
    return dataSource?.numberOfTabs() ?? 0
  }
  
  public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
    return dataSource?.cell(forTabIndex: indexPath.row) ?? UICollectionViewCell()
  }
  
  public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
  }

  public func scrollViewDidScroll(_ scrollView: UIScrollView) {
    moved(toIndex: Int((scrollView.contentOffset.x + scrollView.frame.width / 2) / scrollView.frame.width))
  }
}

@objc public protocol MultipleTabsViewControllerDataSource {
  
  @objc func numberOfTabs() -> Int
  @objc func title(forTabIndex index: Int) -> String
  
  @objc func cell(forTabIndex index: Int) -> UICollectionViewCell
}
