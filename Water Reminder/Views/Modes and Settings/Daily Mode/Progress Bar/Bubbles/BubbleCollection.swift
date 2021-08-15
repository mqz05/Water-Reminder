//
//  BubbleEffect.swift
//  Water Reminder
//
//  Created by Mu qi Zhang on 12/8/21.
//

import SwiftUI

struct BubbleCollection: View {
    @StateObject var viewModel: BubbleCollectionViewModel = BubbleCollectionViewModel()
    
    var body: some View {
        GeometryReader { geo in
            ZStack{
                //Show bubble views for each bubble
                ForEach(viewModel.bubbles){ bubble in
                    Bubble(bubble: bubble, progressBarPosition: geo.frame(in: CoordinateSpace.named("ProgressBar")).origin.y)
                }
            }
            
            .onAppear(){
                //Set the initial position from frame size
                viewModel.viewBottom = geo.size.height
                viewModel.addBubbles()
            }
        }
    }
}
