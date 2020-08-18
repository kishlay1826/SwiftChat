//
//  WelcomeViewController.swift
//  SwiftChat
//
//  Created by Kishlay Chhajer on 2020-08-18.
//  Copyright © 2020 Kishlay Chhajer. All rights reserved.
//

import UIKit
import CLTypingLabel

class WelcomeViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: CLTypingLabel!
    
    override func viewWillAppear(_ animated: Bool) {
           super.viewWillAppear(animated)
           navigationController?.isNavigationBarHidden = true
       }
       
       override func viewWillDisappear(_ animated: Bool) {
           super.viewWillDisappear(animated)
           navigationController?.isNavigationBarHidden = false
       }

    override func viewDidLoad() {
        super.viewDidLoad()
         titleLabel.text = "SwiftChat"
    }
}

