//
//  WavesViewModel.swift
//  Water Reminder
//
//  Created by Mu qi Zhang on 13/8/21.
//

import SwiftUI


class WaveViewModel: ObservableObject {
    
    @Published var waveOffset = Angle(degrees: 0)
    
    @Published var waveOffset2 = Angle(degrees: 180)
    
    func updateWaveMotion() {
        
        if self.waveOffset == Angle(degrees: 0) {
            withAnimation(Animation.linear(duration: 2.5).repeatForever(autoreverses: false)) {
                self.waveOffset = Angle(degrees: 360)
                self.waveOffset2 = Angle(degrees: -180)
            }
        } else {
            withAnimation(Animation.linear(duration: 2.5).repeatForever(autoreverses: false)) {
                self.waveOffset = Angle(degrees: 0)
                self.waveOffset2 = Angle(degrees: 180)
            }
        }
    }
}
