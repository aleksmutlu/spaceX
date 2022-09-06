//
//  DIContainer.swift
//  Application
//
//  Created by Aleks Mutlu on 23.08.2022.
//

import Apollo
import Data
import Domain
import Presentation
import SwiftUI
import UIKit

///  Dependency Injection Container is responsible to contain long lived dependencies and factory methods.
final class DIContainer: MainCoordinatorDependencies {
    
    private let appConfiguration = AppConfiguration()
    
    private lazy var remoteCountryDataStore: some RemoteWorldDataStore = {
        GraphQLWorldDataStore(apollo: ApolloClient(url: appConfiguration.apiURL))
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
    
    func makeSearchCountriesUseCase() -> some SearchCountriesUseCase {
        let worldRepository = makeWorldRepository()
        let searchCountriesUseCase = DefaultSearchCountriesUseCase(worldRepository: worldRepository)
        return searchCountriesUseCase
    }
    
    // MARK: - Home

    func makeHomeScene(
        onHomeActionTrigger: @escaping (HomeSceneCoordinatorActions) -> Void
    ) -> UIViewController {
        switch appConfiguration.activeUIFramework {
        case .uiKit:
            let homeViewModel = makeHomeViewModel(onHomeActionTrigger: onHomeActionTrigger)
            let homeViewController = HomeViewController(viewModel: homeViewModel)
            return homeViewController
        case .swfitUI:
            let homeViewModelWrapper = makeHomeViewModelWrapper(
                onHomeActionTrigger: onHomeActionTrigger
            )
            let homeView = HomeSwiftUIView(viewModel: homeViewModelWrapper)
            let hostingController = UIHostingController(rootView: homeView)
            return hostingController
        }
        
    }
    
    private func makeHomeViewModel(
        onHomeActionTrigger: @escaping (HomeSceneCoordinatorActions) -> Void
    ) -> some HomeViewModel {
        let fetchContinentsUseCase = makeFetchContinentsUseCase()
        let fetchCountriesUseCase = makeFetchCountriesUseCase()
        let searchCountriesUseCase = makeSearchCountriesUseCase()
        let homeViewModel = DefaultHomeViewModel(
            fetchContinentsUseCase: fetchContinentsUseCase,
            fetchCountriesUseCase: fetchCountriesUseCase,
            searchCountriesUseCase: searchCountriesUseCase,
            onCoordinatorActionTrigger: onHomeActionTrigger
        )
        return homeViewModel
    }
    
    private func makeHomeViewModelWrapper(
        onHomeActionTrigger: @escaping (HomeSceneCoordinatorActions) -> Void
    ) -> HomeViewModelWrapper {
        let viewModel = makeHomeViewModel(onHomeActionTrigger: onHomeActionTrigger)
        let wrapper = HomeViewModelWrapper(viewModel: viewModel)
        return wrapper
    }
    
    // MARK: - Detail
    
    func makeDetailScene(for country: Country) -> UIViewController {
        switch appConfiguration.activeUIFramework {
        case .uiKit:
            let detailViewModel = makeDetailViewModel(country: country)
            let detailViewController = DetailViewController(viewModel: detailViewModel)
            return detailViewController
        case .swfitUI:
            let wrapperDetailViewModel = makeDetailViewModelWrapper(country: country)
            let detailView = DetailSwiftUIView(viewModel: wrapperDetailViewModel)
            let hostingController = UIHostingController(rootView: detailView)
            return hostingController
        }
    }
    
    private func makeDetailViewModel(country: Country) -> some DetailViewModel {
        let detailViewModel = DefaultDetailViewModel(
            fetchCountryUseCase: makeFetchCountryUseCase(),
            country: country
        )
        return detailViewModel
    }
    
    private func makeDetailViewModelWrapper(country: Country) -> DetailViewModelWrapper {
        let viewModel = makeDetailViewModel(country: country)
        let wrapper = DetailViewModelWrapper(viewModel: viewModel)
        return wrapper
    }
}
