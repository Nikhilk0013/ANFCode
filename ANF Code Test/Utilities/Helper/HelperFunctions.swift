//
//  HelperFunctions.swift
//  ANF Code Test
//
//  Created by Nikhil on 28/09/22.
//

import UIKit

//MARK: - Helper Methods
func showAlert(withTitle title: String, Message message: String, controller: UIViewController) {
    let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
    ac.addAction(UIAlertAction(title: title, style: .default))
    controller.present(ac, animated: true)
}
