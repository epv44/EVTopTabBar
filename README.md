# EVTopTabBar
																					 
[![CI Status](http://img.shields.io/travis/Eric Vennaro/EVTopTabBar.svg?style=flat)](https://travis-ci.org/epv44/EVTopTabBar)
[![Version](https://img.shields.io/cocoapods/v/EVTopTabBar.svg?style=flat)](http://cocoapods.org/pods/EVTopTabBar)
[![License](https://img.shields.io/cocoapods/l/EVTopTabBar.svg?style=flat)](http://cocoapods.org/pods/EVTopTabBar)
[![Platform](https://img.shields.io/cocoapods/p/EVTopTabBar.svg?style=flat)](http://cocoapods.org/pods/EVTopTabBar)

## About

EVTopTabBar is a custom UIPageViewController for iOS where the page control is at the top.  It currently supports two tabs.

![Screenshot0][img0]

## Usage

To run the example project, clone the repo, and run `pod install` from the Example directory.

## Requirements

* Swift 2.0+
* iOS 8.0+

## Installation

EVTopTabBar is available through [CocoaPods][podLink]. To install
it, simply add the following line to your Podfile:

```ruby
pod "EVTopTabBar"
```

Also include 

```ruby
use_frameworks!
```

## Getting Started

````swift
import EVTopTabBar
````

Implement the EVTabBar protocol and conform to it.  In order to conform to the protocol declare:

````swift
var pageController = UIPageViewController(transitionStyle: .Scroll, navigationOrientation: .Horizontal, options: nil)
//need to instantiate the topTabBar itself, later we will implement the delegate method
var topTabBar: EVPageViewTopTabBar = EVPageViewTopTabBar()
//array of view controllers that will be controlled by the page view controller
var subviewControllers: [UIViewController] = []
//image from the sample project can use any UIImage you want, this shadow is what is displayed under the tab bar.
var shadowView = UIImageView(image: UIImage(imageLiteral: "filter-background-image"))
````

Now in your view controller implement the EVPageViewTopTabBarDelegate method ````willSelectViewControllerAtIndex```` This method allows for view controllers to switch and gives a space to perform any other actions.

```swift
extension ViewController: EVPageViewTopTabBarDelegate {
	//delegate method
    func willSelectViewControllerAtIndex(index: Int, direction: UIPageViewControllerNavigationDirection) {
    	//required line that changes the displayed view controller
        pageController.setViewControllers([self.subviewControllers[index]], direction: direction, animated: true, completion: nil)
        //add whatever code you wish to occur on the transition!
    }
}
```
Next will want to call the ```setupPageView()``` and ```setupConstraints()``` methods in order to setup the page layout.  You can override both of these methods to create a more custom application.  

Lastly you will want to setup the topTabBar you previously declared

```swift
//attributes of the topTabBar you can set
topTabBar.fontColors = (selectedColor: UIColor.grayColor(), unselectedColor: UIColor.lightGrayColor())
topTabBar.rightButtonText = "Events"
topTabBar.leftButtonText = "Contacts"
topTabBar.labelFont = UIFont(name: ".SFUIText-Regular", size: 11)!
topTabBar.indicatorViewColor = UIColor.blueColor()
topTabBar.backgroundColor = UIColor.whiteColor()
topTabBar.setupUI()
//ensure you set the topTabBar's delegate
topTabBar.delegate = self
//add view controllers you wish to display
let firstVC = FirstViewController(nibName:"FirstViewController", bundle: nil)
let secondVC = SecondViewController(nibName:"SecondViewController", bundle: nil)
subviewControllers = [firstVC, secondVC]
```

## Project description

### EVTabBar Protocol

#### Methods

* ````setupPageView()```` Sets the UI for the View Controller including the UIPageViewController, shadowView and View Controllers to display inside of the Page View.
* ````setupConstraints()```` Sets the initial constraints for the View Controller

### EVPageViewTopTabBar

#### Methods

* ````setupUI()```` Sets the UI for the tab bar itself
* `````willSelectViewControllerAtIndex(index: Int, direction: UIPageViewControllerNavigationDirection)````` Controls the changing of the View Controllers inside of the PageViewController and gives a space to perform any other actions on transition

## Future Features

* Support for more tabs
* More flexibility with the shadow view

## Author

Eric Vennaro, epv9@case.edu, [blog][blogLink]

## License

EVTopTabBar is available under the [MIT License][mitLink]. See the LICENSE file for more info.
>**Copyright &copy; 2016-present Eric Vennaro.**

[img0]:https://raw.githubusercontent.com/epv44/EVTopTabBar/master/tabBar.gif
[podLink]:http://cocoapods.org
[blogLink]:http://www.ericvennaro.com
[mitLink]:http://opensource.org/licenses/MIT