//
//  WorldRepository.swift
//  Domain
//
//  Created by Aleks Mutlu on 23.08.2022.
//

import Foundation
import RxSwift

public protocol WorldRepository {
    func fetchContinents(onCompletion: @escaping (Result<[Continent], Error>) -> Void) 
    func fetchCountries(
        by continentCode: String,
        onCompletion: @escaping (Result<[Country], Error>) -> Void
    )
    func searchCountries(by currencyCode: String) -> Single<[Country]>
    func fetchCountry(
        by code: String,
        onCompletion: @escaping (Result<CountryDetails, Error>) -> Void
    )
}
