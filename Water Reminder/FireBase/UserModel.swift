//
//  FirebaseModel.swift
//  Water Reminder
//
//  Created by Mu qi Zhang on 10/8/21.
//

import SwiftUI

//
// MARK: Datos Usuarios (Model)
//

struct User: Identifiable {
    var id: String = UUID().uuidString
    
    var nickname: String
    var level: String
    var points: Int
    
    var dailyWaterAmount: Int
    var dailyWaterObjective: Int
}
