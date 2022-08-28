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
    
    private lazy var remoteCountryDataStore: RemoteWorldDataStore = {
        GraphQLWorldDataStore()
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
    
    func makeWorldRepository() -> some WorldRepository {
        let worldRepository = DefaultWorldRepository(remoteWorldDataStore: remoteCountryDataStore)
        return worldRepository
    }
    
    // MARK: - Use Case
    
    func makeFetchCountriesUseCase() -> some FetchCountriesUseCase {
        let worldRepository = makeWorldRepository()
        let fetchCountriesUseCase = DefaultFetchCountriesUseCase(worldRepository: worldRepository)
        return fetchCountriesUseCase
    }
    
    func makeFetchCountryUseCase() -> some FetchCountryUseCase {
        let worldRepository = makeWorldRepository()
        let fetchCountryUseCase = DefaultFetchCountryUseCase(worldRepository: worldRepository)
        return fetchCountryUseCase
    }
    
    func makeFetchContinentsUseCase() -> some FetchContinentsUseCase {
        let worldRepository = makeWorldRepository()
        let fetchContinentsUseCase = DefaultFetchContinentsUseCase(worldRepository: worldRepository)
        return fetchContinentsUseCase
    }
    
    // MARK: - Home

    func makeHomeScene(
        onHomeActionTrigger: @escaping (HomeSceneCoordinatorActions) -> Void
    ) -> HomeViewController {
        let homeViewModel = makeHomeViewModel(onHomeActionTrigger: onHomeActionTrigger)
        let homeViewController = HomeViewController(viewModel: homeViewModel)
        return homeViewController
    }
    
    private func makeHomeViewModel(
        onHomeActionTrigger: @escaping (HomeSceneCoordinatorActions) -> Void
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
    
    func makeDetailScene(for country: Country) -> DetailViewController {
        let detailViewModel = makeDetailViewModel(country: country)
        let detailViewController = DetailViewController(viewModel: detailViewModel)
        return detailViewController
    }
    
    private func makeDetailViewModel(country: Country) -> some DetailViewModel {
        let detailViewModel = DefaultDetailViewModel(
            fetchCountryUseCase: makeFetchCountryUseCase(),
            country: country
        )
        return detailViewModel
    }
}
