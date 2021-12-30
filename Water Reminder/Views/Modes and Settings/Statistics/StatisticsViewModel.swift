//
//  StatisticsViewModel.swift
//  Water Reminder
//
//  Created by Mu qi Zhang on 24/10/21.
//

import Foundation
import SwiftUI


class StatisticsViewModel: ObservableObject {
    
    @Published var currentSelectedMonth: Int = 0
    
    @Published var currentSelectedWeek: Int = 0
    
    @Published var currentSelectedMonthYear: Date = Date()
    
    @Published var currentSelectedWeekYear: Date = Date()
    
    
    func resetDates() {
        self.currentSelectedMonth = 0
        self.currentSelectedMonthYear = Date()
        
        self.currentSelectedWeek = 0
        self.currentSelectedWeekYear = Date()
    }
    
    func titleDateFormat(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        
        return formatter.string(from: date)
    }
    
    func getCurrentMonth() -> Date {
        let calendar = Calendar.current
        
        guard let currentMonth = calendar.date(byAdding: .month, value: self.currentSelectedMonth, to: Date()) else {
            return Date()
        }
        
        return currentMonth
    }
    
    func getDayNumber(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd"
        
        return formatter.string(from: date)
    }
    
    func getMonthNumber(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM"
        
        return formatter.string(from: date)
    }
    
    func getYearNumber(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy"
        
        return formatter.string(from: date)
    }
    
    func getMonthNumberOfDays() -> Int {
        
        var numberOfDays = 0
        
        for (_, value) in extractMonthDates().enumerated() {
            if value.day != -1 {
                numberOfDays += 1
            }
        }
        
        return numberOfDays
    }
    
    func extractMonthDates() -> [DateValueModel] {
        
        let calendar = Calendar.current
        
        let currentMonth = getCurrentMonth()
        
        var days = currentMonth.getAllMonthDates().compactMap { date -> DateValueModel in
            
            let day = calendar.component(.day, from: date)
            
            return DateValueModel(day: day, date: date)
        }
        
        let firstWeekday = (calendar.component(.weekday, from: days.first?.date ?? Date()) - calendar.firstWeekday + 7) % 7 + 1
        
        for _ in 0..<firstWeekday - 1 {
            days.insert(DateValueModel(day: -1, date: Date()), at: 0)
        }
        
        return days
    }
    
    func getCurrentWeek() -> Date {
        let calendar = Calendar.current
        
        guard let currentWeek = calendar.date(byAdding: .weekOfYear, value: self.currentSelectedWeek, to: Date()) else {
            return Date()
        }
        
        return currentWeek
    }
    
    func extractWeekDates() -> [DateValueModel] {
        
        let calendar = Calendar.current
        
        let currentWeek = getCurrentWeek()
        
        let firstWeekday = currentWeek.startOfWeek().getGmtDate()
        
        let days = firstWeekday.getAllWeekDates().compactMap { date -> DateValueModel in
            
            let day = calendar.component(.day, from: date)
            
            return DateValueModel(day: day, date: date)
        }
        
        return days
    }
}


extension Date {
    
    func getAllMonthDates() -> [Date] {
        
        let calendar = Calendar.current
        
        // Adding time interval depending on the time zone
        let startDate = calendar.date(from: Calendar.current.dateComponents([.year, .month], from: self))!.getGmtDate()
        print("month start date \(startDate)")
        
        let range = calendar.range(of: .day, in: .month, for: startDate)!
        
        return range.compactMap { day -> Date in
            return calendar.date(byAdding: .day, value: day - 1, to: startDate)!
        }
    }
    
    func getAllWeekDates() -> [Date] {
        var weekDates: [Date] = []
        
        for i in 0..<7 {
            weekDates.append(Calendar.current.date(byAdding: .day, value: i, to: self)!)
        }
        return weekDates
    }
    
    func startOfWeek() -> Date {
        return Calendar.current.dateComponents([.calendar, .yearForWeekOfYear, .weekOfYear], from: self).date!
    }
    
    func endOfWeek() -> Date {
        let firstDayOfWeek = Calendar.current.dateComponents([.calendar, .yearForWeekOfYear, .weekOfYear], from: self).date!
        
        return Calendar.current.date(byAdding: .day, value: 6, to: firstDayOfWeek)!
    }
    
    static func datesString(from fromDate: Date, to toDate: Date) -> [String] {
        var dates: [String] = []
        var date = fromDate
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        
        while date <= toDate {
            dates.append(formatter.string(from: date))
            guard let newDate = Calendar.current.date(byAdding: .day, value: 1, to: date) else { break }
            date = newDate
        }
        return dates
    }
    
    func getGmtDate() -> Date {
        
        let year = Calendar.current.dateComponents([.year], from: self).year!
        let month = Calendar.current.dateComponents([.month], from: self).month!
        let day = Calendar.current.dateComponents([.day], from: self).day!
        
        let dayComponents = "\(day)-\(month)-\(year) 00:00:00"
        
        var dateFormatter: DateFormatter {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "d-MM-yyyy HH:mm:ss"
            dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
            return dateFormatter
        }
        
        return dateFormatter.date(from: dayComponents)!
    }
}
