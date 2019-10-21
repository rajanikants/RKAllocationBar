//
//  Color.swift
//  RKProgressBar
//
//  Created by Rajanikant shukla on 10/21/19.
//  Copyright © 2019 Rajanikant shukla. All rights reserved.
//

import UIKit

private let normalizedColor = { (value: UInt8) -> CGFloat in
    CGFloat(value) / 255.0
}


// MARK: - chart colors.
extension UIColor {
    
    static var charColors = [
        progressColor1, progressColor2,
        progressColor3, progressColor4,
        progressColor5, progressColor6,
        progressColor7, progressColor8,
        progressColor9, progressColor10,
        ]
    
    public static let progressColor1 = UIColor(UInt8ColorWithRed: 148, green: 81, blue: 224)
    public static let progressColor2 = UIColor(UInt8ColorWithRed: 230, green: 107, blue: 0)
    public static let progressColor3 = UIColor(UInt8ColorWithRed: 88, green: 80, blue: 224)
    public static let progressColor4 = UIColor(UInt8ColorWithRed: 78, green: 156, blue: 45)
    public static let progressColor5 = UIColor(UInt8ColorWithRed: 16, green: 136, blue: 239)
    public static let progressColor6 = UIColor(UInt8ColorWithRed: 0, green: 166, blue: 157)
    public static let progressColor7 = UIColor(UInt8ColorWithRed: 86, green: 53, blue: 148)
    public static let progressColor8 = UIColor(UInt8ColorWithRed: 191, green: 89, blue: 0)
    public static let progressColor9 = UIColor(UInt8ColorWithRed: 59, green: 117, blue: 34)
    public static let progressColor10 = UIColor(UInt8ColorWithRed: 13, green: 107, blue: 189)
}

extension UIColor {
    public var toHexColor: String {
        return convertToHexColor()
    }
    
    func convertToHexColor() -> String {
        guard let colorComponents = cgColor.components else {
            return ""
        }
        
        let r = Float(colorComponents[0])
        let g = Float(colorComponents[1])
        let b = Float(colorComponents[2])
        
        return String(format: "#%02lX%02lX%02lX", lroundf(r * 255), lroundf(g * 255), lroundf(b * 255))
    }
    
    public convenience init(UInt8ColorWithRed red: UInt8, green: UInt8, blue: UInt8, alpha: CGFloat = 1) {
        self.init(red: normalizedColor(red), green: normalizedColor(green), blue: normalizedColor(blue), alpha: alpha)
    }
    
    public convenience init(stringColor: String) {
        let arr = stringColor.components(separatedBy: ",")
        if arr.count > 2 {
            self.init(UInt8ColorWithRed: UInt8(arr[0]) ?? 0, green: UInt8(arr[1]) ?? 0, blue: UInt8(arr[1]) ?? 0)
        } else {
            self.init(white: 0.7, alpha: 1.0)
        }
    }
}

extension CGFloat {
    static func random() -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }
}

extension UIColor {
    static func random() -> UIColor {
        return UIColor(red: .random(),
                       green: .random(),
                       blue: .random(),
                       alpha: 1.0)
    }
}

