//
//  AppCoordinator.swift
//  Application
//
//  Created by Aleks Mutlu on 26.08.2022.
//

import Presentation
import UIKit

final class AppCoordinator: Coordinator {
    
    private let container: DIContainer
    private let navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []
    
    init(container: DIContainer, navigationController: UINavigationController) {
        self.container = container
        self.navigationController = navigationController
        super.init()
    }
    
    func start() {
        if true {
            runMainFlow()
        } else {
            // Run another flow if needed (authentication flow etc..)
        }
    }
    
    private func runMainFlow() {
        let mainCoordinator = container.makeMainCoordinator(
            navigationController: navigationController
        )
        mainCoordinator.start()
        addChild(mainCoordinator)
    }
}
