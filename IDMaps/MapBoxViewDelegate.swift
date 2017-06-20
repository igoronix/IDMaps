//
//  MapBoxViewDelegate.swift
//  IDMaps
//
//  Created by Igor Dorofix on 5/21/17.
//  Copyright © 2017 ID. All rights reserved.
//

import Mapbox

class MapBoxViewDelegate: MapViewDelegate, MGLMapViewDelegate {
    public func mapView(_ mapView: MGLMapView, didSelect annotationView: MGLAnnotationView) {
        guard let coordinate = annotationView.annotation?.coordinate else {
            return
        }
        
        if let marker = annotationView.subviews.first as? UIImageView {
            self.mapViewDidSelect(coordinate: coordinate, withView: marker)
        }
    }
    
    public func mapView(_ mapView: MGLMapView, viewFor annotation: MGLAnnotation) -> MGLAnnotationView? {
        if let annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: kMapCalloutViewIdentifier) {
            return annotationView
        }
        
        return MGLAnnotationView.customMarkerAnnonationView(reuseIdentifier: kMapCalloutViewIdentifier)
    }
}

extension MGLAnnotationView {
    class func customMarkerAnnonationView(reuseIdentifier: String) -> MGLAnnotationView {
        let annotationView = MGLAnnotationView(reuseIdentifier: reuseIdentifier)
        
        let imageView = UIImageView(image: UIImage(named: "red_pin"))
        imageView.contentMode = .center
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        annotationView.addSubview(imageView)
        imageView.centerXAnchor.constraint(equalTo: annotationView.centerXAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: annotationView.topAnchor).isActive = true
        
        return annotationView
    }
}

