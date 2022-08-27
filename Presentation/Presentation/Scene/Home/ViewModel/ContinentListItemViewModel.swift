//
//  ContinentListItemViewModel.swift
//  Presentation
//
//  Created by Aleks Mutlu on 27.08.2022.
//

import Domain
import Foundation

public struct ContinentListItemViewModel: Hashable {
    let title: String
    let countryListItems: [CountryListItemViewModel]
}

extension ContinentListItemViewModel {
    
    init(continent: Continent) {
        title = continent.name
        countryListItems = continent.countries.map(CountryListItemViewModel.init)
    }
}
