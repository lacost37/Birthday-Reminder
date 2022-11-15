//
//  ViewController.swift
//  Birthday Reminder
//
//  Created by Mac on 11.11.2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var birthlabel: UILabel!
    @IBOutlet var inButton: UIButton!
    @IBOutlet var idSwitch: UISwitch!
    @IBOutlet var faceIdLabel: UILabel!
    @IBOutlet var emailLabel: UITextField!
    @IBOutlet var passLabel: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       // label
        birthlabel.layer.borderColor = UIColor.gray.cgColor
        birthlabel.layer.borderWidth = 2
        
        passLabel.isSecureTextEntry = true
        
        // button
        inButton.layer.cornerRadius = 10
        
        // switch
        idSwitch.isOn = false
        idSwitch.addTarget(self, action: #selector(checkIsOn(target:)), for: .valueChanged)
    }

    // Actions
    @IBAction func eyeButton(_ sender: Any) {
        if passLabel.isSecureTextEntry {
            passLabel.isSecureTextEntry = false
        } else {
            passLabel.isSecureTextEntry = true
        }
    }
    
    
    @IBAction func signInAction(_ sender: Any) {
        
    }
    
    
    // function
    func alert(title: String, message: String, style: UIAlertController.Style) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default)
        alertController.addAction(action)
        self.present(alertController, animated: true)
    }
    
    
    @objc func checkIsOn(target: UISwitch) {
        if target.isOn {
            faceIdLabel.textColor = UIColor.blue
        } else {
            faceIdLabel.textColor = UIColor.black
        }
    }
}

