//
//  ViewController.swift
//  Ecommerce
//
//  Created by Hemang on 02/09/23.
//

import UIKit

class ViewController: UIViewController {

    //    MARK: - Outlets & Variable -
    
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var btnSubmit: UIButton!
    
    //    MARK: - View Life Cycle -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        self.hideNavigationBar()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    //    MARK: - Init -
    
    func setupUI() {
        self.view.applyGredientBG(colors: [UIColor.init(hexString: "#ffb73f"),UIColor.init(hexString: "#F2391A")], points: [.init(x: 0.0, y: 0.25), .init(x: 0.0, y: 0.75)], isCenter: true)
        self.txtEmail.delegate = self
        self.txtPassword.delegate = self
        self.setText()
        self.setFontColors()
        self.setFonts()
        
        self.btnSubmit.backgroundColor = ColorConstants.WhiteColor
        self.btnSubmit.layer.borderColor = ColorConstants.Primary_color!.cgColor
        self.btnSubmit.layer.borderWidth = 1
        self.btnSubmit.layer.cornerRadius = 4
        self.btnSubmit.alpha = 0.5
        self.txtEmail.layer.cornerRadius = 4
        self.txtPassword.layer.cornerRadius = 4
        
        self.txtEmail.setLeftPadding(paddingValue: 10)
        self.txtPassword.setLeftPadding(paddingValue: 10)
       
    }
    
    func setText() {
        self.btnSubmit.setTitle("Submit".uppercased(), for: .normal)
        self.txtEmail.placeholder = "Email"
        self.txtPassword.placeholder =  "Password"
    }
    
    func setFontColors() {
        self.btnSubmit.setTitleColor(ColorConstants.Primary_color, for: .normal)
        self.txtEmail.placeholderColors = ColorConstants.LightGrayColor
        self.txtPassword.placeholderColors = ColorConstants.LightGrayColor
        self.txtEmail.textColor = ColorConstants.BlackColor
        self.txtPassword.textColor = ColorConstants.BlackColor
    }

    func setFonts() {
        self.btnSubmit.titleLabel!.font = Fonts.sharedObject().getAppFontFont(family: .Bold, size: 20)
        self.txtEmail.font = Fonts.sharedObject().getAppFontFont(family: .Regular, size: 14)
        self.txtPassword.font = Fonts.sharedObject().getAppFontFont(family: .Regular, size: 14)
    }

    @IBAction func btnSubmitTapped(_ sender: Any) {
        if isVaildData() {
//            self.PostLoginAPI()
        }
    }
    
    //    MARK: - Validation -
    func isVaildData() -> Bool {
        if self.txtEmail.text?.trim().isEmpty == true {
            self.showToast(message: "Email cannot be blank.")
            return false
        }
        
        if self.txtEmail.text?.trim().isValidEmail() == false {
            self.showToast(message: "Please enter valid email.")
            return false
        }
        
        if self.txtPassword.text?.trim().isEmpty == true {
            self.showToast(message: "Password cannot be blank.")
            return false
        }
        return true
    }
    
}

extension ViewController : UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let userEmail = txtEmail.text?.trim()
        let userPassword = txtPassword.text?.trim()
        if userEmail!.count > 0 && userPassword!.count > 0 {
            self.btnSubmit.alpha = 1.0
        } else {
            self.btnSubmit.alpha = 0.5
        }
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        let userEmail = txtEmail.text?.trim()
        let userPassword = txtPassword.text?.trim()
        if userEmail!.count > 0 && userPassword!.count > 0{
            self.btnSubmit.alpha = 1.0
        } else {
            self.btnSubmit.alpha = 0.5
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Dismiss the keyboard
        textField.resignFirstResponder()
        return true
    }
    
}
