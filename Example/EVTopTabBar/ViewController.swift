//
//  ViewController.swift
//  EVTopTabBar
//
//  Created by Eric Vennaro on 02/29/2016.
//  Copyright (c) 2016 Eric Vennaro. All rights reserved.
//

import UIKit
import EVTopTabBar

class ViewController: UIViewController, EVTabBar {
    var pageController = UIPageViewController(transitionStyle: .Scroll, navigationOrientation: .Horizontal, options: nil)
    var topTabBar: EVPageViewTopTabBar = EVPageViewTopTabBar()
    var subviewControllers: [UIViewController] = []
    var shadowView = UIImageView(image: UIImage(imageLiteral: "filter-background-image"))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupEVTabBar()
        setupPageView()
        setupConstraints()
        self.title = "EVTopTabBar"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    private func setupEVTabBar() {
        topTabBar.fontColors = (selectedColor: UIColor.grayColor(), unselectedColor: UIColor.lightGrayColor())
        topTabBar.rightButtonText = "Events"
        topTabBar.leftButtonText = "Contacts"
        topTabBar.labelFont = UIFont(name: ".SFUIText-Regular", size: 11)!
        topTabBar.indicatorViewColor = UIColor.blueColor()
        topTabBar.backgroundColor = UIColor.whiteColor()
        topTabBar.setupUI()
        topTabBar.delegate = self
        
        let firstVC = FirstViewController(nibName:"FirstViewController", bundle: nil)
        let secondVC = SecondViewController(nibName:"SecondViewController", bundle: nil)
        subviewControllers = [firstVC, secondVC]
    }
}

//MARK: PageViewTopTabBarDelegate
extension ViewController: EVPageViewTopTabBarDelegate {
    func willSelectViewControllerAtIndex(index: Int, direction: UIPageViewControllerNavigationDirection) {
        pageController.setViewControllers([self.subviewControllers[index]], direction: direction, animated: true, completion: nil)
    }
}