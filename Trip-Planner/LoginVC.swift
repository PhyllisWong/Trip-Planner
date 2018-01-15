//
//  ViewController.swift
//  Trip-Planner
//
//  Created by Phyllis Wong on 12/6/17.
//  Copyright © 2017 Phyllis Wong. All rights reserved.
//

import UIKit
import KeychainSwift


class LoginVC: UIViewController {
    
    
    // Variables
    let keychain = KeychainSwift()
    
    
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

    @IBAction func loginSignupBtnPressed(_ sender: Any) {
        let user = User(email: emailTF.text!, username: usernameTF.text!, password: passwordTF.text!)
        
        Networking.fetch(route: Route.loginUser(email: user.email, password: user.password)) { (data, res) in
            if res == 200 {
                UserDefaults.standard.set(false, forKey: "isUserLoggedIn")
                
                let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
                let tripsVC = storyboard.instantiateViewController(withIdentifier: "TripsNav") as! UINavigationController
//            tripsVC.user = user
                    DispatchQueue.main.async {
                        // 1. Grab the app delegate delegate
                        // 2. Set the rootViewController of the window property of the delegate
                        // 3. Make key and visible
                        
                        let appDelegate = UIApplication.shared.delegate!
                        appDelegate.window??.rootViewController = tripsVC
                        appDelegate.window??.makeKeyAndVisible()
                        
                    }
                }
                
                else {
                    DispatchQueue.main.async {
                        self.present(AlertViewController.showAlert(), animated: true)
                    }
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


//        Networking.fetch(route: Route.createUser(user: user)) { (data, int) in
//            if int == 200 {
//                UserDefaults.standard.set(true, forKey: "isUserLoggedIn")
//                let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
//                let tripsVC = storyboard.instantiateViewController(withIdentifier: "TripsVC") as! TripsVC
//
//                tripsVC.user = user
//                DispatchQueue.main.async {
//                    self.navigationController?.pushViewController(tripsVC, animated: true)
//                }
//            }
//            else {
//                DispatchQueue.main.async {
//                    self.present(AlertViewController.showAlert(), animated: true)
//                }
//            }
//        }






