//
//  MapViewDelegate.swift
//  IDMaps
//
//  Created by Igor Dorofix on 5/22/17.
//  Copyright © 2017 ID. All rights reserved.
//

import Foundation

class MapViewDelegate: NSObject {
    var geocoder: MapGeocoder
    
    override init() {
        geocoder = MapGeocoder(withType: MapManager.shared.geocoderType)
        super.init()
    }
}
