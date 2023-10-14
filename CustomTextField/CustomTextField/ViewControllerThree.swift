//
//  ViewControllerThree.swift
//  CustomTextField
//
//  Created by ihan carlos on 13/10/23.
//

import UIKit

class ViewControllerThree: UIViewController {
    
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
    
    lazy var customUsualyTextField: CustomTextFieldUsualy = {
        let textField = CustomTextFieldUsualy()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.title.text = "E-mail"
        return textField
    }()
    
    lazy var nextPageButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 24
        button.backgroundColor = .blue
        button.setTitle("Advance", for: .normal)
        button.titleLabel?.textColor = .white
        button.addTarget(self, action: #selector(tappedNextButton), for: .touchUpInside)
        return button
    }()
    
    @objc func tappedNextButton() {
        guard let email = customUsualyTextField.textField.text, !email.isEmpty else {
            customAlert(mensagem: "Please fill in all fields!")
            return
        }
        
        if !TextFieldValidator.validateText(for: .email, text: email) {
            customAlert(mensagem: "Incorrect email, please enter a valid email.")
            return
        }
        
        // Here is the rest of your code, such as navigation or communication with the API
        
        customAlert(mensagem: "Validation success!")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func customAlert(mensagem: String) {
        let alert = UIAlertController(title: "Login error", message: mensagem, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

extension ViewControllerThree: ViewCodeType {
    
    func buildViewHierarchy() {
        view.addSubview(backButton)
        view.addSubview(customUsualyTextField)
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
        
        customUsualyTextField.anchor(
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
