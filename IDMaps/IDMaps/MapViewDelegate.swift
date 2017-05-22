//
//  MapViewDelegate.swift
//  IDMaps
//
//  Created by Igor Dorofix on 5/22/17.
//  Copyright © 2017 ID. All rights reserved.
//

import UIKit
import MapKit

let kMapCalloutViewIdentifier = "MapCalloutViewIdentifier"
let kMaxAnnotationHeight: CGFloat = 75.0
let kMaxAnnotationHorizontalPadding: CGFloat = 50.0

class MapViewDelegate: NSObject {
    var geocoder: MapGeocoder
    
    override init() {
        geocoder = MapGeocoder(withType: MapManager.shared.geocoderType)
        super.init()
    }
    
    public func mapViewDidSelect(coordinate: CLLocationCoordinate2D, withView: UIView) {
        let callOutView = CalloutMapView(frame: CGRect.zero)
        callOutView.alpha = 0
        withView.addSubview(callOutView)
        
        callOutView.translatesAutoresizingMaskIntoConstraints = false
        callOutView.centerXAnchor.constraint(equalTo: withView.centerXAnchor).isActive = true
        callOutView.widthAnchor.constraint(lessThanOrEqualToConstant: UIScreen.main.bounds.width-kMaxAnnotationHorizontalPadding*2).isActive = true
        callOutView.bottomAnchor.constraint(equalTo: withView.topAnchor).isActive = true
        callOutView.heightAnchor.constraint(lessThanOrEqualToConstant: kMaxAnnotationHeight).isActive = true
        
        self.geocoder.reverseGeocodeLocation(CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)) { [weak callOutView]  (result, error) in
            guard let callOutView = callOutView else {
                return
            }
            
            UIView.animate(withDuration: 0.25, animations: { 
                callOutView.text = result
                callOutView.alpha = 1
            })
        }
    }
}
