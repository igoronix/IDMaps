//
//  SettingsCell.swift
//  IDMaps
//
//  Created by Igor Dorofix on 5/20/17.
//  Copyright © 2017 ID. All rights reserved.
//

import UIKit

class SettingsCell: UITableViewCell {

    static let cellId = "SettingsCell"

    override func setSelected(_ selected: Bool, animated: Bool) {
        self.accessoryType = selected ? .checkmark : .none
    }
}
