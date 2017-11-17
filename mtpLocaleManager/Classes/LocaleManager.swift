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
    
    private var _currentLocale:String!
    
    public var currentLocale:String{
        return _currentLocale
    }
    
    public var currentNSLocale:NSLocale{
        return NSLocale(localeIdentifier: _currentLocale)
    }
    
    // Can't init is singleton
    private init() {
        _currentLocale=L102Language.currentAppleLanguage()
    }
    
    // MARK: Shared Instance
    public static let shared = LocaleManager()
    
    // MARK: Local Variable
    public func setLocale(_ isoLangCode:String){
        
        _currentLocale=isoLangCode
        
        guard L102Language.currentAppleLanguage() != isoLangCode else {
            return
        }
        
        //if app lcale was changed
        L102Language.setAppleLAnguageTo(lang: isoLangCode)
        Bundle.enforceLanguage(isoLangCode)
        enforceDirection(lng: isoLangCode)
        DoTheMagic()
        
        NotificationCenter.default.post(name: NSNotification.Name.LocaleDidChange, object: _currentLocale)
    }
    
    private func enforceDirection(lng:String){
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
    
    
    private func DoTheMagic() {
        MethodSwizzleGivenClassName(cls: Bundle.self, originalSelector: #selector(Bundle.localizedString(forKey:value:table:)), overrideSelector: #selector(Bundle.specialLocalizedStringForKey(_:value:table:)))
        MethodSwizzleGivenClassName(cls: UIApplication.self, originalSelector: #selector(getter: UIApplication.userInterfaceLayoutDirection), overrideSelector: #selector( getter: UIApplication.cstm_userInterfaceLayoutDirection))
        MethodSwizzleGivenClassName(cls: UITextField.self, originalSelector: #selector(UITextField.layoutSubviews), overrideSelector: #selector(UITextField.cstmlayoutSubviews))
        MethodSwizzleGivenClassName(cls: UILabel.self, originalSelector: #selector(UILabel.layoutSubviews), overrideSelector: #selector(UILabel.cstmlayoutSubviews))
        MethodSwizzleGivenClassName(cls: UITextView.self, originalSelector: #selector(UITextView.layoutSubviews), overrideSelector: #selector(UILabel.cstmlayoutSubviews))
    }
    
    
    public class func isLanguageRTL(isoLangCode: String=LocaleManager.shared.currentLocale) -> Bool {
            return NSLocale.characterDirection(forLanguage: isoLangCode) == .rightToLeft
    }
    
    public class func displayName(isoLangCode: String=LocaleManager.shared.currentLocale)->String?{
        let locale = NSLocale(localeIdentifier: isoLangCode)
        return locale.displayName(forKey: NSLocale.Key.identifier, value: locale.localeIdentifier)
    }
    
    public class func country(isoLangCode: String=LocaleManager.shared.currentLocale)->String?{
        if let name=displayName(isoLangCode: isoLangCode){
            return (name.range(of: "(")?.upperBound).flatMap { sInd in
                (name.range(of:")", range: sInd..<name.endIndex)?.lowerBound).map { eInd in
                    String(name[sInd..<eInd])
                }
            }
        }
        return nil
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











