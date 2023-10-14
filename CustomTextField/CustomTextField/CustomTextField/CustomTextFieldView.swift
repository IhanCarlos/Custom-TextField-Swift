//
//  CustomTextFieldView.swift
//  CustomTextField
//
//  Created by ihan carlos on 23/06/23.
//

import UIKit

protocol CustomTextFieldViewDelegate: AnyObject {
    func customTextFieldViewDidUpdateText(_ textFieldView: CustomTextFieldView)
}

class CustomTextFieldView: UIView {

    weak var delegate: CustomTextFieldViewDelegate?
    var validatorRegex: TextFieldValidator.PatternValidatorRegex?
    var isValid: Bool {
        guard let text = textField.text, !text.isEmpty else {
            return false
        }

        guard let regex = validatorRegex else {
            return true
        }
        return TextFieldValidator.validateText(for: regex, text: text)
    }

    lazy var title: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14, weight: .bold)
        label.textColor = .black
        label.backgroundColor = .white
        return label
    }()

    lazy var containerTitleView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()

    lazy var borderView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.borderWidth = 3
        view.layer.borderColor = UIColor.orange.cgColor
        view.layer.cornerRadius = 18
        return view
    }()

    lazy var textField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    lazy var messageError: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 10, weight: .semibold)
        label.textColor = .red
        label.numberOfLines = 0
        label.textAlignment = .left
        label.isHidden = true
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupTextField()
        textField.delegate = self
        messageError.isHidden = true
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupTextField() {
        messageError.isHidden = true
        textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    }

    @objc private func textFieldDidChange(_ textField: UITextField) {
        guard let regex = validatorRegex, let text = textField.text else {
            return
        }

        let isValid = TextFieldValidator.validateText(for: regex, text: text)
        if text.isEmpty {
            messageError.isHidden = false
        } else if isValid {
            messageError.isHidden = true
        } else {
            messageError.isHidden = false
        }
        delegate?.customTextFieldViewDidUpdateText(self)
    }
}

extension CustomTextFieldView: ViewCodeType {

    func buildViewHierarchy() {
        addSubview(borderView)
        addSubview(containerTitleView)
        containerTitleView.addSubview(title)
        borderView.addSubview(textField)
        addSubview(messageError)
    }

    func setupConstraints() {
        title.anchor(
            left: containerTitleView.leftAnchor,
            centerY: containerTitleView.centerYAnchor,
            leftConstant: 4
        )

        containerTitleView.anchor(
            left: borderView.leftAnchor,
            right: title.rightAnchor,
            centerY: borderView.topAnchor,
            leftConstant: 24,
            rightConstant: -4,
            heightConstant: 16
        )

        borderView.anchor(
            top: topAnchor,
            left: leftAnchor,
            right: rightAnchor,
            heightConstant: 56
        )

        textField.anchor(
            left: borderView.leftAnchor,
            right: borderView.rightAnchor,
            centerY: borderView.centerYAnchor,
            leftConstant: 24,
            rightConstant: 24,
            heightConstant: 24
        )

        messageError.anchor(
            top: borderView.bottomAnchor,
            left: borderView.leftAnchor,
            right: borderView.rightAnchor,
            topConstant: 8,
            leftConstant: 16
        )
    }
}

extension CustomTextFieldView: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
