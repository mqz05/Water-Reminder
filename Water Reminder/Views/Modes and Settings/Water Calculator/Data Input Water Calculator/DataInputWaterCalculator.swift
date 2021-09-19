//
//  CalculateDailyWater.swift
//  Water Reminder
//
//  Created by Mu qi Zhang on 27/8/21.
//

import SwiftUI


struct DataInputWaterCalculator: View {
    
    @Binding var selectedGender: Gender 
    
    @Binding var selectedAge: Any
    @Binding var selectedWeight: Any
    
    @Binding var selectedHours: Double
    @Binding var selectedCalories: Double
    
    
    init(selectedGender: Binding<Gender>, selectedAge: Binding<Any>, selectedWeight: Binding<Any>, selectedHours: Binding<Double>, selectedCalories: Binding<Double>) {
        
        self._selectedGender = selectedGender
        
        self._selectedAge = selectedAge
        self._selectedWeight = selectedWeight
        
        self._selectedHours = selectedHours
        self._selectedCalories = selectedCalories
        
        pickerAge = CustomPicker(data: ageData, width: 125, valueName: "Age", selected: $selectedAge)
        
        pickerWeight = CustomPicker(data: weightData, width: 125, valueName: "Weight", selected: $selectedWeight)
    }
    
    var body: some View {
        ZStack {
            Color.purple
                .frame(width: 800, height: 725)
                .cornerRadius(100)
                .offset(y: -25)
            
            Text("Calculate Daily Objective")
                .frame(width: 675, alignment: .leading)
                .font(.custom("DaggerSquare", size: 42))
                .foregroundColor(.secondaryBlue)
                .offset(y: -335)
            
            VStack {
                HStack {
                    Spacer()
                    
                    CustomGenderSelector(selectedGender: $selectedGender)
                        .frame(width: 125, height: 230)
                    
                    CustomPickerFrame(title: "Age", picker: pickerAge)
                    
                    CustomPickerFrame(title: "Weight", picker: pickerWeight)
                    
                }
                .frame(width: 740)
                
                Spacer()
                
                CustomDoubleStepper(hoursData: $selectedHours, caloriesData: $selectedCalories)
            }
            .frame(height: 535)
        }
    }
}
