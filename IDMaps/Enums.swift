//
//  Enums.swift
//  IDMaps
//
//  Created by Igor Dorofix on 5/20/17.
//  Copyright © 2017 ID. All rights reserved.
//

import Foundation

protocol SettingsItem {
    func title() -> String
}

enum MapType: Int, SettingsItem {
    case apple
    case mapBox
    
    static func values() -> [MapType] {
        return [.apple, .mapBox]
    }
    
    func title() -> String {
        switch self {
        case .apple:
            return "Native"
        case .mapBox:
            return "MapBox"
        }
    }
}

enum GeocoderType: Int, SettingsItem {
    case apple
    case mapbox
    
    static func values() -> [GeocoderType] {
        return [.apple, .mapbox]
    }
    
    func title() -> String {
        switch self {
        case .apple:
            return "Native"
        case .mapbox:
            return "MapBox"
        }
    }
}
