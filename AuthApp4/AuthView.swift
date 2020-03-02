//
//  ViewController.swift
//  AuthApp4
//
//  Created by Octavio Rojas on 3/1/20.
//  Copyright © 2020 Tattva. All rights reserved.
//

import UIKit

class AuthView: UIViewController {
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var continueButton: UIButton!

    let viewModel = AuthViewModel()
    let validator = FieldValidator()

    override func viewDidLoad() {
        super.viewDidLoad()
        userNameTextField.delegate = self
        passwordTextField.delegate = self
        viewModel.setButtonState(continueButton, isEnabled: false)
    }

    @IBAction func onButtonPressed(_ sender: Any) {
        guard viewModel.makeUserAndGroup(userName: userNameTextField.text,
                                         password: passwordTextField.text)
            != nil else {
                viewModel.presentAlertView(rootViewController: self,
                                           title: "Login failed",
                                           message: "Wrong username or password")
                return
        }
    }
}

extension AuthView: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        return true
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if validationWasOk() {
            viewModel.setButtonState(continueButton, isEnabled: true)
        } else {
            viewModel.setButtonState(continueButton, isEnabled: false)
        }
        return true
    }

    func validationWasOk() -> Bool {
        return validator.validateFieldString(userNameTextField.text) &&
            validator.validateFieldString(passwordTextField.text)
    }
}

