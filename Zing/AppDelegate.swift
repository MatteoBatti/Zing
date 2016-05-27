//
//  AppDelegate.swift
//  Zing
//
//  Created by Matteo Battistini on 21/03/16.
//  Copyright © 2016 Matteo Battistini. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift

var UD = NSUserDefaults.standardUserDefaults()
var SB = UIStoryboard(name: "Main", bundle: nil)
var key_first_name = "zing.ud.login.first.name"
var key_last_name = "zing.ud.login.last.name"
var key_cf = "zing.ud.login.cf"
var key_password = "zing.ud.login.password"

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        IQKeyboardManager.sharedManager().enable = true
        
        return true
    }

    func applicationWillResignActive(application: UIApplication) {}

    func applicationDidEnterBackground(application: UIApplication) {}

    func applicationWillEnterForeground(application: UIApplication) {}

    func applicationDidBecomeActive(application: UIApplication) {}

    func applicationWillTerminate(application: UIApplication) {}


}

