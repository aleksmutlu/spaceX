//
//  Country+Stub.swift
//  PresentationTests
//
//  Created by Aleks Mutlu on 28.08.2022.
//

import Domain
import Foundation

extension Country {
    
    static var stub = Country(
        code: "TR",
        name: "Turkey",
        capital: "Ankara",
        emoji: "🇹🇷",
        phone: "90"
    )
}
