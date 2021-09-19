//
//  MenuSectionsViewsModel.swift
//  Water Reminder
//
//  Created by Mu qi Zhang on 07/03/2021.
//

import Foundation


//
// MARK: Modos del Menu (Modelo)
//

enum MenuModesData: CaseIterable {
    case dailyMode
    case waterCalculator
    case drinkRest
    case statistics
    case settings
    
    var sectionName: String {
        switch self {
        case .dailyMode: return "Daily Mode"
        case .waterCalculator: return "Water Calculator"
        case .drinkRest: return "Drink & Rest"
        case .statistics: return "Statistics"
        case .settings: return "Settings"
        }
    }
    
    var imageName: String {
        switch self {
        case .dailyMode: return "calendar.circle"
        case .waterCalculator: return "questionmark.square.dashed"
        case .drinkRest: return "pause.circle"
        case .statistics: return "arrow.up.arrow.down.circle"
        case .settings: return "Settings Icon"
        }
    }
}
