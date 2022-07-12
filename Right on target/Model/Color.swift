//
//  Color.swift
//  Right on target
//
//  Created by Zenya Kirilov on 16.05.22.
//

import UIKit

protocol ColorProtocol {
    // red channel
    var red: UInt8 { get set }
    // green channel
    var green: UInt8 { get set }
    // blue channel
    var blue: UInt8 { get set }
    // creating color using UIColor
    init(from: UIColor)
    // getting a color as a HEX-string
    func getByHexString() -> String
    // getting a color as a UIColor for showing on the scene
    func getByUIColor() -> UIColor
}

/* Struct will be used with generic SecretValue, in which type T must match the protocol Equatable. For this reason don't forget to indicate this protocol for structure 'Color' */
struct Color: ColorProtocol, Equatable {
    
    var red: UInt8
    var green: UInt8
    var blue: UInt8
    
    init() {
        red = 0
        green = 0
        blue = 0
    }
    
    init(from color: UIColor) {
        red = UInt8(CGFloat(255) * color.cgColor.components![0])
        green = UInt8(CGFloat(255) * color.cgColor.components![1])
        blue = UInt8(CGFloat(255) * color.cgColor.components![2])
    }
    
    func getByHexString() -> String {
        /* translate data about channels intencity in HEX system. For that use internal init in String, that gives an opportunity to change the count system of the number */
        var redPart = String(red, radix: 16, uppercase: true)
        if red <= 16 {
            redPart = "0\(redPart)"
        }
        var greenPart = String(green, radix: 16, uppercase: true)
        if green <= 16 {
            greenPart = "0\(greenPart)"
        }
        var bluePart = String(blue, radix: 16, uppercase: true)
        if blue <= 16 {
            bluePart = "0\(bluePart)"
        }
        
        return "\(redPart)\(greenPart)\(bluePart)"
    }
    
    func getByUIColor() -> UIColor {
        /* for creating a type UIColor for each of 3 channels we need to give values of the type CGFloat, where every value may vary in range from 0.0 to 1.0. For this reason we need to convert our values 0-256 to 0.0 - 1.0, where 0 is 0.0 and 255 is 1.0. */
        let redFloat = Float(red) / 255
        let greenFloat = Float(green) / 255
        let blueFloat = Float(blue) / 255
        return UIColor(red: CGFloat(redFloat), green: CGFloat(greenFloat), blue: CGFloat(blueFloat), alpha: 1)
    }
    
    // comparison method of 2 values of type Color
    static func == (lhs: Color, rhs: Color) -> Bool {
        return lhs.red == rhs.red &&
        lhs.green == rhs.green &&
        lhs.blue == rhs.blue
    }
}
