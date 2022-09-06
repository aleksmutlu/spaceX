//
//  API+Extensions.swift
//  Data
//
//  Created by Aleks Mutlu on 23.08.2022.
//

import Domain
import Foundation

// MARK: - Continents

extension ContinentsQuery.Data {
    
    func toDomain() -> [Domain.Continent] {
        continents.map { $0.toDomain() }
    }
}

extension ContinentsQuery.Data.Continent {
    
    func toDomain() -> Domain.Continent {
        Domain.Continent(code: code, name: name)
    }
}

// MARK: - CountryDetails

extension CountryQuery.Data.Country {
    
    func toDomain() -> Domain.CountryDetails {
        Domain.CountryDetails(
            states: states.map { $0.name },
            languages: languages.compactMap { $0.name }
        )
    }
}

// MARK: - Countries

extension CountriesQuery.Data {
    
    func toDomain() -> [Domain.Country] {
        countries.map { $0.toDomain() }
    }
}

extension CountriesQuery.Data.Country {
    
    func toDomain() -> Domain.Country {
        Domain.Country(code: code, name: name, capital: capital, emoji: emoji, phone: phone)
    }
}

// MARK: - SearchCountries

extension SearchCountriesByCurrencyQuery.Data {
    
    func toDomain() -> [Domain.Country] {
        countries.map { $0.toDomain() }
    }
}

extension SearchCountriesByCurrencyQuery.Data.Country {
    
    func toDomain() -> Domain.Country {
        Domain.Country(code: code, name: name, capital: capital, emoji: emoji, phone: phone)
    }
}
