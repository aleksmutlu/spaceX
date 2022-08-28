//
//  RemoteLaunchDataStore.swift
//  Data
//
//  Created by Aleks Mutlu on 23.08.2022.
//

import Domain
import Foundation

public protocol RemoteCountryDataStore {
    func fetchCountries(by continentCode: String, onCompletion: @escaping (Result<[Country], Error>) -> Void)
    func fetchCountry(by code: String, onCompletion: @escaping (Result<CountryDetails, Error>) -> Void)
    func fetchContinents(onCompletion: @escaping (Result<[Continent], Error>) -> Void)
}
