//
//  MainCoordinator.swift
//  Presentation
//
//  Created by Aleks Mutlu on 26.08.2022.
//

import Foundation
import UIKit

public protocol MainCoordinatorDependencies {
    func makeHomeScene() -> HomeViewController
}

public final class MainCoordinator: Coordinator {
    
    private let dependencies: MainCoordinatorDependencies
    private let navigationController: UINavigationController
    
    public init(
        dependencies: MainCoordinatorDependencies,
        navigationController: UINavigationController
    ) {
        self.dependencies = dependencies
        self.navigationController = navigationController
    }
    
    
    public func start() {
        showHome()
    }
    
    private func showHome() {
        let homeViewController = dependencies.makeHomeScene()
        navigationController.viewControllers = [homeViewController]
    }
}
