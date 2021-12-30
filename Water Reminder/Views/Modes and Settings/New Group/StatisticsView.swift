//
//  StatisticsView.swift
//  Water Reminder
//
//  Created by Mu qi Zhang on 07/03/2021.
//

import SwiftUI

struct StatisticsView: View {
    
    @State var pickerSelectedItem = 0
    
    var body: some View {
        ZStack {
            BackgroundView(topColor: Color(#colorLiteral(red: 0.4080183647, green: 0.6348306513, blue: 1, alpha: 1)), bottomColor: Color(#colorLiteral(red: 0.1829789287, green: 0.2423677345, blue: 1, alpha: 1)), isHorizontal: false)
            
            VStack {
                Text("Statistics")
                    .font(.custom("DaggerSquare", size: 64))
                    .foregroundColor(Color(#colorLiteral(red: 0.09385982901, green: 0.1059651747, blue: 0.5198106766, alpha: 1)))
                
                ZStack {
                    Color.secondaryBlue
                        .frame(width: 834, height: 1100)
                        .clipShape(EsquinasRedondeadas(esquinas: [.topLeft, .topRight], radio: 10))
                    
                    VStack(spacing: 30) {
                        Text("Total Consumed Water")
                            .frame(width: 675, alignment: .center)
                            .font(.custom("DaggerSquare", size: 58))
                            .foregroundColor(.secondaryDarkBlue2)
                            .padding(.top, 30)
                        
                        CustomSegmentedPicker(pickerSelectedItem: $pickerSelectedItem)
                        
                        ZStack {
                            Color.secondaryDarkBlue2
                                .frame(width: 800, height: 800)
                                .cornerRadius(35)
                            
                            if pickerSelectedItem == 0 {
                                DailyStatistics()
                                
                            } else if pickerSelectedItem == 1 {
                                WeeklyStatistics()
                                
                            } else {
                                MonthlyStatistics()
                            }
                        }
                        
                    }.offset(y: -50)
                }
            }.frame(width: 834, height: 1134, alignment: .center).offset(y: 50)
        }
    }
}

