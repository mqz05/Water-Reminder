//
//  DailyModeTitle.swift
//  Water Reminder
//
//  Created by Mu qi Zhang on 19/8/21.
//

import SwiftUI

struct DailyModeTitle: View {
    
    var currentDate: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, d MMMM"
        
        return formatter.string(from: Date())
    }
    
    var body: some View {
        VStack(spacing: 25) {
            Text("Daily Mode")
                .font(.custom("DaggerSquare", size: 64))
                .foregroundColor(Color(#colorLiteral(red: 0.09385982901, green: 0.1059651747, blue: 0.5198106766, alpha: 1)))
                .offset(y: 15)
            
            Text("\(currentDate)")
                .font(.custom("DaggerSquare", size: 30))
                .foregroundColor(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
                .opacity(0.6)
        }
    }
}
