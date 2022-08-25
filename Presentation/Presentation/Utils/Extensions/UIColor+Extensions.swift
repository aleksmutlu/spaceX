//
//  UIColor+Extensions.swift
//  Presentation
//
//  Created by Aleks Mutlu on 24.08.2022.
//

import UIKit

extension UIColor {
    
    static func fromPresentationBundle(named: String) -> UIColor? {
        UIColor(named: named, in: .presentation, compatibleWith: nil)
    }
}
