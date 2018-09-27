//
//  SettingsViewController.swift
//  mtpLocaleManager_Example
//
//  Created by Mostafa Taghipour on 11/17/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import UIKit
import mtpLocaleManager

class SettingsViewController: UIViewController {
    
    let locale_key = "locale_key"
    
    @IBOutlet weak var langPicker: UIPickerView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        langPicker.dataSource=self
        langPicker.delegate=self
        
        let savedLang = AppLanguage(rawValue: UserDefaults.standard.string(forKey: locale_key) ?? AppLanguage.System.rawValue)
        langPicker.selectRow(AppLanguage.all.index(of: savedLang!)!, inComponent: 0, animated: false)
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NotificationCenter.default.addObserver(self, selector: #selector(localeDidChanged(notification:)), name: NSNotification.Name.LocaleDidChange, object: nil)
    }
    
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.LocaleDidChange, object: nil)
    }
    
    @objc func localeDidChanged(notification:Notification)  {
        reloadAllViewControllers()
    }
    
    func reloadAllViewControllers(){
        let storyboard = UIApplication.shared.keyWindow?.rootViewController?.storyboard
        let id = UIApplication.shared.keyWindow?.rootViewController?.value(forKey: "storyboardIdentifier")
        let rootVC = storyboard?.instantiateViewController(withIdentifier: id as! String)
        UIApplication.shared.keyWindow?.rootViewController = rootVC
        
        if let settingVC = storyboard?.instantiateViewController(withIdentifier: "settingVC"),
            let nav = (rootVC as? UINavigationController){
            nav.pushViewController(settingVC, animated: false)
        }
    }
    
    
}


extension SettingsViewController:UIPickerViewDelegate,UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return AppLanguage.all.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let value = AppLanguage.all[row]
        
        if value == .System{
            return value.title
        }
        return LocaleManager.displayName(isoLangCode: value.code)
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let value = AppLanguage.all[row]
        UserDefaults.standard.set(value.rawValue, forKey: locale_key)
        
        if value == .System{
            LocaleManager.shared.resetLocale()
        }
        else{
            LocaleManager.shared.currentLocale  = Locale(identifier: value.code)
        }
    }
    
}

