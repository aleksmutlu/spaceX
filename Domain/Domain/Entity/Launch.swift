//
//  Launch.swift
//  Domain
//
//  Created by Aleks Mutlu on 23.08.2022.
//

import Foundation

public struct Continent {
    public let code: String
    public let name: String
    public let countries: [Country]
    
    public init(code: String, name: String, countries: [Country]) {
        self.code = code
        self.name = name
        self.countries = countries
    }
}

public struct Country {
    public let code: String
    public let name: String
    public let capital: String?
    public let emoji: String?
    public let phone: String?
    
    public init(code: String, name: String, capital: String?, emoji: String?, phone: String?) {
        self.code = code
        self.name = name
        self.capital = capital
        self.emoji = emoji
        self.phone = phone
    }
}

public struct CountryDetails {
    public let states: [String]
    public let languages: [String]
    
    public init(states: [String], languages: [String]) {
        self.states = states
        self.languages = languages
    }
}
