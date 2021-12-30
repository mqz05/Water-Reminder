//
//  WeeklyStatistics.swift
//  Water Reminder
//
//  Created by Mu qi Zhang on 2/10/21.
//

import SwiftUI

struct WeeklyStatistics: View {
    
    @EnvironmentObject var firebaseViewModel: FirebaseViewModel
    
    @EnvironmentObject var statisticsViewModel: StatisticsViewModel
    
    
    @State var data: Array<(CGFloat, Int)> = []
    
    @State var allowClick = true
    
    var body: some View {
        
        VStack(spacing: 20) {
            // Week Selector
            WeekSelector().allowsHitTesting(allowClick).padding(.top, 2)
            
            // Line Graph
            ZStack {
                Rectangle().frame(width: 775, height: 350).cornerRadius(35).foregroundColor(Color.secondaryDarkBlue1)
                
                if data.count > 1 {
                    withAnimation(.linear(duration: 1)) {
                        LineGraph(amountData: data.map { item in return item.0 }, dateData: Date.datesString(from: statisticsViewModel.currentSelectedWeekYear.startOfWeek().getGmtDate(), to: statisticsViewModel.currentSelectedWeekYear.endOfWeek().getGmtDate()), offsetIndex: 1, objectiveOffsetIndex: 2)
                            .frame(width: 700, height: 275)
                    }
                }
            }.padding(.top, 3)
            
            let totalAmount: CGFloat = self.firebaseViewModel.selectedWeekMonthData.amountConsumed.map{ $0.0 }.reduce(0, +)
            
            let totalObjective: Int = self.firebaseViewModel.userData.dailyWaterObjective * 7
            
            let percentage: Double = (Double(totalAmount) / Double(totalObjective)) * 100
            
            LegendLineGraph(totalAmount: totalAmount, totalObjective: totalObjective, percentage: percentage).padding(.top, 5)
            
        }.onChange(of: statisticsViewModel.currentSelectedWeek, perform: { newValue in
            
            allowClick = false
            
            statisticsViewModel.currentSelectedWeekYear = statisticsViewModel.getCurrentWeek()
            
            Timer.scheduledTimer(withTimeInterval: 0.25, repeats: false, block: {_ in
                
                withAnimation(.spring()) {
                    setLineGraph(weekDays: statisticsViewModel.extractWeekDates())
                }
            })
        })
            .onAppear(perform: {
                
                allowClick = false
                
                Timer.scheduledTimer(withTimeInterval: 0.65, repeats: false, block: {_ in
                    
                    withAnimation(.spring()) {
                        setLineGraph(weekDays: statisticsViewModel.extractWeekDates())
                    }
                })
            })
            .frame(width: 800, height: 800)
    }
    
    func setLineGraph(weekDays: [DateValueModel]) {
        
        // Get data from dates
        firebaseViewModel.getDataFromDates(dates: weekDays)
        
        Timer.scheduledTimer(withTimeInterval: 0.25, repeats: false, block: {_ in
            
            // Order days data
            self.data = firebaseViewModel.selectedWeekMonthData.amountConsumed.sorted {
                ($0.1, $0.0) < ($1.1, $1.0)
            }
            
            Timer.scheduledTimer(withTimeInterval: 0.25, repeats: false, block: {_ in
                allowClick = true
            })
        })
    }
}


