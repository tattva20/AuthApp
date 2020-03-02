//
//  FieldValidator.swift
//  AuthApp4
//
//  Created by Octavio Rojas on 3/1/20.
//  Copyright © 2020 Tattva. All rights reserved.
//

import Foundation

struct FieldValidator {

    func validateFieldString(_ string: String?) -> Bool {
        guard let stringToValidate = string else { return false }
        return hasEnoughLength(stringToValidate) && !isEmpty(stringToValidate)
    }

    func hasEnoughLength(_ string: String) -> Bool {
        return string.count >= 2
    }

    func isEmpty(_ string: String) -> Bool {
        return string.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    
}
