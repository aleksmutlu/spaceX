//
//  CountryListItemViewModel.swift
//  Presentation
//
//  Created by Aleks Mutlu on 23.08.2022.
//

import Domain
import Foundation
import RxSwift
import RxRelay

public struct CountryListItemViewModel: Hashable {
    
    public static func == (lhs: CountryListItemViewModel, rhs: CountryListItemViewModel) -> Bool {
        lhs.name == rhs.name &&
        lhs.capital == rhs.capital &&
        lhs.flag == rhs.flag &&
        lhs.phone == rhs.phone
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(name)
        hasher.combine(capital)
        hasher.combine(flag)
        hasher.combine(phone)
    }
    
    public let name: String
    public let capital: String?
    public let flag: String?
    public let phone: String?
    public let temperature: BehaviorRelay<Int>
    private let disposeBag = DisposeBag()
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
        temperature = country.temperature
    }
}
