//
//  GameFactory.swift
//  Right on target
//
//  Created by Zenya Kirilov on 17.05.22.
//

import Foundation

/* Class game factory was created using 'Abstract Factory' pattern. It used as a common point for creating instances of the class 'Game' for using in this program. */

final class GameFactory {
    
    static func getNumericGame() -> some GameProtocol {
        let minSecretValue = 1
        let maxSecretValue = 50
        let secretValue = SecretNumericValue(initialValue: 0) { _ in
            // closure for choosing a secret value
            return Array(minSecretValue...maxSecretValue).randomElement()!
        }
        return Game<SecretNumericValue>(secretValue: secretValue, rounds: 5) { secretValue, userValue in
            var compareResult: Int!
            if secretValue.value == userValue.value {
                compareResult = maxSecretValue
            } else if secretValue.value > userValue.value {
                compareResult = maxSecretValue - (secretValue.value - userValue.value)
            } else if secretValue.value < userValue.value {
                compareResult = maxSecretValue - (userValue.value - secretValue.value)
            }
            return compareResult
        }
    }
    
    static func getColorGame() -> some GameProtocol {
        let initialSecretColor = Color()
        let secretValue = SecretColorValue(initialValue: initialSecretColor) { color in
            var updateColor = color
            updateColor.red = Array(0...255).randomElement()!
            updateColor.green = Array(0...255).randomElement()!
            updateColor.blue = Array(0...255).randomElement()!
            return updateColor
        }
        return Game<SecretColorValue>(secretValue: secretValue, rounds: 5) { secretValue, userValue in
            if secretValue.value == userValue.value {
                return 1
            } else {
                return 0
            }
        }
    }
}
