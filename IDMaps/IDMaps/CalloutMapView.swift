//
//  CalloutMapView.swift
//  IDMaps
//
//  Created by Igor Dorofix on 5/22/17.
//  Copyright © 2017 ID. All rights reserved.
//

import UIKit

class CalloutMapView: UILabel {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.white
        self.layer.cornerRadius = 5.0
        self.layer.masksToBounds = true
        self.numberOfLines = 0
        self.textAlignment = .center
    }
}
