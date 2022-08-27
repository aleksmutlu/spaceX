//
//  Launch.swift
//  Domain
//
//  Created by Aleks Mutlu on 23.08.2022.
//

import Foundation

public struct Launch {
    public let id: String?
    public let missionName: String?
    public let date: Date?
    public let rocketName: String?
    public let patchImageURL: URL?
    
    public var detail: String? = nil
    
    public init(
        id: String?,
        missionName: String?,
        dateString: String?,
        rocketName: String?,
        patchImageURLString: String?,
        detail: String?
    ) {
        self.id = id
        self.missionName = missionName
        if let dateString = dateString {
            self.date = dateFormatter.date(from: dateString)
        } else {
            self.date = nil
        }
        self.rocketName = rocketName
        if let patchImageURLString = patchImageURLString {
            self.patchImageURL = URL(string: patchImageURLString)
        } else {
            self.patchImageURL = nil
        }
        self.detail = detail
    }
}


// TODO: Move this formatter into a class with other formatters
private let dateFormatter: DateFormatter = {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.locale = Locale.current
    return dateFormatter
}()
