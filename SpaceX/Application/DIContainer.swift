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
    
    private lazy var remoteLaunchDataStore: RemoteLaunchDataStore = DummyLaunchDataStore() //GraphQLLaunchDataStore()
    
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
    
    func makeFetchLaunchesUseCase() -> some FetchLaunchesUseCase {
        let launchRepository = makeLaunchRepository()
        let fetchLaunchesUseCase = DefaultFetchLaunchesUseCase(launchRepository: launchRepository)
        return fetchLaunchesUseCase
    }
    
    // MARK: - Home

    func makeHomeScene() -> HomeViewController {
        let homeViewModel = makeHomeViewModel()
        let homeViewController = HomeViewController(viewModel: homeViewModel)
        return homeViewController
    }
    
    private func makeHomeViewModel() -> some HomeViewModel {
        let fetchLaunchesUseCase = makeFetchLaunchesUseCase()
        let homeViewModel = DefaultHomeViewModel(fetchLaunchesUseCase: fetchLaunchesUseCase)
        return homeViewModel
    }
    
    // MARK: - Detail
    
    func makeDetailScene() -> DetailViewController {
        let detailViewModel = makeDetailViewModel()
        let detailViewController = DetailViewController(viewModel: detailViewModel)
        return detailViewController
    }
    
    private func makeDetailViewModel() -> some DetailViewModel {
        let detailViewModel = DefaultDetailViewModel()
        return detailViewModel
    }
}
