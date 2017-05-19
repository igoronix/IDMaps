//
//  SettingsViewController.swift
//  IDMaps
//
//  Created by Igor Dorofix on 5/19/17.
//  Copyright © 2017 ID. All rights reserved.
//

import UIKit

enum Section: Int {
    case map
    case geocoder
    
    static func values() -> [Section] {
        return [.map, .geocoder]
    }
    
    func items() -> [SettingsItem] {
        switch self {
        case .map:
            return MapType.values()
        case .geocoder:
            return GeocoderType.values()
        }
    }
    
    func title() -> String {
        switch self {
        case .map:
            return "Map:"
        case .geocoder:
            return "Geocoder"
        }
    }
}


class SettingsViewController: UITableViewController {
    
    // MARK: - Table view data source and delegate

    override func numberOfSections(in tableView: UITableView) -> Int {
        return Section.values().count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Section(rawValue: section)?.items().count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SettingsCell.cellId, for: indexPath)
        return cell
    }
    
    // MARK: Selection
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.accessoryType = .none
        var isNeedSelect = false
        if let section = Section(rawValue: indexPath.section) {
            let item = section.items()[indexPath.row]
            cell.textLabel?.text = item.title()
            
            switch section {
            case .map:
                isNeedSelect = item as! MapType == MapManager.shared.mapType
            case .geocoder:
                isNeedSelect = item as! GeocoderType == MapManager.shared.geocoderType
                break
            }
        }
        if isNeedSelect {
            tableView.selectRow(at: indexPath, animated: true, scrollPosition: .none)
        }
    }
    
    // MARK: - Configure headers
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return Section(rawValue: section)?.title() ?? ""
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 64.0
    }

    // MARK: - Configure selection
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let section = Section(rawValue: indexPath.section) else {
            return
        }
        
        switch section {
        case .map:
            MapManager.shared.mapType = MapType(rawValue: indexPath.row) ?? .apple
        case .geocoder:
            MapManager.shared.geocoderType = GeocoderType(rawValue: indexPath.row) ?? .apple
        }

        tableView.beginUpdates()
        UIView.setAnimationsEnabled(false)
        tableView.indexPathsForVisibleRows?.forEach({
            if $0.section == indexPath.section && $0.row != indexPath.row {
                tableView.deselectRow(at: $0, animated: true)
            }
        })
        UIView.setAnimationsEnabled(true)
        tableView.endUpdates()
    }
}
