//
//  Progress Bar.swift
//  Water Reminder
//
//  Created by Mu qi Zhang on 11/8/21.
//

import SwiftUI

struct ProgressBar: View {
    
    @EnvironmentObject var firebaseViewModel: FirebaseViewModel
    
    @EnvironmentObject var waveViewModel: WaveViewModel
    
    var body: some View {
        
        ZStack(alignment: .center) {
            
            Circle()
                .stroke(Color.orange, lineWidth: 6)
                .frame(width: 600, height: 600)
                .overlay(
                    ZStack {
                        WavesCollection()
                        
                        BubbleCollection()
                        
                    }.clipShape(Circle().scale(0.97))
                )
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5, execute: {waveViewModel.updateWaveMotion()})
                }
            
            VStack(spacing: 5) {
                Text(String(format: "%.0f", firebaseViewModel.porcentaje) + "%")
                    .font(.custom("NewAcademy", size: 64))
                    .foregroundColor(Color(#colorLiteral(red: 0.09385982901, green: 0.1059651747, blue: 0.5198106766, alpha: 1)))
                
                Text("\(firebaseViewModel.userData.dailyWaterAmount) ml / \(firebaseViewModel.userData.dailyWaterObjective) ml")
                    .font(.custom("NewAcademy", size: 24))
                    .foregroundColor(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
                    .opacity(0.85)
                
            }.offset(y: 10)
        }
    }
}
