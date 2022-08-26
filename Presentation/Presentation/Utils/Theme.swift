//
//  Theme.swift
//  Presentation
//
//  Created by Aleks Mutlu on 24.08.2022.
//

import UIKit

enum Theme {   
    static let mainBackgroundColor = UIColor.fromPresentationBundle(named: "MainBackground")
    static let contentBackgroundColor = UIColor.fromPresentationBundle(named: "ContentBackground")
    static let primaryText = UIColor.fromPresentationBundle(named: "PrimaryText")
    static let secondaryText = UIColor.fromPresentationBundle(named: "SecondaryText")
}
