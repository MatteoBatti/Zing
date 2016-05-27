//
//  ViewController.swift
//  Zing
//
//  Created by Matteo Battistini on 21/03/16.
//  Copyright © 2016 Matteo Battistini. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {
    
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var CF: UITextField!
    @IBOutlet weak var passoword: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        if isLoggedIn() == true {
            if let vc = SB.instantiateViewControllerWithIdentifier("ZingAngleRecorderVCId") as? ZingAngleRecorderVC {
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    @IBAction func openZingAngleRecorder() {
        if validateTextField() == true {
            saveLogInDate()
            if let vc = SB.instantiateViewControllerWithIdentifier("ZingAngleRecorderVCId") as? ZingAngleRecorderVC {
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
        
    }
    
    private func validateTextField() -> Bool {
        
        if self.firstName.text?.characters.count <= 0 {
            self.firstName.becomeFirstResponder()
            return false
        }
        
        if self.lastName.text?.characters.count <= 0 {
            self.lastName.becomeFirstResponder()
            return false
        }
        
        if self.CF.text?.characters.count <= 0 {
            self.CF.becomeFirstResponder()
            return false
        }
        
        if self.passoword.text != "PasswordZingBG" {
            self.passoword.becomeFirstResponder()
            return false
        }
        
        return true
    }
    
    private func isLoggedIn() -> Bool {
        if  UD.stringForKey(key_first_name)?.characters.count > 0 &&
            UD.stringForKey(key_last_name)?.characters.count > 0 &&
            UD.stringForKey(key_cf)?.characters.count > 0 &&
            UD.stringForKey(key_password) == "PasswordZingBG"{
                return true
        } else {
            return false
        }
    }
    
    private func saveLogInDate() {
        UD.setValue(self.firstName.text, forKey: key_first_name)
        UD.setValue(self.lastName.text, forKey: key_last_name)
        UD.setValue(self.CF.text, forKey: key_cf)
        UD.setValue(self.passoword.text, forKey: key_password)
        UD.synchronize()
    }
    
    
}

