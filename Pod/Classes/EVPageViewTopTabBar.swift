//
//  EVPageViewTopTabBar.swift
//  Pods
//
//  Created by Eric Vennaro on 2/29/16.
//
//
import UIKit

///UIView that represents the tab EVPageViewTopTabBar
open class EVPageViewTopTabBar: UIView  {
    private var tabs: NumberOfTabs
    fileprivate var indicatorXPosition = NSLayoutConstraint()
    fileprivate var buttonFontColors: (selectedColor: UIColor, unselectedColor: UIColor)?
    ///Delegate for the tab bar
    open weak var delegate: EVTabBarDelegate?
    internal var currentState: Int
    fileprivate var indicatorView: UIView? {
        didSet {
            indicatorView?.translatesAutoresizingMaskIntoConstraints = false
            indicatorView?.layer.cornerRadius = 4
            addSubview(indicatorView!)
        }
    }
    private var rightButton: UIButton? {
        didSet {
            rightButton?.translatesAutoresizingMaskIntoConstraints = false
            rightButton?.addTarget(self, action: .buttonTapped, for: .touchUpInside)
            addSubview(rightButton!)
        }
    }
    private var leftButton: UIButton? {
        didSet {
            leftButton?.translatesAutoresizingMaskIntoConstraints = false
            leftButton?.addTarget(self, action: .buttonTapped, for: .touchUpInside)
            addSubview(leftButton!)
        }
    }
    private var middleButton: UIButton? {
        didSet {
            middleButton?.translatesAutoresizingMaskIntoConstraints = false
            middleButton?.addTarget(self, action: .buttonTapped, for: .touchUpInside)
            addSubview(middleButton!)
        }
    }
    private var middleRightButton: UIButton? {
        didSet {
            middleRightButton?.translatesAutoresizingMaskIntoConstraints = false
            middleRightButton?.addTarget(self, action: .buttonTapped, for: .touchUpInside)
            addSubview(middleRightButton!)
        }
    }
    ///Stored property to set the selected and unselected font color
    open var fontColors: (selectedColor: UIColor, unselectedColor: UIColor)? {
        didSet {
            buttonFontColors = fontColors
            rightButton?.setTitleColor(fontColors!.unselectedColor, for: UIControlState())
            middleButton?.setTitleColor(fontColors!.unselectedColor, for: UIControlState())
            leftButton?.setTitleColor(fontColors!.selectedColor, for: UIControlState())
            middleRightButton?.setTitleColor(fontColors!.unselectedColor, for: UIControlState())
        }
    }
    ///Stored property sets the text for the right UIButton
    open var rightButtonText: String? {
        didSet {
            rightButton?.setTitle(rightButtonText, for: UIControlState())
            setNeedsLayout()
        }
    }
    ///Stored property sets the text for the left UIButton
    open var leftButtonText: String? {
        didSet {
            leftButton?.setTitle(leftButtonText, for: UIControlState())
            setNeedsLayout()
        }
    }
    
    ///Stored property sets the text for the middle UIButton
    open var middleButtonText: String? {
        didSet {
            middleButton?.setTitle(middleButtonText, for: UIControlState())
            setNeedsLayout()
        }
    }
    
    open var middleRightButtonText: String? {
        didSet {
            middleRightButton?.setTitle(middleRightButtonText, for: UIControlState())
            setNeedsLayout()
        }
    }
    
    ///Stored property sets the font for both UIButton labels
    open var labelFont: UIFont? {
        didSet {
            rightButton?.titleLabel?.font = labelFont
            leftButton?.titleLabel?.font = labelFont
            middleButton?.titleLabel?.font = labelFont
            middleRightButton?.titleLabel?.font = labelFont
            setNeedsLayout()
        }
    }
    ///Stored property sets the background color of the indicator view
    open var indicatorViewColor: UIColor? {
        didSet {
            indicatorView?.backgroundColor = indicatorViewColor
            setNeedsLayout()
        }
    }
    
    //MARK: - Initialization
    ///init with frame
    public init(for tabs: NumberOfTabs) {
        self.tabs = tabs
        currentState = 111
        super.init(frame: CGRect.zero)
        setupUI()
    }
    ///init with coder
    required public init?(coder aDecoder: NSCoder) {
        tabs = .two
        currentState = 111
        super.init(coder: aDecoder)
        setupUI()
    }
    
    //MARK: - Methods
    //Sets UI attributes for the tab bar
    private func setupUI() {
        indicatorView = UIView()
        switch tabs {
        case .two:
            rightButton = UIButton()
            leftButton = UIButton()
            leftButton?.tag = 111
            rightButton?.tag = 222
        case .three:
            rightButton = UIButton()
            leftButton = UIButton()
            middleButton = UIButton()
            leftButton?.tag = 111
            middleButton?.tag = 222
            rightButton?.tag = 333
        case .four:
            rightButton = UIButton()
            leftButton = UIButton()
            middleButton = UIButton()
            middleRightButton = UIButton()
            leftButton?.tag = 111
            middleButton?.tag = 222
            middleRightButton?.tag = 333
            rightButton?.tag = 444
        }
        setupGestureRecognizers()
        setConstraints()
    }
    
