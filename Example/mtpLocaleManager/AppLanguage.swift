//
//  AppLanguage.swift
//  mtpLocaleManager_Example
//
//  Created by Mostafa Taghipour on 9/24/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import Foundation

enum AppLanguage:String{
    case System = "system"
    case English = "english"
    case Arabic = "arabic"
    
    
    var title:String{
        switch self {
        case .System:
            return "System (default)"
        case .English:
            return "English"
        case .Arabic:
            return "Arabic"
        }
    }
    
    var code:String{
        switch self {
        case .System:
            return ""
        case .English:
            return "en"
        case .Arabic:
            return "ar"
        }
    }
    
    static var all : [AppLanguage] = [.System,.English,.Arabic]
}
