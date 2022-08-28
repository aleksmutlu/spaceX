//
//  CountryDetails.swift
//  Domain
//
//  Created by Aleks Mutlu on 28.08.2022.
//

import Foundation

public struct CountryDetails {
    public let states: [String]
    public let languages: [String]
    
    public init(states: [String], languages: [String]) {
        self.states = states
        self.languages = languages
    }
}
