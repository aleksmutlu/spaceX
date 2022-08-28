//
//  CountryRepository.swift
//  Domain
//
//  Created by Aleks Mutlu on 23.08.2022.
//

import Foundation

public protocol CountryRepository { // TODO: Rename to World Repo
    func fetchContinents(onCompletion: @escaping (Result<[Continent], Error>) -> Void) // TODO: Move to another repo?
    func fetchCountries(
        by continentCode: String,
        onCompletion: @escaping (Result<[Country], Error>) -> Void
    )
    func fetchCountry(
        by code: String,
        onCompletion: @escaping (Result<CountryDetails, Error>) -> Void
    )
}
