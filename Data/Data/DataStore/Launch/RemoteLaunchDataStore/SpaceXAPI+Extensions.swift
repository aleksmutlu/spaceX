//
//  API+Extensions.swift
//  Data
//
//  Created by Aleks Mutlu on 23.08.2022.
//

import Domain
import Foundation

extension ContinentsQuery.Data {
    
    func toDomain() -> [Domain.Continent] {
        continents.map { $0.toDomain() }
    }
}

extension ContinentsQuery.Data.Continent {
    
    func toDomain() -> Domain.Continent {
        Domain.Continent(code: code, name: name, countries: countries.map { $0.toDomain() })
    }
}

extension ContinentsQuery.Data.Continent.Country {
    
    func toDomain() -> Domain.Country {
        Domain.Country(code: code, name: name, capital: capital, emoji: emoji, phone: phone)
    }
}

extension CountryQuery.Data.Country {
    
    func toDomain() -> Domain.CountryDetails {
        Domain.CountryDetails(
            states: states.map { $0.name },
            languages: languages.compactMap { $0.name }
        )
    }
}
