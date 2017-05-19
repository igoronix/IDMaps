//
//  MapManager.swift
//  IDMaps
//
//  Created by Igor Dorofix on 5/19/17.
//  Copyright © 2017 ID. All rights reserved.
//

protocol MapManagerDelegate: class {
    func mapManagerDidChangeMap(_ mapType: MapType)
    func mapManagerDidChangeGeocoder(_ geocoderType: GeocoderType)
}

class MapManager {
    static let shared = MapManager()
    
    var mapType: MapType = .apple {
        didSet {
            self.delegate?.mapManagerDidChangeMap(mapType)
        }
    }
    
    var geocoderType: GeocoderType = .google {
        didSet {
            self.delegate?.mapManagerDidChangeGeocoder(geocoderType)
        }
    }
    
    weak var delegate: MapManagerDelegate?
}
