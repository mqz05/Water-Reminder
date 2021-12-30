//
//  DailyStatistics.swift
//  Water Reminder
//
//  Created by Mu qi Zhang on 2/10/21.
//

import SwiftUI

let weekDays: [String] = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"]

struct DailyStatistics: View {
    
    @EnvironmentObject var firebaseViewModel: FirebaseViewModel
    
    @EnvironmentObject var statisticsViewModel: StatisticsViewModel
    
    
    @State var isShowingCalendar = true
    
    
    // Time Data
    @State var currentSelectedFullDate = Date()
    
    
    var body: some View {
        
        if isShowingCalendar {
            
            ZStack {
                
                Rectangle().frame(width: 760, height: 760).cornerRadius(35).foregroundColor(Color.secondaryDarkBlue1)
                
                VStack(spacing: 55) {
                    
                    MonthSelector()
                        .onChange(of: statisticsViewModel.currentSelectedMonth, perform: { newValue in
                            withAnimation(.linear(duration: 0.5)) {
                                statisticsViewModel.currentSelectedMonthYear = statisticsViewModel.getCurrentMonth()
                            }
                        })
                    
                    VStack(spacing: 40) {
                        
                        // Weekdays
                        HStack(spacing: 50) {
                            ForEach(weekDays, id: \.self, content: { day in
                                
                                Text(day)
                                    .font(.custom("NewAcademy", size: 30))
                                    .foregroundColor(Color.primaryLightBlue2)
                            })
                        }.padding(.horizontal, 10)
                        
                        
                        // Day Selector
                        let columns = Array(repeating: GridItem(.flexible()), count: 7)
                        
                        LazyVGrid(columns: columns, spacing: 53) {
                            
                            ForEach(statisticsViewModel.extractMonthDates()) { value in
                                
                                if value.day != -1 {
                                    Text("\(value.day)")
                                        .font(.custom("DaggerSquare", size: 26))
                                        .foregroundColor(Color.secondaryLightBlue2)
                                        .background( isSameDay(date1: value.date, date2: statisticsViewModel.currentSelectedMonthYear) && isSameMonth() ? Circle().frame(width: 50, height: 50).foregroundColor(Color.purple) : nil )
                                        .onTapGesture {
                                            setStatsView(selectedDate: value.date)
                                        }
                                    
                                } else {
                                    Text("10").font(.custom("DaggerSquare", size: 26)).opacity(0)
                                }
                            }
                        }.padding(.horizontal, 25).frame(height: 450, alignment: .top)
                    }
                    
                }.frame(width: 800, height: 775)
                
            }
        } else {
            
            if firebaseViewModel.selectedDateData.exists {
                
                DataView()
                
            } else {
                // No data View
                EmptyDataView()
            }
        }
    }
    
    func isSameDay(date1: Date, date2: Date) -> Bool {
        let calendar = Calendar.current
        
        return calendar.isDate(date1, inSameDayAs: date2)
    }
    
    func isSameMonth() -> Bool {
        
        let calendar = Calendar.current
        
        guard let c = calendar.date(byAdding: .month, value: statisticsViewModel.currentSelectedMonth, to: Date()) else {
            return false
        }
        
        return Calendar.current.isDate(c, equalTo: Date(), toGranularity: .month)
    }
    
    func setStatsView(selectedDate: Date) {
        firebaseViewModel.setDataFromDate(date: selectedDate)
        
        Timer.scheduledTimer(withTimeInterval: 0.25, repeats: false, block: {_ in
            
            withAnimation(.spring()) {
                self.isShowingCalendar = false
                self.currentSelectedFullDate = selectedDate
            }
        })
    }
    
