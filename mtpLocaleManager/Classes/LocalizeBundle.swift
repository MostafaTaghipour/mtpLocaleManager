//
//  LocalizeBundle.swift
//  LocaleManager
//
//  Created by Mostafa Taghipour on 11/17/17.
//  Copyright © 2017 RainyDay. All rights reserved.
//

import Foundation



//MARK:- Force Localization
///    Custom subclass to enable on-the-fly Bundle.main language change
fileprivate final class LocalizedBundle: Bundle {
    ///    Overrides system method and enforces usage of particular .lproj translation bundle
    override public func localizedString(forKey key: String, value: String?, table tableName: String?) -> String {
        if let bundle = Bundle.main.localizedBundle {
            return bundle.localizedString(forKey: key, value: value, table: tableName)
        }
        return super.localizedString(forKey: key, value: value, table: tableName)
    }
}


fileprivate extension DispatchQueue {
    
    private static var _onceTracker = [String]()
    
    /**
     Executes a block of code, associated with a unique token, only once.  The code is thread safe and will
     only execute the code once even in the presence of multithreaded calls.
     
     - parameter token: A unique reverse DNS style name such as com.vectorform.<name> or a GUID
     - parameter block: Block to execute once
     */
    fileprivate class func once(token: String, block:()->Void) {
        objc_sync_enter(self); defer { objc_sync_exit(self) }
        
        if _onceTracker.contains(token) {
            return
        }
        
        _onceTracker.append(token)
        block()
    }
}


 extension Bundle {
    private struct AssociatedKeys {
        static var b = "LocalizedMainBundle"
    }
    
    fileprivate var localizedBundle: Bundle? {
        get {
            //    warning: Make sure this object you are fetching really exists
            return objc_getAssociatedObject(self, &AssociatedKeys.b) as? Bundle
        }
    }
    
    /// Loads the translations for the given language code.
    ///
    /// - Parameter code: two-letter ISO 639-1 language code
     static func enforceLanguage(_ code: String) {
        guard let path = Bundle.main.path(forResource: code, ofType: "lproj") else { return }
        guard let bundle = Bundle(path: path) else { return }
        
        //    prepare translated bundle for chosen language and
        //    save it as property of the Bundle.main
        objc_setAssociatedObject(Bundle.main, &AssociatedKeys.b, bundle, .OBJC_ASSOCIATION_RETAIN)
        
        //    now override class of the main bundle (only once during the app lifetime)
        //    this way, `localizedString(forKey:value:table)` method in our subclass above will actually be called
        DispatchQueue.once(token: AssociatedKeys.b)  {
            object_setClass(Bundle.main, LocalizedBundle.self)
        }
    }
    
    
    ///    Removes the custom bundle
    fileprivate static func clearInAppOverrides() {
        objc_setAssociatedObject(Bundle.main, &AssociatedKeys.b, nil, .OBJC_ASSOCIATION_RETAIN)
    }
}
