//
//  CountryListItemViewModel.swift
//  Presentation
//
//  Created by Aleks Mutlu on 23.08.2022.
//

import Domain
import Foundation

public struct CountryListItemViewModel: Hashable {
    public let name: String
    public let capital: String?
    public let flag: String?
    public let phone: String?
}

extension CountryListItemViewModel {
    
    init(country: Country) {
        name = country.name
        capital = country.capital
        flag = country.emoji
        if let phone = country.phone {
            self.phone = "+\(phone)"
        } else {
            self.phone = nil
        }
    }
}
