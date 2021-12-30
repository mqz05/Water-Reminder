//
//  MonthSelector.swift
//  Water Reminder
//
//  Created by Mu qi Zhang on 24/10/21.
//

import SwiftUI

struct MonthSelector: View {
    
    @EnvironmentObject var statisticsViewModel: StatisticsViewModel
    
    var smallTextScale: Bool = false
    
    func dateFormatter() -> [String] {
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY MMMM"
        
        let date = formatter.string(from: statisticsViewModel.currentSelectedMonthYear)
        
        return date.components(separatedBy: " ")
    }
    
    
    var body: some View {
        
        // Month Selector
        HStack(spacing: 20) {
            VStack(alignment: .leading, spacing: smallTextScale ? 5 : 10) {
                Text(dateFormatter()[0])
                    .font(.custom("DaggerSquare", size: smallTextScale ? 30 : 32))
                    .foregroundColor(Color.secondaryLightBlue1)
                
                
                Text(dateFormatter()[1])
                    .font(.custom("DaggerSquare", size: smallTextScale ? 52 : 60))
                    .foregroundColor(Color.secondaryLightBlue1)
            }
            
            Spacer(minLength: 0)
            
            HStack(spacing: 15) {
                Button(action: {
                    withAnimation(.spring()) {
                        statisticsViewModel.currentSelectedMonth -= 1
                    }
                }, label: {
                    Image(systemName: "chevron.left")
                        .foregroundColor(Color.secondaryLightBlue1)
                })
                
                Button(action: {
                    withAnimation(.spring()) {
                        statisticsViewModel.currentSelectedMonth += 1
                    }
                }, label: {
                    Image(systemName: "chevron.right")
                        .foregroundColor(Color.secondaryLightBlue1)
                })
                
            }.padding(.trailing, 30).scaleEffect(1.8)
            
        }.padding(.horizontal, 45)
    }
}
