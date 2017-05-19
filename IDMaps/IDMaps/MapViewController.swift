//
//  ViewController.swift
//  IDMaps
//
//  Created by Igor Dorofix on 5/19/17.
//  Copyright © 2017 ID. All rights reserved.
//

import UIKit
import MapKit
import Mapbox

class MapViewController: UIViewController {

    @IBOutlet var mapContainer: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        MapManager.shared.delegate = self
        self.setupMap(type: MapManager.shared.mapType)
    }
    
    // MARK: - Private methods

    fileprivate func setupMap(type: MapType) {
        self.mapContainer.subviews.forEach { $0.removeFromSuperview() }
        
        let mapView = self.mapView(type: type)
        mapView.pinToSuperview(self.mapContainer)
    }
    
     private func mapView(type: MapType) -> UIView {
        switch type {
        case .apple:
            return MKMapView()
        case .mapBox:
            return MGLMapView()
        }
    }
}

extension MapViewController: MapManagerDelegate {
    func mapManagerDidChangeMap(_ mapType: MapType) {
        self.setupMap(type: mapType)
    }
    
    func mapManagerDidChangeGeocoder(_ geocoderType: GeocoderType) {
        
    }
}

