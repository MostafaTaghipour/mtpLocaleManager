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

    
    @IBOutlet weak var langPicker: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        langPicker.dataSource=self
        langPicker.delegate=self
        
        let currentLang = LocaleManager.shared.currentLocale
        if let selectedValue=LocaleManager.preferredLanguages.index(of: currentLang){
            langPicker.selectRow(selectedValue, inComponent: 0, animated: false)
        }
    }
    
    
    func reloadAllViewControllers(){
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let navigationController = mainStoryboard.instantiateViewController(withIdentifier: "mainNavigationController") as! UINavigationController
        let settingVC = mainStoryboard.instantiateViewController(withIdentifier: "settingVC")
        navigationController.pushViewController(settingVC, animated: false)
        UIApplication.shared.keyWindow?.rootViewController = navigationController
    }
}


extension SettingsViewController:UIPickerViewDelegate,UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return  1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return LocaleManager.preferredLanguages.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return LocaleManager.displayName(isoLangCode: LocaleManager.preferredLanguages[row])
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        LocaleManager.shared.setLocale(LocaleManager.preferredLanguages[row])
        reloadAllViewControllers()
    }
    
}

