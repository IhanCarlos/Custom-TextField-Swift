//
//  CustomTextFieldUsualy.swift
//  ifound
//
//  Created by ihan carlos on 03/10/23.
//

import UIKit

class CustomTextFieldUsualy: UIView {
    
    lazy var title: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        label.textColor = .black
        return label
    }()
    
    lazy var borderView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.layer.cornerRadius = 8
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.black.cgColor
        return view
    }()

    lazy var textField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.textColor = .black
        return textField
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CustomTextFieldUsualy: ViewCodeType {
    func buildViewHierarchy() {
        addSubview(title)
        addSubview(borderView)
        borderView.addSubview(textField)
    }
    
    func setupConstraints() {
        title.anchor(
            top: topAnchor,
            left: leftAnchor
        )
        
        borderView.anchor(
            top: title.bottomAnchor,
            left: leftAnchor,
            right: rightAnchor,
            topConstant: 8,
            heightConstant: 50
        )

        textField.anchor(
            top: borderView.bottomAnchor,
            left: borderView.leftAnchor,
            right: borderView.rightAnchor,
            centerY: borderView.centerYAnchor,
            topConstant: 8,
            leftConstant: 20,
            rightConstant: 5,
            heightConstant: 20
        )
    }
}
