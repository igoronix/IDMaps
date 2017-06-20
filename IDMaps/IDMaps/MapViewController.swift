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
    
    weak var mapView: UIView?
    var mapDelegate: MapViewDelegate? // reference to mapView delegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        MapManager.shared.delegate = self
        self.setupMap(type: MapManager.shared.mapType)
    }
    
    
    @IBAction func tapOnMap(_ sender: AnyObject) {
        guard sender.state == UIGestureRecognizerState.began,
            let gestureRecognizer = sender as? UIGestureRecognizer,
            let mapView = self.mapView else {
                return
        }
        
        let tapLocation = gestureRecognizer.location(in: mapContainer)
        
        //TODO: Have to refactoring this code
        if let mapView = mapView as? MKMapView {
            mapView.removeAnnotations(mapView.annotations)
            
            let coordinates = mapView.convert(tapLocation, toCoordinateFrom: mapContainer)
            let annotation = MKPointAnnotation()
            annotation.coordinate = coordinates
            mapView.addAnnotation(annotation)
            mapView.selectAnnotation(annotation, animated: true)
        } else if let mapView = mapView as? MGLMapView {
            mapView.removeAnnotations(mapView.annotations ?? [])
            
            let coordinates = mapView.convert(tapLocation, toCoordinateFrom: mapContainer)
            let annotation = MGLPointAnnotation()
            annotation.coordinate = coordinates
            mapView.addAnnotation(annotation)
            mapView.selectAnnotation(annotation, animated: true)
        }
    }
    
    // MARK: - Private methods
    
    fileprivate func setupMap(type: MapType) {
        self.mapContainer.subviews.forEach { $0.removeFromSuperview() }
        
        let mapView: UIView?
        switch type {
        case .mapBox:
            let mapBoxView = MGLMapView()
            let delegate = MapBoxViewDelegate()
            mapBoxView.delegate = delegate
            self.mapDelegate = delegate
            mapView = mapBoxView
        case .apple:
            let appleMap = MKMapView()
            let delegate = AppleMapViewDelegate()
            appleMap.delegate = delegate
            self.mapDelegate = delegate
            mapView = appleMap
        }
        
        mapView?.pinToSuperview(self.mapContainer)
        self.mapView = mapView
    }
}

extension MapViewController: MapManagerDelegate {
    func mapManagerDidChangeMap(_ mapType: MapType) {
        self.setupMap(type: mapType)
    }
    
    func mapManagerDidChangeGeocoder(_ geocoderType: GeocoderType) {
        self.mapDelegate?.geocoder = MapGeocoder(withType: geocoderType)
    }
}
