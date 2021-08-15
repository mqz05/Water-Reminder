//
//  BubbleCollectionViewModel.swift
//  Water Reminder
//
//  Created by Mu qi Zhang on 13/8/21.
//

import SwiftUI


class BubbleCollectionViewModel: ObservableObject{
    
    @Published var viewBottom: CGFloat = CGFloat.zero
    @Published var bubbles: [BubbleViewModel] = []
    private var timer: Timer?
    
    func addBubbles(){
        let lifetime: TimeInterval = TimeInterval.random(in: 5.5...8.5)
        
        if timer != nil{
            timer?.invalidate()
        }
        
        timer = Timer.scheduledTimer(withTimeInterval: TimeInterval.random(in: 0.6...0.9), repeats: true) { (timer) in
            let bubble = BubbleViewModel(height: 50, width: 50, x: CGFloat.random(in: 0...600), y: self.viewBottom, lifetime: lifetime)
            
            //Add to array
            self.bubbles.append(bubble)
            
            //Get rid if the bubble at the end of its lifetime
            Timer.scheduledTimer(withTimeInterval: bubble.lifetime, repeats: false, block: {_ in
                self.bubbles.removeAll(where: {
                    $0.id == bubble.id
                })
            })
        }
    }
}
