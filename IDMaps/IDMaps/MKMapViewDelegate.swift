//
//  AppleMapViewDelegate.swift
//  IDMaps
//
//  Created by Igor Dorofix on 5/21/17.
//  Copyright © 2017 ID. All rights reserved.
//

import MapKit

class AppleMapViewDelegate: MapViewDelegate, MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        guard let coordinate = view.annotation?.coordinate else {
            return
        }
        mapView.setCenter(coordinate, animated: true)
        self.geocoder.reverseGeocodeLocation(CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)) { (result, erroe) in
            
        }
    }
}
