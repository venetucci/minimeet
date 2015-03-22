//
//  TabViewController.swift
//  MiniMeet
//
//  Created by Michelle Venetucci Harvey on 3/14/15.
//  Copyright (c) 2015 hi_hu. All rights reserved.
//

import UIKit

class TabViewController: UIViewController {
    
    var isPresenting: Bool = true
    
    var feedViewController: UIViewController!
    var createViewController: UIViewController!
    var profileViewController: UIViewController!
    var selectedViewController: UIViewController?
    
    @IBOutlet weak var contentView: UIView!
    
    @IBOutlet var buttons: [UIButton]!
    var viewControllersArray: [UIViewController]! = [UIViewController]()
    
    var selectedIndex: Int! = 0
    var duration: NSTimeInterval!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var storyboard = UIStoryboard(name: "Main", bundle: nil)
        feedViewController = storyboard.instantiateViewControllerWithIdentifier("feedNavigation") as UIViewController
        createViewController = storyboard.instantiateViewControllerWithIdentifier("create") as CreateViewController
        profileViewController = storyboard.instantiateViewControllerWithIdentifier("profileNavigation") as UIViewController
        
        
        viewControllersArray = [feedViewController, profileViewController]
        
        tabBarDidPress(buttons[0])
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func displayContentController(content: UIViewController) {
        addChildViewController(content)
        contentView.addSubview(content.view)
        content.didMoveToParentViewController(self)
    }
    
    
    func hideContentController(content: UIViewController) {
        content.willMoveToParentViewController(nil)
        content.view.removeFromSuperview()
        content.removeFromParentViewController()
    }
    
    
    @IBAction func tabBarDidPress(sender: AnyObject) {
        removeChildView(viewControllersArray[selectedIndex])
        buttons[selectedIndex].selected = false
        
        selectedIndex = sender.tag
        //    println("selected \(selectedIndex)")
        
        buttons[selectedIndex].selected = true
        addChildViewController(viewControllersArray[selectedIndex])
        var tabContentView = viewControllersArray[selectedIndex].view
        tabContentView.frame = contentView.frame
        contentView.addSubview(tabContentView)
        viewControllersArray[selectedIndex].didMoveToParentViewController(self)
        selectedViewController = viewControllersArray[selectedIndex];
    }
    
    func removeChildView(content: UIViewController) {
        content.willMoveToParentViewController(nil)
        content.view.removeFromSuperview()
        content.removeFromParentViewController()
    }
    
    
    
    
}