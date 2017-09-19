//
//  ViewController.swift
//  CachingPageViewController
//
//  Created by Antonis papantoniou on 9/19/17.
//  Copyright © 2017 Antonis papantoniou. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  var color = UIColor.red {
    didSet {
      view.backgroundColor = color
    }
  }

}

