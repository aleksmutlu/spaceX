//
//  Coordinator.swift
//  Presentation
//
//  Created by Aleks Mutlu on 26.08.2022.
//

import UIKit

open class Coordinator {
    
    var childCoordinators: [Coordinator] = []
    
    public init() {
        
    }
    
    public func addChild(_ coordinator: Coordinator) {
        childCoordinators.append(coordinator)
    }
    
    public func removeChild(_ coordinator: Coordinator) {
        for (index, coo) in childCoordinators.enumerated() {
            if coo === coordinator {
                childCoordinators.remove(at: index)
                return
            }
        }
    }
}

