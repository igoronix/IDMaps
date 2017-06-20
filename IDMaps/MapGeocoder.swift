//
//  MapGeocoder.swift
//  IDMaps
//
//  Created by Igor Dorofix on 5/22/17.
//  Copyright © 2017 ID. All rights reserved.
//

import MapKit
import MapboxGeocoder

typealias GeocodeCompletionHandler = (String?, Error?) -> Swift.Void

protocol MapGeocoderProtocol: class {
    weak var delegate: MapGeocoderDelegate? {get set}
    func reverseGeocodeLocation(_ location: CLLocation, completionHandler: @escaping GeocodeCompletionHandler)
}

protocol MapGeocoderDelegate: class {
    func reversGeocoder(_ geocoder: MapGeocoderProtocol, completeWithResult: String?)
}


class MapGeocoder: MapGeocoderProtocol {
    private typealias ReverseGeocodeFunction = (_ location: CLLocation, _ handler: @escaping GeocodeCompletionHandler) -> ()
    
    let type: GeocoderType
    weak var delegate: MapGeocoderDelegate?

    init(withType: GeocoderType) {
        self.type = withType
    }
    
    func reverseGeocodeLocation(_ location: CLLocation, completionHandler: @escaping GeocodeCompletionHandler) {
        self.reverseFunctionForType(type)?(location, {[weak self] (result, error) in
            completionHandler(result, error)
            guard let strongSelf = self else {
                return
            }
            strongSelf.delegate?.reversGeocoder(strongSelf, completeWithResult:result)
        })
    }
    
    // MARK: - Private methods
    
    private func reverseFunctionForType(_ type: GeocoderType) -> ReverseGeocodeFunction? {
        switch type {
        case .apple:
            return self.reverseGeocodeByApple
        case .mapbox:
            return self.reverseGeocodeByMapBox
        }
    }

    private func reverseGeocodeByApple(_ location: CLLocation, _ handler: @escaping GeocodeCompletionHandler) {
        CLGeocoder().reverseGeocodeLocation(location) { (placemarks, error) in
            guard let addressDict = placemarks?[0].addressDictionary else {
                handler(nil, error)
                return
            }
            
            if let formattedAddress = addressDict["FormattedAddressLines"] as? [String] {
                handler(formattedAddress.joined(separator: ", "), error)
            } else {
                handler(nil, error)
            }
        }
    }
    
    private func reverseGeocodeByMapBox(_ location: CLLocation, _ handler: @escaping GeocodeCompletionHandler) {
        let options = ReverseGeocodeOptions(coordinate: location.coordinate)
        _ = Geocoder.shared.geocode(options) { (placemarks, attribution, error) in
            guard let placemark = placemarks?.first else {
                return
            }
            handler(placemark.qualifiedName, error)
        }
    }
}
