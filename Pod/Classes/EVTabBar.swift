//
//  EVTabBar.swift
//  Pods
//
//  Created by Eric Vennaro on 2/29/16.
//
//
import UIKit

public protocol EVTabBar: class {
    var shadowView: UIImageView { get set }
    var subviewControllers: [UIViewController] { get set }
    var topTabBar: EVPageViewTopTabBar { get set }
    var pageController: UIPageViewController { get set }
}

public extension EVTabBar where Self: UIViewController {
    
    public func setupPageView() {
        topTabBar.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(topTabBar)
        pageController.view.translatesAutoresizingMaskIntoConstraints = false
        pageController.view.frame = view.bounds
        shadowView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(shadowView)
        pageController.setViewControllers([subviewControllers[0]], direction: .Forward, animated: false, completion: nil)
        addChildViewController(pageController)
        view.addSubview(pageController.view)
        pageController.didMoveToParentViewController(self)
        pageController.view.addSubview(shadowView)
    }
    
    public func setupConstraints() {
        let views: [String:AnyObject] = ["menuBar" : topTabBar, "pageView" : pageController.view, "shadow" : shadowView]
        view.addConstraints(
            NSLayoutConstraint.constraintsWithVisualFormat("|[menuBar]|", options: [], metrics: nil, views: views))
        view.addConstraints(
            NSLayoutConstraint.constraintsWithVisualFormat("V:|[menuBar(==40)][pageView]|", options: [], metrics: nil, views: views))
        view.addConstraints(
            NSLayoutConstraint.constraintsWithVisualFormat("|[pageView]|", options: [], metrics: nil, views: views))
        
        pageController.view.addConstraints(
            NSLayoutConstraint.constraintsWithVisualFormat("|[shadow]|", options: [], metrics: nil, views: views))
        pageController.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[shadow(7)]", options: [], metrics: nil, views: ["shadow" : shadowView]))
    }
}

