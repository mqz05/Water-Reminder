//
//  MonthlyStatistics.swift
//  Water Reminder
//
//  Created by Mu qi Zhang on 2/10/21.
//

import SwiftUI

struct MonthlyStatistics: View {
    
    @EnvironmentObject var firebaseViewModel: FirebaseViewModel
    
    @EnvironmentObject var statisticsViewModel: StatisticsViewModel
    
    
    @State var data: Array<(CGFloat, Int)> = []
    
    @State var allowClick = true
    
    var body: some View {
        
        VStack(spacing: 20) {
            // Month Selector
            MonthSelector(smallTextScale: true).allowsHitTesting(allowClick)
            
            // Line Graph
            ZStack {
                Rectangle().frame(width: 775, height: 350).cornerRadius(35).foregroundColor(Color.secondaryDarkBlue1)
                
                if data.count > 1 {
                    
                    let dateData = data.map { item in return "\(item.1)-\(statisticsViewModel.getMonthNumber(date: statisticsViewModel.getCurrentMonth()))-\(statisticsViewModel.getYearNumber(date: statisticsViewModel.getCurrentMonth()))" }
                    
                    withAnimation(.linear(duration: 1)) {
                        LineGraph(amountData: data.map { item in return item.0 }, dateData: dateData, offsetIndex: 4, objectiveOffsetIndex: 6)
                            .frame(width: 700, height: 275)
                    }
                }
            }
            
            let totalAmount: CGFloat = self.firebaseViewModel.selectedWeekMonthData.amountConsumed.map{ $0.0 }.reduce(0, +)
            
            let totalObjective: Int = self.firebaseViewModel.userData.dailyWaterObjective * statisticsViewModel.getMonthNumberOfDays()
            
            let percentage: Double = (Double(totalAmount) / Double(totalObjective)) * 100
            
            LegendLineGraph(totalAmount: totalAmount, totalObjective: totalObjective, percentage: percentage).padding(.top, 5)
            
            
        }.onChange(of: statisticsViewModel.currentSelectedMonth, perform: { newValue in
            
            allowClick = false
            
            statisticsViewModel.currentSelectedMonthYear = statisticsViewModel.getCurrentMonth()
            
            Timer.scheduledTimer(withTimeInterval: 0.25, repeats: false, block: {_ in
                
                withAnimation(.spring()) {
                    setLineGraph(monthDays: statisticsViewModel.extractMonthDates())
                }
            })
        })
            .onAppear(perform: {
                
                allowClick = false
                
                Timer.scheduledTimer(withTimeInterval: 0.65, repeats: false, block: {_ in
                    
                    withAnimation(.spring()) {
                        setLineGraph(monthDays: statisticsViewModel.extractMonthDates())
                    }
                })
            })
            .frame(width: 800, height: 800)
    }
    
    func setLineGraph(monthDays: [DateValueModel]) {
        
        var monthDays = monthDays
        
        // Remove previous month dates
        for (_, value) in monthDays.enumerated() {
            if value.day == -1 {
                monthDays.remove(at: 0)
            }
        }
        
        // Get data from dates
        firebaseViewModel.getDataFromDates(dates: monthDays)
        
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

