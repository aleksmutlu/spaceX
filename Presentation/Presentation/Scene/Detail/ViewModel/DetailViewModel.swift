//
//  DetailViewModel.swift
//  Presentation
//
//  Created by Aleks Mutlu on 23.08.2022.
//

import Domain
import Foundation
import RxCocoa
import RxSwift

public protocol DetailViewModel {
    var inputs: DetailViewModelInputs { get }
    var outputs: DetailViewModelOutputs { get }
}

public final class DefaultDetailViewModel: DetailViewModel {
    
    // MARK: - Properties
    
    public var inputs: DetailViewModelInputs { self }
    public var outputs: DetailViewModelOutputs { self }
    
    private let launch: Launch
    
    // MARK: - Life cycle
    
    public init(launch: Launch) {
        self.launch = launch
    }
}

// MARK: - DetailViewModelInputs

public protocol DetailViewModelInputs {
    func viewDidLoad()
}

extension DefaultDetailViewModel: DetailViewModelInputs {
    
    public func viewDidLoad() {
        
    }
}

// MARK: - DetailViewModelOutputs

public protocol DetailViewModelOutputs {
    var headerData: LaunchListItemViewModel { get }
}

extension DefaultDetailViewModel: DetailViewModelOutputs {
    
    public var headerData: LaunchListItemViewModel {
        LaunchListItemViewModel(launch: launch)
    }
}
