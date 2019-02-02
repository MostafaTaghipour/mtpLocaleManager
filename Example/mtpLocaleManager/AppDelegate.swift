//
//  AppDelegate.swift
//  mtpLocaleManager
//
//  Created by mostafa.taghipour@ymail.com on 11/17/2017.
//  Copyright (c) 2017 mostafa.taghipour@ymail.com. All rights reserved.
//

import mtpLocaleManager
import UIKit

let locale_key = "locale_key"

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        if let savedLang = UserDefaults.standard.string(forKey: locale_key),
            let lang: AppLanguage = AppLanguage(rawValue: savedLang) {
            if lang == AppLanguage.System {
                LocaleManager.shared.resetLocale()
            } else {
                LocaleManager.shared.currentLocale = Locale(identifier: lang.code)
            }
        }

        // set development language as app language
        /* if let path = Bundle.main.path(forResource: "Info", ofType: "plist"),
         let dict = NSDictionary(contentsOfFile: path) as? [String: AnyObject],
         let value = dict["CFBundleDevelopmentRegion"] as? String{
         LocaleManager.shared.currentLocale = Locale(identifier: value)
         } */

        
        // set rootViewController programmatically
        /* window = UIWindow(frame: UIScreen.main.bounds)
         let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
         let navigationController = mainStoryboard.instantiateViewController(withIdentifier: "mainNavigationController") as! UINavigationController
         window?.rootViewController = navigationController
         window?.makeKeyAndVisible() */

        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(osLocaleChanged(notification:)),
                                               name: NSLocale.currentLocaleDidChangeNotification,
                                               object: nil)

        return true
    }

    @objc func osLocaleChanged(notification: NSNotification!) {
        print(notification.object as! Locale)
    }
}
