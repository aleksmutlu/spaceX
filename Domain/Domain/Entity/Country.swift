//
//  Country.swift
//  Domain
//
//  Created by Aleks Mutlu on 28.08.2022.
//

import Foundation

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
