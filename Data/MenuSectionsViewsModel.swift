//
//  MenuSectionsViewsModel.swift
//  Water Reminder
//
//  Created by Mu qi Zhang on 07/03/2021.
//

import Foundation

enum MenuSectionsViewsModel: Int, CaseIterable {
    case dailyMode
    case freeMode
    case drinkRest
    case statistics
    
    var sectionName: String {
        switch self {
        case .dailyMode: return "Daily Mode"
        case .freeMode: return "Free Mode"
        case .drinkRest: return "Drink & Rest"
        case .statistics: return "Statistics"
        }
    }
    
    var imageName: String {
        switch self {
        case .dailyMode: return "calendar.circle"
        case .freeMode: return "questionmark.square.dashed"
        case .drinkRest: return "pause.circle"
        case .statistics: return "arrow.up.arrow.down.circle"
        }
    }
}
