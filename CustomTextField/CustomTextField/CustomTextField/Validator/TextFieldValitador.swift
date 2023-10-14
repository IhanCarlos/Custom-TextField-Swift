//
//  TextFieldValitador.swift
//  UberHub
//
//  Created by ihan carlos on 29/06/23.
//

import Foundation

class TextFieldValidator {

    enum PatternValidatorRegex: String {
        case email = "(^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}$)"
        case password = "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{8,}$"
        case name = "^[A-Za-z]+( [A-Za-z]+)*$"
        case numeric = "(^[0-9]*$)"
        case phone = "(^[0-9+]*$)"
        case decimal = "(^[0-9]*,?([0-9]{1,2})?$)"
        case decimalReal = "(^-?[0-9]*,?([0-9]{1,2})?$)"
        case date = "^\\d{4}-\\d{2}-\\d{2}$"
    }

    static func validateText(for regex: PatternValidatorRegex, text: String) -> Bool {
        let predicate = NSPredicate(format: "SELF MATCHES %@", regex.rawValue)
        return predicate.evaluate(with: text)
    }
}
