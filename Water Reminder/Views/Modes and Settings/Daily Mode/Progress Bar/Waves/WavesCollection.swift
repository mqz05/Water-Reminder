//
//  Waves.swift
//  Water Reminder
//
//  Created by Mu qi Zhang on 13/8/21.
//

import SwiftUI


struct WavesCollection: View {
    
    @EnvironmentObject var firebaseViewModel: FirebaseViewModel
    
    @EnvironmentObject var waveViewModel: WaveViewModel
    
    var body: some View {
        
        ZStack {
            Wave(offset: Angle(degrees: waveViewModel.waveOffset.degrees), percent: Double(firebaseViewModel.porcentaje / 100), waveHeightConstant: 0.015)
                .offset(x: 100)
                .fill(Color(red: 0, green: 0, blue: 1, opacity: 0.3))
            
            Wave(offset: Angle(degrees: waveViewModel.waveOffset.degrees), percent: Double(firebaseViewModel.porcentaje / 100), waveHeightConstant: 0.015)
                .offset(x: -100)
                .fill(Color(red: 0, green: 0, blue: 1, opacity: 0.3))
            
            Wave(offset: Angle(degrees: waveViewModel.waveOffset2.degrees), percent: Double(firebaseViewModel.porcentaje / 100), waveHeightConstant: 0.01)
                .fill(Color(red: 0, green: 0, blue: 1, opacity: 0.3))
        }
    }
}
