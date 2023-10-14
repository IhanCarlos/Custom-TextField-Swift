//
//  CustomTextFieldUsualy.swift
//  CustomTextField
//
//  Created by ihan carlos on 07/10/23.
//

import UIKit

protocol CustomTextFieldLineDelegate: AnyObject {
    func customTextFieldLineDidUpdateText(_ textFieldView: CustomTextFieldLine)
}

class CustomTextFieldLine: UIView {
    
    weak var delegate: CustomTextFieldLineDelegate?
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
        return label
    }()

    lazy var textField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    lazy var lineView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .lightGray
        return view
    }()

    lazy var iconCheck: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
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
        textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    }

    @objc private func textFieldDidChange(_ textField: UITextField) {
        guard let regex = validatorRegex, let text = textField.text else {
            return
        }

        let isValid = TextFieldValidator.validateText(for: regex, text: text)
        if text.isEmpty {
            messageError.isHidden = false
            self.iconCheck.image = UIImage(systemName: "x.circle.fill")
            self.iconCheck.tintColor = .red
        } else if isValid {
            messageError.isHidden = true
            self.iconCheck.image = UIImage(systemName: "checkmark.circle.fill")
            self.iconCheck.tintColor = .blue
        } else {
            messageError.isHidden = false
            self.iconCheck.image = UIImage(systemName: "x.circle.fill")
            self.iconCheck.tintColor = .red
        }
        delegate?.customTextFieldLineDidUpdateText(self)
    }
}

extension CustomTextFieldLine: ViewCodeType {
    func buildViewHierarchy() {
        addSubview(title)
        addSubview(textField)
        addSubview(lineView)
        addSubview(iconCheck)
        addSubview(messageError)
    }

    func setupConstraints() {
        title.anchor(
            top: topAnchor,
            left: leftAnchor
        )

        textField.anchor(
            top: title.bottomAnchor,
            left: title.leftAnchor,
            right: rightAnchor,
            topConstant: 4,
            heightConstant: 32
        )

        iconCheck.anchor(
            right: rightAnchor,
            centerY: textField.centerYAnchor,
            rightConstant: 24,
            widthConstant: 24,
            heightConstant: 24
        )

        lineView.anchor(
            top: textField.bottomAnchor,
            left: textField.leftAnchor,
            right: textField.rightAnchor,
            topConstant: 4,
            heightConstant: 2
        )
        
        messageError.anchor(
            top: lineView.bottomAnchor,
            left: lineView.leftAnchor,
            right: lineView.rightAnchor,
            topConstant: 8,
            leftConstant: 4
        )
    }
}

extension CustomTextFieldLine: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

