//
//  UIView+Extensions.swift
//  Presentation
//
//  Created by Aleks Mutlu on 26.08.2022.
//

import UIKit

extension UIView {
    
    func fadeIn(in duration: TimeInterval = 0.3) {
        alpha = 0
        UIView.animate(withDuration: duration) {
            self.alpha = 1
        }
    }
    
    var globalPoint :CGPoint? {
        return superview?.convert(frame.origin, to: nil)
    }
    
    var globalFrame :CGRect? {
        return superview?.convert(frame, to: nil)
    }
}
