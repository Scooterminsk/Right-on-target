//
//  SecretValue.swift
//  Right on target
//
//  Created by Zenya Kirilov on 16.05.22.
//

import Foundation

// alias for secret numeric value
typealias SecretNumericValue = SecretValue<Int>
// alias for secret color value, we use custom type Color
typealias SecretColorValue = SecretValue<Color>

// protocol that will be used for creating a type, that describe entity 'Secret value'
protocol SecretValueProtocol {
    // associated type that will check the type of the value
    associatedtype ValueType
    // secret value
    var value: ValueType { get }
    // changes current value on random value
    mutating func setRandomValue()
}

struct SecretValue<T: Equatable>: SecretValueProtocol {
    typealias ValueType = T
    var value: T
    // closure for choosing a random value
    private let randomValueClosure: (T) -> T
    init(initialValue: T, randomValueClosure: @escaping (T) -> T) {
        value = initialValue
        self.randomValueClosure = randomValueClosure
    }
    mutating func setRandomValue() {
        self.value = randomValueClosure(self.value)
    }
}
