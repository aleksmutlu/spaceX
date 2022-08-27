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
    
    init(launch: Country) {
        name = launch.name
        capital = launch.capital
        flag = launch.emoji
        if let phone = launch.phone {
            self.phone = "+\(phone)"
        } else {
            self.phone = nil
        }
    }
}
