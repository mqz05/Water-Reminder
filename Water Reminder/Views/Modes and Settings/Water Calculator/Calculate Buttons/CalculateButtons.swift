//
//  CalculateExerciseWater.swift
//  Water Reminder
//
//  Created by Mu qi Zhang on 27/8/21.
//

import SwiftUI

struct CalculateButtons: View {
    
    @EnvironmentObject var firebaseViewModel: FirebaseViewModel
    
    @Binding var totalWaterObjective: Double
    
    @Binding var selectedGender: Gender
    
    @Binding var selectedAge: Any
    @Binding var selectedWeight: Any
    
    @Binding var selectedHours: Double
    @Binding var selectedCalories: Double
    
    @State private var showConfirmation: Bool = false
    @State private var isCalculateConfirmation: Bool = false
    
    
    var body: some View {
        ZStack {
            Color.secondaryBlue
                .frame(width: 260, height: 500)
                .clipShape(EsquinasRedondeadas(esquinas: [.bottomLeft, .bottomRight], radio: 60))
            
            VStack(spacing: 5) {
                
                
                // Calculate Button
                
                Button(action: {
                    
                    if (selectedGender == .notSelected || selectedAge as! Int == 1) {
                        self.totalWaterObjective = 0
                        
                        self.showConfirmation = true
                        isCalculateConfirmation = true
                        
                    } else {
                        self.totalWaterObjective = dailyWaterCalc(gender: selectedGender, age: selectedAge, weight: selectedWeight) + exerciseWaterCalc(hours: selectedHours, calories: selectedCalories)
                    }
                    
                }, label: {
                    Text("Calculate")
                        .frame(width: 200, height: 60)
                        .font(.custom("DaggerSquare", size: 24))
                        .foregroundColor(.secondaryLightBlue2)
                        .background(Color.secondaryDarkBlue2)
                        .clipShape(EsquinasRedondeadas(esquinas: [.topLeft, .topRight], radio: 20))
                })
                
                
                // Set Objective Button
                
                Button(action: {
                    
                    if totalWaterObjective != 0 {
                        firebaseViewModel.userData.dailyWaterObjective = Int(totalWaterObjective)
                        
                        firebaseViewModel.setWaterObjective()
                        
                        firebaseViewModel.fetchUserData()
                        
                    } else if totalWaterObjective == 0 {
                        self.showConfirmation = true
                        isCalculateConfirmation = false
                    }
                    
                }, label: {
                    Text("Set Objective")
                        .frame(width: 200, height: 60)
                        .font(.custom("DaggerSquare", size: 24))
                        .foregroundColor(.secondaryLightBlue2)
                        .background(Color.secondaryDarkBlue2)
                })
                
                
                // Reset Button
                
                Button(action: {
                    
                    selectedGender = .notSelected
                    
                    pickerAge.resetPicker()
                    pickerWeight.resetPicker()
                    
                    selectedHours = 0
                    selectedCalories = 0
                    
                    totalWaterObjective = 0
                    
                }, label: {
                    Text("Reset")
                        .frame(width: 200, height: 60)
                        .font(.custom("DaggerSquare", size: 24))
                        .foregroundColor(.secondaryLightBlue2)
                        .background(Color.secondaryDarkBlue2)
                        .clipShape(EsquinasRedondeadas(esquinas: [.bottomLeft, .bottomRight], radio: 20))
                })
                
            }.padding(.top, 240)
        }
        
        // Alert
        
        .alert(isPresented: $showConfirmation, content: {
            
            if isCalculateConfirmation {
                return Alert(title: Text("Check and select the Gender, Age & Weight fields"), dismissButton: .cancel(Text("Return")))
            } else {
                return Alert(title: Text("Press Calculate before setting a objective"), dismissButton: .cancel(Text("Return")))
            }
        })
    }
    
    
    private func dailyWaterCalc(gender: Gender, age: Any, weight: Any) -> Double {
        
        let ageInt = age as! Int
        
        let dailyWaterCalc1: Double = Double(weight as! Int * 35)
        
        var dailyWaterCalc2: Double = 0
        
        
        if gender == .male {
            if ageInt >= 14 {
                dailyWaterCalc2 = 2500
                
            } else if ageInt <= 13 && ageInt >= 9 {
                dailyWaterCalc2 = 2100
                
            } else if ageInt <= 8 && ageInt >= 4 {
                dailyWaterCalc2 = 1600
                
            } else if ageInt == 3 {
                dailyWaterCalc2 = 1300
                
            } else if ageInt == 2 {
                dailyWaterCalc2 = 1200
                
            } else if ageInt == 1 {
                dailyWaterCalc2 = 1100
                
            } else {
                dailyWaterCalc2 = 0
            }
            
        } else if gender == .female {
            if ageInt >= 14 {
                dailyWaterCalc2 = 2000
                
            } else if ageInt <= 13 && ageInt >= 9 {
                dailyWaterCalc2 = 1900
                
            } else if ageInt <= 8 && ageInt >= 4 {
                dailyWaterCalc2 = 1600
                
            } else if ageInt == 3 {
                dailyWaterCalc2 = 1300
                
            } else if ageInt == 2 {
                dailyWaterCalc2 = 1200
                
            } else if ageInt == 1 {
                dailyWaterCalc2 = 1100
                
            } else {
                dailyWaterCalc2 = 0
            }
            
        } else {
            dailyWaterCalc2 = 0
        }
        
        return (dailyWaterCalc1 + dailyWaterCalc2) / 2
    }
    
    
    private func exerciseWaterCalc(hours: Double, calories: Double) -> Double {
        
        let hoursExerciseCalc: Double = 750 * (hours / 7)
        
        let caloriesExerciseCalc: Double = 1.25 * calories
        
        if hours == 0 && calories != 0 {
            return caloriesExerciseCalc
            
        } else if hours != 0 && calories == 0 {
            return hoursExerciseCalc
            
        } else if hours != 0 && calories != 0 {
            return (hoursExerciseCalc + caloriesExerciseCalc) / 2
            
        } else {
            return 0
        }
    }
}
