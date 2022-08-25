//
//  Theme.swift
//  Presentation
//
//  Created by Aleks Mutlu on 24.08.2022.
//

import UIKit

enum Theme {   
    static let dimmedBackgroundColor = UIColor.fromPresentationBundle(named: "DimmedBackground")
    static let highlightedBackgroundColor = UIColor.fromPresentationBundle(named: "HighlightedBackground")
    static let primaryText = UIColor.fromPresentationBundle(named: "PrimaryText")
    static let secondaryText = UIColor.fromPresentationBundle(named: "SecondaryText")
}
