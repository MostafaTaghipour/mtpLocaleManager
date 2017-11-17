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
        self.imageview.image=UIImage(named: LocaleManager.shared.currentLocale=="fa" ? "iran.png" : "usa.png")
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }

}

