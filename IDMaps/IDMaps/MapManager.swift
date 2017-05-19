//
//  MapManager.swift
//  IDMaps
//
//  Created by Igor Dorofix on 5/19/17.
//  Copyright © 2017 ID. All rights reserved.
//

import UIKit
import MapKit

enum MapType {
    case apple
    case mapBox
    
    static func values() -> [MapType] {
        return [.apple, .mapBox]
    }
}

class MapManager {

    static func mapView(type: MapType) -> UIView {
        switch type {
        case .apple:
            return MKMapView()
        case .mapBox:
            return UIView()
        }
    }
}
