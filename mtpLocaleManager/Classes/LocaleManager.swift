//
//  AppLocale.swift
//  Footkal
//
//  Created by Remote User on 4/12/17.
//  Copyright © 2017 hojan. All rights reserved.
//

import Foundation
import UIKit

public class LocaleManager {
    
    fileprivate var _currentLocale:String!
    
    public var currentLocale:Locale{
        get{
        return Locale(identifier: _currentLocale)
        }
        set{
            guard _currentLocale != newValue.identifier else {return}
            
            _currentLocale = newValue.identifier
            
            L102Language.setAppleLAnguageTo(lang: _currentLocale)
            Bundle.enforceLanguage(_currentLocale)
            enforceDirection(lng: _currentLocale)
            DoTheMagic()
            
            NotificationCenter.default.post(name: NSNotification.Name.AppLocaleDidChange, object: _currentLocale)
        }
    }
    

    // Can't init is singleton
    private init() {
       _currentLocale = L102Language.currentAppleLanguage()
    }
    
    // MARK: Shared Instance
    public static let shared = LocaleManager()
    
    
    public  func resetLocale(){
        L102Language.resetAppleLanguage()
        currentLocale = Locale(identifier: L102Language.currentAppleLanguage())
    }
}


extension LocaleManager{
    
    public  var isLanguageRTL : Bool {
        return LocaleManager.isLanguageRTL(isoLangCode: currentLocale.identifier)
    }
    
    public  func displayName(locale: Locale)->String?{
        return LocaleManager.displayName(isoLangCode: currentLocale.identifier)
    }
    
    public  func country(locale: Locale)->String?{
        return LocaleManager.country(isoLangCode: currentLocale.identifier)
    }
    
    public class func isLanguageRTL(isoLangCode: String) -> Bool {
        return NSLocale.characterDirection(forLanguage: isoLangCode) == .rightToLeft
    }
    
    public class func displayName(isoLangCode: String)->String?{
        let locale = NSLocale(localeIdentifier: isoLangCode)
        return locale.displayName(forKey: NSLocale.Key.identifier, value: locale.localeIdentifier)
    }
    
    public class func country(isoLangCode: String)->String?{
        if let name=displayName(isoLangCode: isoLangCode){
            return (name.range(of: "(")?.upperBound).flatMap { sInd in
                (name.range(of:")", range: sInd..<name.endIndex)?.lowerBound).map { eInd in
                    String(name[sInd..<eInd])
                }
            }
        }
        return nil
    }
    
    public class func isLanguageRTL(locale: Locale) -> Bool {
        return isLanguageRTL(isoLangCode: locale.identifier)
    }
    
    public class func displayName(locale: Locale)->String?{
        return displayName(isoLangCode: locale.identifier)
    }
    
    public class func country(locale: Locale)->String?{
        return country(isoLangCode: locale.identifier)
    }
    
    public static var preferredLanguages:[String]{
        get{
            return NSLocale.preferredLanguages
        }
    }
    
    public static var availableLocales:[String]{
        get{
            return NSLocale.availableLocaleIdentifiers
        }
    }
    
}

extension LocaleManager{

    
    fileprivate func enforceDirection(lng:String){
        if LocaleManager.isLanguageRTL(isoLangCode: lng){
            if #available(iOS 9.0, *) {
                UIView.appearance().semanticContentAttribute = .forceRightToLeft
            }
        }
        else{
            if #available(iOS 9.0, *) {
                UIView.appearance().semanticContentAttribute = .forceLeftToRight
            }
        }
    }
    
    
    fileprivate func DoTheMagic() {
        MethodSwizzleGivenClassName(cls: Bundle.self, originalSelector: #selector(Bundle.localizedString(forKey:value:table:)), overrideSelector: #selector(Bundle.specialLocalizedStringForKey(_:value:table:)))
        MethodSwizzleGivenClassName(cls: UIApplication.self, originalSelector: #selector(getter: UIApplication.userInterfaceLayoutDirection), overrideSelector: #selector( getter: UIApplication.cstm_userInterfaceLayoutDirection))
        MethodSwizzleGivenClassName(cls: UITextField.self, originalSelector: #selector(UITextField.layoutSubviews), overrideSelector: #selector(UITextField.cstmlayoutSubviews))
        MethodSwizzleGivenClassName(cls: UILabel.self, originalSelector: #selector(UILabel.layoutSubviews), overrideSelector: #selector(UILabel.cstmlayoutSubviews))
        MethodSwizzleGivenClassName(cls: UITextView.self, originalSelector: #selector(UITextView.layoutSubviews), overrideSelector: #selector(UILabel.cstmlayoutSubviews))
    }
    
}









