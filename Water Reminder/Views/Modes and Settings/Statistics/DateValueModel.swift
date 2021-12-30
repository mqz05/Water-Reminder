//
//  DateValueModel.swift
//  Water Reminder
//
//  Created by Mu qi Zhang on 3/10/21.
//

import SwiftUI


struct DateValueModel: Identifiable {
    var id = UUID().uuidString
    var day: Int
    var date: Date
}


struct SelectedDateWaterData: Identifiable {
    var id = UUID().uuidString
    var amountConsumed: Int
    var percentage: Int
    var typesOfDrinksAmount: Array<(String, Double)>
    var exists: Bool
}

struct SelectedWeekMonthWaterData: Identifiable {
    var id = UUID().uuidString
    var amountConsumed: Array<(CGFloat, Int)>
    var typesOfDrinksAmount: Array<(String, Int)>
}

