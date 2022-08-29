//
//  AppConfiguration.swift
//  Application
//
//  Created by Aleks Mutlu on 29.08.2022.
//

import Foundation

struct AppConfiguration {
    let apiURL: URL = {
        #if DEBUG
            return URL(string: "https://countries.trevorblades.com/")!
        #else
            return URL(string: "https://countries.trevorblades.com/")! // Production URL
        #endif
    }()
}
