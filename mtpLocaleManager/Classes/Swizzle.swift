//
//  LocaleManager+Swizzle.swift
//  LocaleManager
//
//  Created by Mostafa Taghipour on 11/17/17.
//  Copyright © 2017 RainyDay. All rights reserved.
//

import Foundation


/// Exchange the implementation of two methods of the same Class
 func MethodSwizzleGivenClassName(cls: AnyClass, originalSelector: Selector, overrideSelector: Selector) {
    guard let origMethod: Method = class_getInstanceMethod(cls, originalSelector),
        let overrideMethod: Method = class_getInstanceMethod(cls, overrideSelector) else{
            return
    }
    
    if (class_addMethod(cls, originalSelector, method_getImplementation(overrideMethod), method_getTypeEncoding(overrideMethod))) {
        class_replaceMethod(cls, overrideSelector, method_getImplementation(origMethod), method_getTypeEncoding(origMethod));
    } else {
        method_exchangeImplementations(origMethod, overrideMethod);
    }
}

 func ClassMethodSwizzleGivenClassName(cls: AnyClass, originalSelector: Selector, overrideSelector: Selector) {
    guard let origMethod: Method = class_getClassMethod(cls, originalSelector),
        let overrideMethod: Method = class_getClassMethod(cls, overrideSelector) else{
            return
    }
    
    if (class_addMethod(cls, originalSelector, method_getImplementation(overrideMethod), method_getTypeEncoding(overrideMethod))) {
        class_replaceMethod(cls, overrideSelector, method_getImplementation(origMethod), method_getTypeEncoding(origMethod));
    } else {
        method_exchangeImplementations(origMethod, overrideMethod);
    }
}
