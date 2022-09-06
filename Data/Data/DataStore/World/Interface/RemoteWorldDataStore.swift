//
//  RemoteCountryDataStore.swift
//  Data
//
//  Created by Aleks Mutlu on 23.08.2022.
//

import Domain
import Foundation
import RxSwift

public protocol RemoteWorldDataStore {
    func fetchCountries(by continentCode: String, onCompletion: @escaping (Result<[Country], Error>) -> Void)
    func searchCountries(by currencyCode: String) -> Single<[Country]>
    func fetchCountry(by code: String, onCompletion: @escaping (Result<CountryDetails, Error>) -> Void)
    func fetchContinents(onCompletion: @escaping (Result<[Continent], Error>) -> Void)
}
