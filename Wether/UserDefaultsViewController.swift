//
//  UserDefaultsViewController.swift
//  Wether
//
//  Created by  Виктор Борисович on 11.08.2019.
//  Copyright © 2019 MT. All rights reserved.
//

import UIKit

class UserDefaultsViewController: UIViewController {

    @IBOutlet weak var nameFieldView: UITextField!
    @IBOutlet weak var lastNameFieldView: UITextField!
    
    private let kNameValue = "UD.kNameValue"
    private let kLastNameValue = "UD.kLastNameValue"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        nameFieldView.text = UserDefaults.standard.string(forKey: kNameValue)
        lastNameFieldView.text = UserDefaults.standard.string(forKey: kLastNameValue)
    }
    
    @IBAction func onNameChange(_ sender: UITextField) {
        UserDefaults.standard.set(sender.text, forKey: kNameValue)
    }
    
    @IBAction func onLastNameChange(_ sender: UITextField) {
        UserDefaults.standard.set(sender.text, forKey: kLastNameValue)
    }
}