    @objc func buttonWasTouched(_ sender: UIButton!) {
        animate(to: sender.tag)
    }

    @objc func respondToRightSwipe(_ gesture: UIGestureRecognizer) {
        if currentState.modTen < rightButton!.tag.modTen {
            animate(to: (currentState.modTen + 1).toTag)
        }
    }
    
    @objc func respondToLeftSwipe(_ gesture: UIGestureRecognizer) {
        if currentState.modTen > leftButton!.tag.modTen {
            animate(to: (currentState.modTen - 1).toTag)
        }
    }
    
    private func setupGestureRecognizers() {
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: .respondToRightSwipe)
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: .respondToLeftSwipe)
        
        rightSwipe.direction = .right
        leftSwipe.direction = .left
        
        addGestureRecognizer(rightSwipe)
        addGestureRecognizer(leftSwipe)
    }
    
    //MARK: - Constraints
    private func setConstraints() {
        guard let leftButton = leftButton, let rightButton = rightButton, let indicatorView = indicatorView else {
            NSLog("Error: must set views in order to establish constraints")
            return
        }
        var views: [String: AnyObject] = [:]
        
        switch tabs {
        case .two:
            views = ["leftButton" : leftButton, "indicatorView" : indicatorView, "rightButton" : rightButton]
            addConstraint(NSLayoutConstraint(item: leftButton, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: -70))
            addConstraint(NSLayoutConstraint(item: rightButton, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .width, multiplier: 1, constant: 100))
            addConstraint(NSLayoutConstraint(item: rightButton, attribute: .leading, relatedBy: .equal, toItem: leftButton, attribute: .trailing, multiplier: 1, constant: 30))
            addConstraint(NSLayoutConstraint(item: leftButton, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .width, multiplier: 1, constant: 100))
        case .three:
            views = ["leftButton" : leftButton, "indicatorView" : indicatorView, "rightButton" : rightButton, "middleButton" : middleButton!]
            addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "|-40-[leftButton]-[middleButton(==leftButton)]-[rightButton(==leftButton)]-40-|", options: [], metrics: nil, views: views))
            addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-9-[middleButton]-12-|", options: [], metrics: nil, views: views))
        case .four:
            views = ["leftButton" : leftButton, "indicatorView" : indicatorView, "rightButton" : rightButton, "middleButton" : middleButton!, "middleRightButton" : middleRightButton!]
            addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "|-[leftButton]-[middleButton(==leftButton)]-[middleRightButton(==leftButton)]-[rightButton(==leftButton)]-|", options: [], metrics: nil, views: views))
            addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-9-[middleButton]-12-|", options: [], metrics: nil, views: views))
            addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-9-[middleRightButton]-12-|", options: [], metrics: nil, views: views))
        }

        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-9-[leftButton][indicatorView(==3)]-9-|", options: [], metrics: nil, views: views))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "[indicatorView(==20)]", options: [], metrics: nil, views: views))
        indicatorXPosition = NSLayoutConstraint(item: indicatorView, attribute: .centerX, relatedBy: .equal, toItem: leftButton, attribute: .centerX, multiplier: 1, constant: 0)
        addConstraint(indicatorXPosition)
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-9-[rightButton]-12-|", options: [], metrics: nil, views: views))
    }
}

extension EVPageViewTopTabBar: AnimateTransition {
    internal func animate(to newState: Int) {
        let direction: UIPageViewControllerNavigationDirection = newState.modTen - currentState.modTen > 0 ? .forward : .reverse
        
        guard let fromButton = viewWithTag(currentState) as? UIButton, let toButton = viewWithTag(newState) as? UIButton else {
            NSLog("Error, do not use tags 111, 222, 333, 444 these are used to identify buttons in EVTopTabBar")
            return
        }
        
        let constraint = NSLayoutConstraint(item: indicatorView!, attribute: .centerX, relatedBy: .equal, toItem: toButton, attribute: .centerX, multiplier: 1, constant: 0)
        
        if let topBarDelegate = delegate {
            topBarDelegate.willSelectViewControllerAtIndex(newState.modTen - 1, direction: direction)
            UIView.animate(withDuration: 0.5, delay: 0, options: UIViewAnimationOptions(), animations: {
                self.removeConstraint(self.indicatorXPosition)
                self.indicatorXPosition = constraint
                self.addConstraint(self.indicatorXPosition)
                self.layoutIfNeeded()
                }, completion: { finished in
                    fromButton.setTitleColor(self.buttonFontColors?.unselectedColor, for: UIControlState())
                    toButton.setTitleColor(self.buttonFontColors?.selectedColor, for: UIControlState())
                }
            )
        }
        currentState = newState
    }
}

//MARK: - Selector
private extension Selector {
    static let buttonTapped = #selector(EVPageViewTopTabBar.buttonWasTouched(_:))
    static let respondToRightSwipe = #selector(EVPageViewTopTabBar.respondToRightSwipe(_:))
    static let respondToLeftSwipe = #selector(EVPageViewTopTabBar.respondToLeftSwipe(_:))
}

private extension Int {
    var modTen: Int {
        return self % 10
    }
    
    var toTag: Int {
        return (self + (self * 10) + (self * 100))
    }
}
