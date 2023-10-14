//
//  ViewControllerTwo.swift
//  CustomTextField
//
//  Created by ihan carlos on 13/10/23.
//

import UIKit

class ViewControllerTwo: UIViewController, CustomTextFieldLineDelegate {
    
    lazy var backButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "arrow.backward.circle.fill"), for: .normal)
        button.contentMode = .scaleToFill
        button.addTarget(self, action: #selector(tappedBackButton), for: .touchUpInside)
        return button
    }()
    
    @objc func tappedBackButton() {
        navigationController?.popViewController(animated: true)
    }
    
    lazy var passwordTextField: CustomTextFieldLine = {
        let textField = CustomTextFieldLine()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.title.text = "Password"
        textField.messageError.text = "invalid password, the password must contain at least 8 characters containing letters and numbers"
        textField.delegate = self
        textField.validatorRegex = .password
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
        let vc = ViewControllerThree()
        navigationController?.pushViewController(vc, animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        configButtonEnable(enable: false)
    }
    
    //MARK: Validation only for the password in the line textField!
    
    func customTextFieldLineDidUpdateText(_ textFieldView: CustomTextFieldLine) {
        let isValid = validatePasswordFields()
        configButtonEnable(enable: isValid)
    }
    
    func validatePasswordFields() -> Bool {
        let passwordIsValid = passwordTextField.isValid
        return passwordIsValid
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

extension ViewControllerTwo: ViewCodeType {
    
    func buildViewHierarchy() {
        view.addSubview(backButton)
        view.addSubview(passwordTextField)
        view.addSubview(nextPageButton)
    }
    
    func setupConstraints() {
        backButton.anchor(
            top: view.safeAreaLayoutGuide.topAnchor,
            left: view.leftAnchor,
            topConstant: 10,
            leftConstant: 10,
            widthConstant: 50,
            heightConstant: 50
        )
        
        passwordTextField.anchor(
            top: backButton.bottomAnchor,
            left: view.leftAnchor,
            right: view.rightAnchor,
            topConstant: 20,
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
