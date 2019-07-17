//
//  RegisterController.swift
//  popmovies
//
//  Created by Tiago Silva on 05/07/19.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//


import UIKit

// MARK: RegisterController: BaseViewController

class RegisterController: BaseViewController {
    
    // MARK: Outlets
    
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    
    // MARK: Properties

    var presenter: RegisterPresenterInterface?
}

// MARK: Lifecycle Methods

extension RegisterController {
    
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

// MARK: RegisterViewInterface - Setup Methods

extension RegisterController: RegisterViewInterface {
    
    func setupUI() {
        backButton.layer.cornerRadius = backButton.bounds.width / 2
        backButton.imageView?.setImageColorBy(uiColor: UIColor.white)
    }
    
}

extension RegisterController {
    
    @IBAction func didRegisterClicked(_ sender: Any) {
        self.presenter?.didRegisterClicked(nameTextField.text, emailTextField.text, passwordTextField.text, confirmPasswordTextField.text)
    }
    
}
