//
//  AlertViewController.swift
//  Trip-Planner
//
//  Created by Phyllis Wong on 1/11/18.
//  Copyright © 2018 Phyllis Wong. All rights reserved.
//

import Foundation
import UIKit

struct AlertViewController {
    static func showAlert() -> UIAlertController {
        let alertController = UIAlertController(title: "Error", message: "Wrong email or password", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        return alertController
    }
}

