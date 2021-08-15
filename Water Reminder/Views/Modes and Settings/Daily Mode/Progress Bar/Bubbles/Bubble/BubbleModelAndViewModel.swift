//
//  BubbleModel.swift
//  Water Reminder
//
//  Created by Mu qi Zhang on 13/8/21.
//

import SwiftUI


class BubbleViewModel: Identifiable, ObservableObject {
    
    let id: UUID = UUID()
    @Published var x: CGFloat
    @Published var y: CGFloat
    @Published var width: CGFloat
    @Published var height: CGFloat
    @Published var lifetime: TimeInterval = 0
    
    init(height: CGFloat, width: CGFloat, x: CGFloat, y: CGFloat, lifetime: TimeInterval){
        self.height = height
        self.width = width
        self.x = x
        self.y = y
        self.lifetime = lifetime
    }
    
    func xFinalValue() -> CGFloat {
        return CGFloat.random(in: -10*CGFloat(lifetime*2.5)...10*CGFloat(lifetime*2.5))
    }
}
