//
//  MapBoxViewDelegate.swift
//  IDMaps
//
//  Created by Igor Dorofix on 5/21/17.
//  Copyright © 2017 ID. All rights reserved.
//

import Mapbox

class MapBoxViewDelegate: MapViewDelegate, MGLMapViewDelegate {
    func mapView(_ mapView: MGLMapView, didSelect annotation: MGLAnnotation) {
        mapView.setCenter(annotation.coordinate, animated: true)
        self.geocoder.reverseGeocodeLocation(CLLocation(latitude: annotation.coordinate.latitude, longitude: annotation.coordinate.longitude)) { (result, erroe) in
            
        }

    }
    
    func mapView(_ mapView: MGLMapView, didSelect annotationView: MGLAnnotationView) {
        
    }
}
