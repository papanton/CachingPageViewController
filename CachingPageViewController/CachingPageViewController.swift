//
//  CachingPageViewController.swift
//  CachingPageViewController
//
//  Created by Antonis papantoniou on 9/19/17.
//  Copyright © 2017 Antonis papantoniou. All rights reserved.
//

import UIKit

class CachingPageViewController: UIPageViewController {

  private var reusableViewControllers = Set<ViewController>()

  var colors: [UIColor] = [] {
    didSet {
      if oldValue.count == 0 && colors.count > 0 {
        setViewController(color: colors[0])
      }
    }
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    dataSource = self
    colors = [.red, .blue, .brown, .cyan, .gray, .green, .magenta, .orange]
  }

  // This function returns an unused view controller from the cache
  // or instantiates and returns a new one
  func getController(color: UIColor) -> ViewController {
    let unusedViewControllers = reusableViewControllers.filter { $0.parent == nil }
    if let someUnusedViewController = unusedViewControllers.first {
      someUnusedViewController.color = color
      return someUnusedViewController
    } else {
      let newViewController = ViewController()
      reusableViewControllers.insert(newViewController)
      newViewController.color = color
      return newViewController
    }
  }

  func setViewController(color: UIColor) {
    guard colors.contains(color) else { return }
    let vc = getController(color: color)
    setViewControllers([vc], direction: .forward, animated: false, completion: nil)
  }

}


// MARK: UIPageViewControllerDataSource

extension CachingPageViewController: UIPageViewControllerDataSource {

  func pageViewController(
    _ pageViewController: UIPageViewController,
    viewControllerBefore viewController: UIViewController) -> UIViewController? {
    guard let viewController = viewController as? ViewController,
      let vcIndex = colors.index(of: viewController.color) else {
        return nil
    }
    let previousIndex = vcIndex - 1
    guard previousIndex >= 0, colors.count > previousIndex else { return nil }

    return getController(color: colors[previousIndex])
  }

  func pageViewController(
    _ pageViewController: UIPageViewController,
    viewControllerAfter viewController: UIViewController) -> UIViewController? {
    guard let viewController = viewController as? ViewController,
      let vcIndex = colors.index(of: viewController.color) else {
        return nil
    }

    let nextIndex = vcIndex + 1
    guard colors.count > nextIndex else { return nil }

    return getController(color: colors[nextIndex])
  }

}
