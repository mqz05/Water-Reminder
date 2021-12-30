//
//  CustomSegmentedPicker.swift
//  Water Reminder
//
//  Created by Mu qi Zhang on 1/10/21.
//

import SwiftUI

struct CustomSegmentedPicker: View {
    
    @EnvironmentObject var statisticsViewModel: StatisticsViewModel
    
    @Binding var pickerSelectedItem: Int
    
    var body: some View {
        HStack(alignment: .center, spacing: 25) {
            Button(action: {
                
                pickerSelectedItem = 0
                
                statisticsViewModel.resetDates()
                
            }, label: {
                Text("Daily")
                    .font(.custom("NewAcademy", size: 26))
                    .frame(width: 160)
                    .foregroundColor(pickerSelectedItem == 0 ? Color.secondaryDarkBlue2 : Color.secondaryLightBlue1)
                    .background(pickerSelectedItem == 0 ? Color.secondaryLightBlue1.frame(width: 160, height: 55).cornerRadius(12) : nil)
            })
            
            Button(action: {
                
                pickerSelectedItem = 1
                
                statisticsViewModel.resetDates()
                
            }, label: {
                Text("Weekly")
                    .font(.custom("NewAcademy", size: 25))
                    .frame(width: 160)
                    .foregroundColor(pickerSelectedItem == 1 ? Color.secondaryDarkBlue2 : Color.secondaryLightBlue1)
                    .background(pickerSelectedItem == 1 ? Color.secondaryLightBlue1.frame(width: 160, height: 55).cornerRadius(12) : nil)
            })
            
            Button(action: {
                
                pickerSelectedItem = 2
                
                statisticsViewModel.resetDates()
                
            }, label: {
                Text("Monthly")
                    .font(.custom("NewAcademy", size: 26))
                    .frame(width: 160)
                    .foregroundColor(pickerSelectedItem == 2 ? Color.secondaryDarkBlue2 : Color.secondaryLightBlue1)
                    .background(pickerSelectedItem == 2 ? Color.secondaryLightBlue1.frame(width: 160, height: 55).cornerRadius(12) : nil)
            })
            
        }.frame(width: 560, height: 65, alignment: .center)
            .background(Color.secondaryDarkBlue2.cornerRadius(15))
    }
}

