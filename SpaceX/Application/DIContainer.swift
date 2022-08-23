//
//  DIContainer.swift
//  Application
//
//  Created by Aleks Mutlu on 23.08.2022.
//

import Presentation

final class DIContainer {
    
    
    // MARK: - Home

    func makeHomeScene() -> HomeViewController {
        let homeViewModel = makeHomeViewModel()
        let homeViewController = HomeViewController(viewModel: homeViewModel)
        return homeViewController
    }
    
    private func makeHomeViewModel() -> some HomeViewModel {
        let homeViewModel = DefaultHomeViewModel()
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
