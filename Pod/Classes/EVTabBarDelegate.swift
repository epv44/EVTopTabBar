//
//  EVTabBarDataSource.swift
//  Pods
//
//  Created by Eric Vennaro on 10/6/16.
//
//

import Foundation
///Datasource for tab bar
public protocol EVTabBarDelegate: class {
    /**
     Controls what UIViewController is displayed
     
     - Parameter index: Int, array index determining which view controller is to be displayed
     - Parameter direction: UIPageViewControllerNavigationDirection
     */
    func willSelectViewControllerAtIndex(_ index: Int, direction: UIPageViewControllerNavigationDirection)
    
}
