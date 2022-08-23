//
//  DIContainer.swift
//  Application
//
//  Created by Aleks Mutlu on 23.08.2022.
//

import Data
import Domain
import Presentation

final class DIContainer {
    
    private lazy var remoteLaunchDataStore: LaunchDataStore = RemoteLaunchDataStore()
    
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
