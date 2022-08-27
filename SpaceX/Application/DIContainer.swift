//
//  DIContainer.swift
//  Application
//
//  Created by Aleks Mutlu on 23.08.2022.
//

import Data
import Domain
import Presentation
import UIKit

///  Dependency Injection Container is responsible to contain long lived dependencies and factory methods.
final class DIContainer: MainCoordinatorDependencies {
    
    private lazy var remoteLaunchDataStore: RemoteLaunchDataStore = {
        GraphQLLaunchDataStore()
    }()
    
    // MARK: - Coordinator
    
    func makeMainCoordinator(navigationController: UINavigationController) -> MainCoordinator {
        let mainCoordinator = MainCoordinator(
            dependencies: self,
            navigationController: navigationController
        )
        return mainCoordinator
    }
    
    // MARK: - Repository
    
    func makeLaunchRepository() -> some LaunchRepository {
        let launchRepository = DefaultLaunchRepository(remoteLaunchDataStore: remoteLaunchDataStore)
        return launchRepository
    }
    
    // MARK: - Use Case
    
    func makeFetchCountriesUseCase() -> some FetchCountriesUseCase {
        let launchRepository = makeLaunchRepository()
        let fetchLaunchesUseCase = DefaultFetchCountriesUseCase(launchRepository: launchRepository)
        return fetchLaunchesUseCase
    }
    
    func makeFetchLaunchUseCase() -> some FetchCountryUseCase {
        let launchRepository = makeLaunchRepository()
        let fetchLaunchUseCase = DefaultFetchCountryUseCase(launchRepository: launchRepository)
        return fetchLaunchUseCase
    }
    
    func makeFetchContinentsUseCase() -> some FetchContinentsUseCase {
        let launchRepository = makeLaunchRepository()
        let fetchLaunchUseCase = DefaultFetchContinentsUseCase(launchRepository: launchRepository)
        return fetchLaunchUseCase
    }
    
    // MARK: - Home

    func makeHomeScene(
        onHomeActionTrigger: @escaping (HomeViewCoordinatorActions) -> Void
    ) -> HomeViewController {
        let homeViewModel = makeHomeViewModel(onHomeActionTrigger: onHomeActionTrigger)
        let homeViewController = HomeViewController(viewModel: homeViewModel)
        return homeViewController
    }
    
    private func makeHomeViewModel(
        onHomeActionTrigger: @escaping (HomeViewCoordinatorActions) -> Void
    ) -> some HomeViewModel {
        let fetchContinentsUseCase = makeFetchContinentsUseCase()
        let fetchCountriesUseCase = makeFetchCountriesUseCase()
        let homeViewModel = DefaultHomeViewModel(
            fetchContinentsUseCase: fetchContinentsUseCase,
            fetchCountriesUseCase: fetchCountriesUseCase,
            onCoordinatorActionTrigger: onHomeActionTrigger
        )
        return homeViewModel
    }
    
    // MARK: - Detail
    
    func makeDetailScene(for launch: Country) -> DetailViewController {
        let detailViewModel = makeDetailViewModel(launch: launch)
        let detailViewController = DetailViewController(viewModel: detailViewModel)
        return detailViewController
    }
    
    private func makeDetailViewModel(launch: Country) -> some DetailViewModel {
        let detailViewModel = DefaultDetailViewModel(
            fetchLaunchUseCase: makeFetchLaunchUseCase(),
            launch: launch
        )
        return detailViewModel
    }
}
