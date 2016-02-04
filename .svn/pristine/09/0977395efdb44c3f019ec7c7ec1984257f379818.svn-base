//
//  AppDelegate.swift
//  SwiftTest
//
//  Created by 清正 on 16/1/15.
//  Copyright © 2016年 qz. All rights reserved.
//

import UIKit


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
        self.window?.backgroundColor = UIColor.whiteColor()
        
        UIApplication.sharedApplication().setStatusBarStyle(UIStatusBarStyle.LightContent, animated: true)
        
        //初始化视图控制器
        let VC = ViewController()
        //初始化导航控制器
        let nav = UINavigationController (rootViewController: VC)
        //导航背景图片
        nav.navigationBar .setBackgroundImage(UIImage(named: "navBg"), forBarMetrics: UIBarMetrics.Default)
        //导航颜色
        nav.navigationBar .tintColor = UIColor.yellowColor()
        //设置导航文字属性
        nav.navigationBar .titleTextAttributes = [NSForegroundColorAttributeName:UIColor.yellowColor(),NSFontAttributeName:UIFont.systemFontOfSize(18)]
        //默认返回按钮图片
        UIBarButtonItem .appearance() .setBackButtonBackgroundImage((UIImage (named: "back")), forState: UIControlState.Normal, barMetrics: UIBarMetrics.Default)
        //隐藏返回文字
        UIBarButtonItem.appearance().setBackButtonTitlePositionAdjustment(UIOffsetMake(0, -64), forBarMetrics: UIBarMetrics.Default)
        //设为根视图
        self.window?.rootViewController = nav
        //显示视图
        self.window?.makeKeyAndVisible()
        return true
    }
    

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

