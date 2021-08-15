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
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {waveViewModel.updateWaveMotion()})
                }
            
            Text(String(format: "%.0f", firebaseViewModel.porcentaje) + "%")
                .font(.custom("NewAcademy", size: 64))
                .foregroundColor(Color(#colorLiteral(red: 0.09385982901, green: 0.1059651747, blue: 0.5198106766, alpha: 1)))
        }
    }
}
