//
//  ViewController.swift
//  mtpLocaleManager
//
//  Created by mostafa.taghipour@ymail.com on 11/17/2017.
//  Copyright (c) 2017 mostafa.taghipour@ymail.com. All rights reserved.
//

import UIKit
import mtpLocaleManager

class ViewController: UIViewController {

    @IBOutlet weak var imageview: UIImageView!
    @IBOutlet weak var localizedLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        localizedLabel.text=NSLocalizedString("label_title", comment: "label")
         self.imageview.image="map.png".localizedImage
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
       NotificationCenter.default.addObserver(self, selector: #selector(localeDidChanged(notification:)), name: NSNotification.Name.AppLocaleDidChange, object: nil)
    }

    
 
    
    @objc func localeDidChanged(notification:Notification)  {
        if let locale=notification.object as? String{
            print(locale)
        }
    }
}

