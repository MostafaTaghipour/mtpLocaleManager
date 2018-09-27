//
//  LocaleManager+Extensions.swift
//  LocaleManager
//
//  Created by Mostafa Taghipour on 11/17/17.
//  Copyright © 2017 RainyDay. All rights reserved.
//

import UIKit



extension NSNotification.Name{
    public  static let LocaleDidChange = Notification.Name("localeChanged")
}

//MARK:- Extensions
//UIApplication isRTL property
extension UIApplication {
   public class var isRTL:Bool{
        get{
            return LocaleManager.isLanguageRTL()
        }
    }
}

//get localized image runtime
extension String {
    public var localizedImage: UIImage? {
        return localizedImage()
            ?? localizedImage(type: ".png")
            ?? localizedImage(type: ".jpg")
            ?? localizedImage(type: ".jpeg")
            ?? UIImage(named: self)
    }
    
    private func localizedImage(type: String = "") -> UIImage? {
        guard let imagePath = Bundle.main.localizedBundle?.path(forResource: self, ofType: type) else {
            return nil
        }
        return UIImage(contentsOfFile: imagePath)
    }
}

//change images direction runtime
extension UIApplication {
    @objc  var cstm_userInterfaceLayoutDirection : UIUserInterfaceLayoutDirection {
        get {
            var direction = UIUserInterfaceLayoutDirection.leftToRight
            if UIApplication.isRTL {
                direction = .rightToLeft
            }
            return direction
        }
    }
}

//change images Localized String runtime
extension Bundle {
    @objc  func specialLocalizedStringForKey(_ key: String, value: String?, table tableName: String?) -> String {
        if self == Bundle.main {
            let currentLanguage = L102Language.currentAppleLanguage()
            var bundle = Bundle();
            if let _path = Bundle.main.path(forResource: L102Language.currentAppleLanguageFull(), ofType: "lproj") {
                bundle = Bundle(path: _path)!
            }else
                if let _path = Bundle.main.path(forResource: currentLanguage, ofType: "lproj") {
                    bundle = Bundle(path: _path)!
                } else {
                    let _path = Bundle.main.path(forResource: "Base", ofType: "lproj")!
                    bundle = Bundle(path: _path)!
            }
            return (bundle.specialLocalizedStringForKey(key, value: value, table: tableName))
        } else {
            return (self.specialLocalizedStringForKey(key, value: value, table: tableName))
        }
    }
}

//change label text align runtime
extension UILabel {
    @objc   func cstmlayoutSubviews() {
        self.cstmlayoutSubviews()
        if self.isKind(of: NSClassFromString("UITextFieldLabel")!) {
            return // handle special case with uitextfields
        }
        if self.textAlignment == .natural{
            if UIApplication.isRTL  {
                self.textAlignment = .right
            } else {
                self.textAlignment = .left
            }
        }
    }
}

//change textField text align runtime
extension UITextField {
    @objc   func cstmlayoutSubviews() {
        self.cstmlayoutSubviews()
        if self.textAlignment == .natural{
            if UIApplication.isRTL  {
                self.textAlignment = .right
            } else {
                self.textAlignment = .left
            }
        }
    }
}

//change textField text align runtime
extension UITextView {
    @objc  func cstmlayoutSubviews() {
        self.cstmlayoutSubviews()
        if self.textAlignment == .natural{
            if UIApplication.isRTL  {
                self.textAlignment = .right
            } else {
                self.textAlignment = .left
            }
        }
    }
}
