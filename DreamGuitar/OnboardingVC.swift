//
//  OnboardingVC.swift
//  DreamGuitar
//
//  Created by Robin Farmer on 07/09/2017.
//  Copyright © 2017 Maddisys Limited. All rights reserved.
//

import UIKit

class OnboardingVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func startTouched(_ sender: UIButton) {
        UserDefaults.standard.set(true, forKey: "tappedButton")
        performSegue(withIdentifier: "toMainSegue", sender: self)
        
    }
}
