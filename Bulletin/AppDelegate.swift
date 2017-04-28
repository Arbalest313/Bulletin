//
//  AppDelegate.swift
//  Bulletin
//
//  Created by huangyuan on 30/03/2017.
//  Copyright © 2017 hYDev. All rights reserved.
//

import UIKit
import XCGLogger
import IQKeyboardManagerSwift
let log = XCGLogger.default
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        logSetup()
        initWindow()
        setupIQKeyboard()
        setupAppearance()
        return true
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

}

extension AppDelegate {
    func initWindow() {

        guard let window = UIApplication.shared.delegate?.window else {
            return
        }
        let rootVC = initTabbar()
        window!.rootViewController = rootVC
        window!.makeKeyAndVisible()
    }
    
    func initTabbar() -> BaseTabbarViewController {
        let tabbar = BaseTabbarViewController()
        let postingVC = BaseNavigationController(rootViewController: HomeVC())
        postingVC.tabBarItem.title = "Bulleting"
        postingVC.tabBarItem.selectedImage = UIImage(named: "tabbar_discover_Sel")//?.withRenderingMode(.alwaysOriginal)
        postingVC.tabBarItem.image =  UIImage(named: "tabbar_discover_nonSel")//?.withRenderingMode(.alwaysOriginal)
        
        let postingVC2 = BaseNavigationController(rootViewController: HomeVC())
        postingVC2.tabBarItem.title = "Related"
        postingVC2.tabBarItem.selectedImage = UIImage(named: "tabbar_message_Sel")//?.withRenderingMode(.alwaysOriginal)
        postingVC2.tabBarItem.image =  UIImage(named: "tabbar_message_nonSel")//?.withRenderingMode(.alwaysOriginal)
        
        let postingVC3 = BaseNavigationController(rootViewController: HomeVC())
        postingVC3.tabBarItem.title = "Posting"
        postingVC3.tabBarItem.selectedImage = UIImage(named: "tabbar_message_Sel")//?.withRenderingMode(.alwaysOriginal)
        postingVC3.tabBarItem.image =  UIImage(named: "tabbar_message_nonSel")//?.withRenderingMode(.alwaysOriginal)
        
        let postingVC4 = BaseNavigationController(rootViewController: HomeVC())
        postingVC4.tabBarItem.title = "History"
        postingVC4.tabBarItem.selectedImage = UIImage(named: "tabbar_message_Sel")//?.withRenderingMode(.alwaysOriginal)
        postingVC4.tabBarItem.image =  UIImage(named: "tabbar_message_nonSel")//?.withRenderingMode(.alwaysOriginal)
        
        let postingVC5 = BaseNavigationController(rootViewController: HomeVC())
        postingVC5.tabBarItem.title = "Me"
        postingVC5.tabBarItem.selectedImage = UIImage(named: "tabbar_me_el")//?.withRenderingMode(.alwaysOriginal)
        postingVC5.tabBarItem.image =  UIImage(named: "tabbar_me_nonSel")//?.withRenderingMode(.alwaysOriginal)
       
        tabbar.viewControllers = [postingVC, postingVC2, postingVC3, postingVC4, postingVC5]
       
        return tabbar
    }
    
    func logSetup() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss.SSS"
        log.dateFormatter = dateFormatter
        log.setup(level: .debug, showThreadName: true, showLevel: true, showFileNames: true, showLineNumbers: true, writeToFile: "logging/Debug", fileLevel: .debug)
        log.logAppDetails()
    }
    
    func setupIQKeyboard() {
        IQKeyboardManager.sharedManager().enable = true
        IQKeyboardManager.sharedManager().enableAutoToolbar = true
        IQKeyboardManager.sharedManager().shouldResignOnTouchOutside = true
    }
    
    func setupAppearance(){
        // appearance
        UINavigationBar.appearance().tintColor = ThemeConstant.defaultNavigationBarTintColor
        UINavigationBar.appearance().barTintColor = ThemeConstant.defaultNavigationBarTintColor
        UINavigationBar.appearance().backgroundColor = ThemeConstant.defaultNavigationBarTintColor

        UINavigationBar.appearance().setBackgroundImage(UIImage(),
                                                        for: .default)
        UINavigationBar.appearance().shadowImage = UIImage()
        UINavigationBar.appearance().titleTextAttributes = [NSFontAttributeName: ThemeConstant.defaultFont(18),
                                                            NSForegroundColorAttributeName : UIColor.white]
        UIBarButtonItem.appearance().setTitleTextAttributes([NSFontAttributeName: ThemeConstant.defaultFont(15),
                                                             NSForegroundColorAttributeName : UIColor.white], for:.normal)
        let statusBar: UIView = UIApplication.shared.value(forKey: "statusBar") as! UIView
        if statusBar.responds(to: #selector(setter: UIView.backgroundColor)) {
            statusBar.backgroundColor = ThemeConstant.defaultNavigationBarTintColor
        } 
        UIApplication.shared.statusBarStyle = .lightContent
        
        UITabBar.appearance().tintColor = ThemeConstant.defaultNavigationBarTintColor
//        UITabBar.appearance().barTintColor = ThemeConstant.defaultNavigationBarTintColor

        UITextField.appearance().tintColor = ThemeConstant.defaultNavigationBarTintColor
        UITextView.appearance().tintColor = ThemeConstant.defaultNavigationBarTintColor
    }
}