    @ViewBuilder
    func DataView() -> some View {
        
        ZStack {
            LazyVStack(spacing: 50) {
                
                // Title & Go Back Button
                ZStack {
                    // Title
                    Text(statisticsViewModel.titleDateFormat(date: currentSelectedFullDate))
                        .font(.custom("NewAcademy", size: 42))
                        .foregroundColor(Color.primaryLightBlue2)
                    
                    // Go Back Button
                    HStack {
                        Button(action: {
                            withAnimation(.spring()) { isShowingCalendar = true }
                            firebaseViewModel.selectedDateData.exists = false
                            
                        }, label: {
                            Image(systemName: "chevron.backward.circle")
                                .resizable()
                                .frame(width: 40, height: 40)
                                .foregroundColor(.white)
                        })
                        
                        Spacer(minLength: 0)
                    }.frame(width: 725)
                }
                
                // Stats & Legend
                HStack {
                    
                    let data = firebaseViewModel.selectedDateData.typesOfDrinksAmount.sorted {
                        ($0.1, $0.0) > ($1.1, $1.0)
                    }
                    
                    VStack(spacing: 25) {
                        // Stats
                        ZStack {
                            Circle()
                                .frame(width: 450, height: 450)
                                .foregroundColor(Color.secondaryDarkBlue1)
                            
                            PieChart(data: data)
                                .frame(width: 450, height: 450)
                        }
                        
                        //Legend
                        ZStack {
                            Rectangle()
                                .frame(width: 600, height: 160)
                                .cornerRadius(35)
                                .foregroundColor(Color.secondaryDarkBlue1)
                            
                            LegendPieChart(data: data)
                        }
                    }
                    
                    Spacer(minLength: 0)
                }.frame(width: 700)
                
            }.frame(width: 775, height: 775)
            
            // Progress Bar
            HStack {
                Spacer(minLength: 0)
                
                // Progress Bar
                VStack {
                    
                    // Water Objective
                    Text("\(firebaseViewModel.userData.dailyWaterObjective) ml")
                        .font(.custom("DaggerSquare", size: 22))
                        .foregroundColor(Color.primaryLightBlue1)
                    
                    // Progress Bar
                    ZStack(alignment: .bottom) {
                        Color.secondaryDarkBlue1
                        
                        Capsule()
                            .frame(width: 55, height:  firebaseViewModel.selectedDateData.percentage >= 100 ? 625 : 625 * (CGFloat(firebaseViewModel.selectedDateData.percentage) / 100))
                            .foregroundColor(Color.primaryLightBlue2)
                        
                    }.frame(width: 55, height: 625).clipShape(Capsule())
                    
                    // Consumed Percentage & Amount
                    VStack(spacing: 2) {
                        Text("\(firebaseViewModel.selectedDateData.percentage)" + " %")
                            .font(.custom("DaggerSquare", size: 24))
                            .foregroundColor(Color.primaryLightBlue1)
                        
                        Text("(\(firebaseViewModel.selectedDateData.amountConsumed) ml)")
                            .font(.custom("DaggerSquare", size: 20))
                            .foregroundColor(Color.primaryLightBlue1)
                    }
                }
                
            }.frame(width: 725)
        }.onDisappear {
            firebaseViewModel.selectedDateData = SelectedDateWaterData(amountConsumed: 0, percentage: 0, typesOfDrinksAmount: [("", 0)], exists: false)
            print("reset chart")
        }
    }
    
    @ViewBuilder
    func EmptyDataView() -> some View {
        
        ZStack {
            VStack {
                // Title & Go Back Button
                ZStack {
                    // Title
                    Text(statisticsViewModel.titleDateFormat(date: currentSelectedFullDate))
                        .font(.custom("NewAcademy", size: 42))
                        .foregroundColor(Color.primaryLightBlue2)
                    
                    // Go Back Button
                    HStack {
                        Button(action: {
                            withAnimation(.spring()) { isShowingCalendar = true }
                            firebaseViewModel.selectedDateData.exists = false
                            
                        }, label: {
                            Image(systemName: "chevron.backward.circle")
                                .resizable()
                                .frame(width: 40, height: 40)
                                .foregroundColor(.white)
                        })
                        
                        Spacer(minLength: 0)
                    }.frame(width: 725)
                }
                Spacer(minLength: 0)
            }.frame(height: 725)
            
            
            VStack(spacing: 25) {
                Image("Sad Water")
                    .resizable()
                    .frame(width: 325, height: 325)
                
                Text("No data for this date :(")
                    .font(.custom("NewAcademy", size: 30))
                    .foregroundColor(.primaryLightBlue1)
            }
        }
    }
}
