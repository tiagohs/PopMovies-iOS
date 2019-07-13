//
//  LoginController.swift
//  popmovies
//
//  Created by Tiago Silva on 05/07/19.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//


import UIKit
import GoogleSignIn

// MARK: LoginController: BaseViewController

class LoginController: BaseViewController {
    
    // MARK: Outlets
    
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var loginFaceIDButton: UIButton!
    @IBOutlet weak var loginFacebookButton: UIButton!
    @IBOutlet weak var loginTwitterButton: UIButton!
    @IBOutlet weak var loginGoogleButton: GIDSignInButton!
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    // MARK: Properties

    var presenter: LoginPresenterInterface?
}

// MARK: Lifecycle Methods

extension LoginController {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.presenter?.viewWillAppear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.presenter?.viewDidLoad()
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        self.presenter?.viewDidDisappear(animated)
    }
}

extension LoginController: GIDSignInUIDelegate {
    
}

// MARK: LoginViewInterface - Setup Methods

extension LoginController: LoginViewInterface {
    
    func setupUI() {
        backButton.layer.cornerRadius = backButton.bounds.width / 2
        backButton.imageView?.setImageColorBy(uiColor: UIColor.white)
        
        usernameTextField.layer.borderColor = UIColor.gray.cgColor
        
        passwordTextField.layer.borderColor = UIColor.gray.cgColor
    }
    
    func setupGoogleAuthUI() {
        GoogleAuthManager.shared.setupUI(delegate: self)
    }
}

extension LoginController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        loginButton.isEnabled =
           ( usernameTextField.text != nil && !(usernameTextField.text?.isEmpty ?? true) ) &&
           ( passwordTextField.text != nil && !(passwordTextField.text?.isEmpty ?? true) )
        
        
        return true
    }
    
}

// MARK: Actions Methods

extension LoginController {
    
    @IBAction func didSignUpClicked(_ sender: Any) {
        presenter?.didSignUpClicked()
    }
    
    @IBAction func didSignWithEmailClicked(_ sender: Any) {
        guard let email = usernameTextField.text else {
            return
        }
        guard let password = passwordTextField.text else {
            return
        }
        
        presenter?.didSignWithEmailClicked(email, password)
    }
    
    @IBAction func didSignWithFaceIdClicked(_ sender: Any) {
        presenter?.didSignWithFaceIdClicked()
    }
    
    @IBAction func didSignWithFacebookClicked(_ sender: Any) {
        presenter?.didSignWithFacebookClicked(with: self)
    }
    
    @IBAction func didSignWithTwitterClicked(_ sender: Any) {
        presenter?.didSignWithTwitterClicked(with: self)
    }
    
    @IBAction func didSignWithGoogleClicked(_ sender: Any) {
        presenter?.didSignWithGoogleClicked()
    }
}
