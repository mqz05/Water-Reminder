//
//  Bubble.swift
//  Water Reminder
//
//  Created by Mu qi Zhang on 13/8/21.
//

import SwiftUI


struct Bubble: View {
    //If you want to change the bubble's variables you need to observe it
    @ObservedObject var bubble: BubbleViewModel
    @State var opacity: Double = 0
    
    var progressBarPosition: CGFloat
    
    @EnvironmentObject var firebaseViewModel: FirebaseViewModel
    
    var body: some View {
        Image("Bubble")
            .resizable()
            .opacity(opacity)
            .frame(width: bubble.width, height: bubble.height)
            .position(x: bubble.x, y: bubble.y)
            .onAppear {
                
                withAnimation(.linear(duration: bubble.lifetime)){
                    //Go up
                    self.bubble.y = (progressBarPosition + 560) - (600 * (firebaseViewModel.porcentaje / 100))
                    
                    //Go sideways
                    self.bubble.x += bubble.xFinalValue()
                    
                    //Change size
                    let width = CGFloat.random(in:0...115)
                    self.bubble.width = width
                    self.bubble.height = width
                }
                
                //Change the opacity faded to full to faded
                //It is separate because it is half the duration
                DispatchQueue.main.asyncAfter(deadline: .now()) {
                    withAnimation(Animation.linear(duration: bubble.lifetime/2).repeatForever()) {
                        self.opacity = 0.4
                    }
                }
            }
    }
}
