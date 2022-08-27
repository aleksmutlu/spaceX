//
//  LaunchRepository.swift
//  Domain
//
//  Created by Aleks Mutlu on 23.08.2022.
//

import Foundation

public protocol LaunchRepository {
    func fetchContinents(onCompletion: @escaping (Result<[Continent], Error>) -> Void)
    func fetchLaunches(onCompletion: @escaping (Result<[Country], Error>) -> Void)
    func fetchCountry(by code: String, onCompletion: @escaping (Result<CountryDetails, Error>) -> Void)
}
