//
//  WeekSelector.swift
//  Water Reminder
//
//  Created by Mu qi Zhang on 1/11/21.
//

import SwiftUI

struct WeekSelector: View {
    
    @EnvironmentObject var statisticsViewModel: StatisticsViewModel
    
    func dateFormatter(day: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        
        let date = formatter.string(from: day)
        
        return date
    }
    
    
    var body: some View {
        
        // Month Selector
        HStack(spacing: 20) {
            VStack(alignment: .leading, spacing: 5) {
                
                Text(dateFormatter(day: statisticsViewModel.currentSelectedWeekYear.startOfWeek().getGmtDate()))
                    .font(.custom("DaggerSquare", size: 36))
                    .foregroundColor(Color.secondaryLightBlue1)
                    .frame(width: 450, alignment: .leading)
                
                Capsule()
                    .frame(width: 450, height: 1)
                    .foregroundColor(.white)
                    .opacity(0.6)
                
                Text(dateFormatter(day: statisticsViewModel.currentSelectedWeekYear.endOfWeek().getGmtDate()))
                    .font(.custom("DaggerSquare", size: 36))
                    .foregroundColor(Color.secondaryLightBlue1)
                    .frame(width: 450, alignment: .leading)
            }
            
            Spacer(minLength: 0)
            
            HStack(spacing: 15) {
                Button(action: {
                    withAnimation(.spring()) {
                        statisticsViewModel.currentSelectedWeek -= 1
                    }
                }, label: {
                    Image(systemName: "chevron.left")
                        .foregroundColor(Color.secondaryLightBlue1)
                })
                
                Button(action: {
                    withAnimation(.spring()) {
                        statisticsViewModel.currentSelectedWeek += 1
                    }
                }, label: {
                    Image(systemName: "chevron.right")
                        .foregroundColor(Color.secondaryLightBlue1)
                })
                
            }.padding(.trailing, 30).scaleEffect(1.8)
            
        }.padding(.horizontal, 45)
    }
}

