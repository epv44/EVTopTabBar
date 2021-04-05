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
    var pageController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
    var topTabBar: EVPageViewTopTabBar? {
        didSet {
            topTabBar?.fontColors = (selectedColor: UIColor.gray, unselectedColor: UIColor.lightGray)
            topTabBar?.rightButtonText = "Events"
            topTabBar?.leftButtonText = "Contacts"
            topTabBar?.middleButtonText = "Tasks"
            topTabBar?.middleRightButtonText = "Locations"
            topTabBar?.labelFont = UIFont(name: "Helvetica", size: 11)!
            topTabBar?.indicatorViewColor = UIColor.blue
            topTabBar?.backgroundColor = UIColor.white
            topTabBar?.delegate = self
        }
    }
    var subviewControllers: [UIViewController] = []
    var shadowView = UIImageView(image: #imageLiteral(resourceName: "filter-background-image"))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        topTabBar = EVPageViewTopTabBar(for: .four, withIndicatorStyle: .textWidth)
        let firstVC = FirstViewController(nibName:"FirstViewController", bundle: nil)
        let secondVC = SecondViewController(nibName:"SecondViewController", bundle: nil)
        let thirdVC = ThirdViewController(nibName: "ThirdViewController", bundle: nil)
        let fourthVC = FourthViewController(nibName: "FourthViewController", bundle: nil)
        subviewControllers = [firstVC, secondVC, thirdVC, fourthVC]
        setupPageView()
        setupConstraints()
        self.title = "EVTopTabBar"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

//MARK: EVTabBarDataSource
extension ViewController: EVTabBarDelegate {
    func willSelectViewControllerAtIndex(_ index: Int, direction: UIPageViewController.NavigationDirection) {
        if index > subviewControllers.count {
            pageController.setViewControllers([subviewControllers[subviewControllers.count - 1]], direction: direction, animated: true, completion: nil)
        } else {
            pageController.setViewControllers([subviewControllers[index]], direction: direction, animated: true, completion: nil)
        }
    }
}
