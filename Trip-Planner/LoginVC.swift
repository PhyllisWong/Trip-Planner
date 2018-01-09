//
//  ViewController.swift
//  Trip-Planner
//
//  Created by djchai on 12/6/17.
//  Copyright © 2017 Phyllis Wong. All rights reserved.
//

import UIKit
import KeychainSwift


class LoginVC: UIViewController {
    
    let keychain = KeychainSwift()
    
    
    // Variables
    // Perminently store user data
    var user = UserDefaults()
   
    // Outlets
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var usernameTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.emailTF.delegate = self
        self.usernameTF.delegate = self
        self.passwordTF.delegate = self
    }

    // Actions
    @IBAction func loginBtn(_ sender: Any) {
        let user = User(email: emailTF.text!, username: usernameTF.text!, password: passwordTF.text!)
        print(user)
        keychain.set(user.username, forKey: "username")
        keychain.set(user.password, forKey: "password")
    }
    @IBAction func signupBtn(_ sender: Any) {
        let user = User(email: emailTF.text!, username: usernameTF.text!, password: passwordTF.text!)
        
        Networking.fetch(route: Route.users(), user: user, httpMethod: HTTPMethod.get) { (data, int) in
            if int == 200 {
                let username = self.keychain.get("username")
                let password = self.keychain.get("password")
                print(username, password)
                UserDefaults.standard.set(true, forKey: "isUserLoggedIn")
                let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
                let tripsVC = storyboard.instantiateViewController(withIdentifier: "TripsVC") as! TripsVC
                tripsVC.user = user
            }
        }
    }

}


extension LoginVC: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    // hide the keyboard when user touches outside the keyboard
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
}








