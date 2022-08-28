//
//  MainCoordinator.swift
//  Presentation
//
//  Created by Aleks Mutlu on 26.08.2022.
//

import Domain
import Foundation
import UIKit

public protocol MainCoordinatorDependencies {
    func makeHomeScene(
        onHomeActionTrigger: @escaping (HomeViewCoordinatorActions) -> Void
    ) -> HomeViewController
    
    func makeDetailScene(for country: Country) -> DetailViewController
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
        let homeViewController = dependencies.makeHomeScene { [weak self] action in
            switch action {
            case .select(let launch):
                self?.showDetail(of: launch)
            }
        }
        navigationController.viewControllers = [homeViewController]
    }
    
    private func showDetail(of country: Country) {
        let detailViewController = dependencies.makeDetailScene(for: country)
        navigationController.present(detailViewController, animated: true)
    }
}
