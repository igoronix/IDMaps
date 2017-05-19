//
//  ViewController.swift
//  IDMaps
//
//  Created by Igor Dorofix on 5/19/17.
//  Copyright © 2017 ID. All rights reserved.
//

import UIKit

class MapViewController: UIViewController {

    @IBOutlet var mapContainer: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.setupMap(type: .apple)
    }
    
    private func setupMap(type: MapType) {
        self.mapContainer.subviews.forEach { $0.removeFromSuperview() }
        
        let mapView = MapManager.mapView(type: type)
        mapView.pinToSuperview(self.mapContainer)
    }
}

