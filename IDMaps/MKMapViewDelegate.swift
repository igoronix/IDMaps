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
        
        view.subviews.forEach { $0.removeFromSuperview() }
        self.mapViewDidSelect(coordinate: coordinate, withView: view)
    }
    
    func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView) {
        view.subviews.forEach { $0.removeFromSuperview() }
    }
}
