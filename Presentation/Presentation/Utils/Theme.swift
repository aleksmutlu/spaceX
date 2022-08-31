//
//  Theme.swift
//  Presentation
//
//  Created by Aleks Mutlu on 24.08.2022.
//

import UIKit

enum Theme {
    enum Color {
        case mainBackground
        case contentBackground
        case primaryText
        case secondayText
        
        var asUIColor: UIColor! {
            switch self {
            case .mainBackground:
                return Theme.mainBackgroundColor
            case .contentBackground:
                return Theme.contentBackgroundColor
            case .primaryText:
                return Theme.primaryText
            case .secondayText:
                return Theme.secondaryText
            }
        }
    }
    
    
    
    static let mainBackgroundColor = UIColor.fromPresentationBundle(named: "MainBackground")
    static let contentBackgroundColor = UIColor.fromPresentationBundle(named: "ContentBackground")
    static let primaryText = UIColor.fromPresentationBundle(named: "PrimaryText")
    static let secondaryText = UIColor.fromPresentationBundle(named: "SecondaryText")
    
    static let containerCornerRadius: CGFloat = 16
}
