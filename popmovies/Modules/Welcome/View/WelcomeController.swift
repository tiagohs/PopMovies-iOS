//
//  WelcomeController.swift
//  popmovies
//
//  Created by Tiago Silva on 05/07/19.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//


import UIKit

// MARK: WelcomeController: BaseViewController

class WelcomeController: BaseViewController {
    
    // MARK: Outlets
    
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var loginFaceIDButton: UIButton!
    
    // MARK: Properties

    var presenter: WelcomePresenterInterface?
}

// MARK: Lifecycle Methods

extension WelcomeController {
    
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

// MARK: WelcomeViewInterface - Setup Methods

extension WelcomeController: WelcomeViewInterface {
    
    func setupUI() {
        registerButton.layer.borderColor = ViewUtils.UIColorFromHEX(hex: Constants.COLOR.colorPrimaryLight).cgColor
    }
    
}

extension WelcomeController {
    
    @IBAction func didLoginClicked(_ sender: Any) {
        presenter?.didLoginClicked()
    }
    
    @IBAction func didRegisterClicked(_ sender: Any) {
        presenter?.didRegisterClicked()
    }
    
    @IBAction func didLoginWithFaceIDClicked(_ sender: Any) {
        
    }
    
}
