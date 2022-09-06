//
//  SearchCountriesUseCase.swift
//  Domain
//
//  Created by Aleks Mutlu on 5.09.2022.
//

import Foundation
import RxSwift

public protocol SearchCountriesUseCase {
    func execute(currencyCode: String) -> Single<[Country]>
}

public final class DefaultSearchCountriesUseCase: SearchCountriesUseCase {
    
    private let worldRepository: WorldRepository
    
    public init(worldRepository: WorldRepository) {
        self.worldRepository = worldRepository
    }
    
    public func execute(currencyCode: String) -> Single<[Country]> {
        worldRepository.searchCountries(by: currencyCode)
    }
}
