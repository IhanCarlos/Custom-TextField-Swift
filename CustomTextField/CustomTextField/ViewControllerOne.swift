//
//  ViewController.swift
//  CustomTextField
//
//  Created by ihan carlos on 13/10/23.
//

import UIKit

class ViewControllerOne: UIViewController, CustomTextFieldViewDelegate {

    lazy var emailTextField: CustomTextFieldView = {
        let textField = CustomTextFieldView()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.title.text = "E-mail"
        textField.messageError.text = "invalid email"
        textField.delegate = self
        textField.validatorRegex = .email
        return textField
    }()
    
    lazy var nextPageButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 24
        button.setTitle("Advance", for: .normal)
        button.addTarget(self, action: #selector(tappedNextButton), for: .touchUpInside)
        return button
    }()
    
    @objc func tappedNextButton() {
        let vc = ViewControllerTwo()
        navigationController?.pushViewController(vc, animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        configButtonEnable(enable: false)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    //MARK: Validation only for email in Edge textField!
    
    func customTextFieldViewDidUpdateText(_ textFieldView: CustomTextFieldView) {
        let isValid = validateEmailFields()
        configButtonEnable(enable: isValid)
    }
    
    func validateEmailFields() -> Bool {
        let emailIsValid = emailTextField.isValid
        return emailIsValid
    }
    
    private func configButtonEnable(enable: Bool) {
        nextPageButton.isEnabled = enable
        if enable {
            nextPageButton.setTitleColor(.white, for: .normal)
            nextPageButton.backgroundColor = .blue
        } else {
            nextPageButton.setTitleColor(.gray, for: .normal)
            nextPageButton.backgroundColor = .lightGray
        }
    }
}

extension ViewControllerOne: ViewCodeType {
    
    func buildViewHierarchy() {
        view.addSubview(emailTextField)
        view.addSubview(nextPageButton)
    }
    
    func setupConstraints() {
        emailTextField.anchor(
            top: view.safeAreaLayoutGuide.topAnchor,
            left: view.leftAnchor,
            right: view.rightAnchor,
            topConstant: 50,
            leftConstant: 20,
            rightConstant: 20,
            heightConstant: 70
        )
        
        nextPageButton.anchor(
            left: view.leftAnchor,
            bottom: view.safeAreaLayoutGuide.bottomAnchor,
            right: view.rightAnchor,
            leftConstant: 20,
            bottomConstant: 10,
            rightConstant: 20,
            heightConstant: 50
        )
    }
    
    func setupAdditionalConfiguration() {
        view.backgroundColor = .white
    }
}

