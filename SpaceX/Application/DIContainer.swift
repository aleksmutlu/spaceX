//
//  DIContainer.swift
//  Application
//
//  Created by Aleks Mutlu on 23.08.2022.
//

import Domain
import Presentation

final class DIContainer {
    
    
    // MARK: - Repository
    
    func makeLaunchRepository() -> LaunchRepository {
        // TODO:
        fatalError()
    }
    
    // MARK: - Use Case
    
    func makeFetchLaunchesUseCase() -> some FetchLaunchesUseCase {
        let launchRepository = makeLaunchRepository()
        let fetchLaunchesUseCase = DefaultFetchLaunchesUseCase(launchRepository: launchRepository)
        return fetchLaunchesUseCase
    }
    
    // MARK: - Home

    func makeHomeScene() -> HomeViewController {
        let launchRepository = makeLaunchRepository()
        let homeViewModel = makeHomeViewModel(launchRepository: launchRepository)
        let homeViewController = HomeViewController(viewModel: homeViewModel)
        return homeViewController
    }
    
    private func makeHomeViewModel(launchRepository: LaunchRepository) -> some HomeViewModel {
        let homeViewModel = DefaultHomeViewModel(launchRepository: launchRepository)
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
