//
//  FreeModeView.swift
//  Water Reminder
//
//  Created by Mu qi Zhang on 07/03/2021.
//

import SwiftUI

struct WaterCalculatorView: View {
    
    @State var totalWaterObjective: Double = 0.0
    
    @State var selectedGender: Gender = .notSelected
    
    @State var selectedAge: Any = 0
    @State var selectedWeight: Any = 0
    
    @State var selectedHours: Double = 0
    @State var selectedCalories: Double = 0
    
    var body: some View {
        ZStack {
            
            BackgroundView(topColor: Color(#colorLiteral(red: 0.4080183647, green: 0.6348306513, blue: 1, alpha: 1)), bottomColor: Color(#colorLiteral(red: 0.1829789287, green: 0.2423677345, blue: 1, alpha: 1)), isHorizontal: false)
            
            Text("Water Calculator")
                .font(.custom("DaggerSquare", size: 64))
                .foregroundColor(Color(#colorLiteral(red: 0.09385982901, green: 0.1059651747, blue: 0.5198106766, alpha: 1)))
                .offset(y: -500)
            
            ZStack {
                HStack(spacing: 10) {
                    TotalWater(totalWaterObjective: $totalWaterObjective)
                    
                    CalculateButtons(totalWaterObjective: $totalWaterObjective, selectedGender: $selectedGender, selectedAge: $selectedAge, selectedWeight: $selectedWeight, selectedHours: $selectedHours, selectedCalories: $selectedCalories)
                    
                }.offset(y: 300)
                
                DataInputWaterCalculator(selectedGender: $selectedGender, selectedAge: $selectedAge, selectedWeight: $selectedWeight, selectedHours: $selectedHours, selectedCalories: $selectedCalories)
                    .offset(y: -30)
            }
            
        }
    }
}
