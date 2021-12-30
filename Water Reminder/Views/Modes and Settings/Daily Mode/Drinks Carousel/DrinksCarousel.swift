//
//  CarouselView.swift
//  Water Reminder
//
//  Created by Mu qi Zhang on 20/8/21.
//

import SwiftUI


struct DrinksCarousel: View {
    
    @EnvironmentObject var firebaseViewModel: FirebaseViewModel
    
    @Binding var estadoActual: DailyModePhases
    
    @GestureState private var dragState = DragState.inactive
    @State var carouselLocation = 0
    
    
    private func onDragEnded(drag: DragGesture.Value) {
        
        let dragThreshold:CGFloat = 200
        
        if drag.predictedEndTranslation.width > dragThreshold || drag.translation.width > dragThreshold{
            carouselLocation =  carouselLocation - 1
        } else if (drag.predictedEndTranslation.width) < (-1 * dragThreshold) || (drag.translation.width) < (-1 * dragThreshold)
        {
            carouselLocation =  carouselLocation + 1
        }
    }
    
    
    
    var body: some View {
        VStack {
            ZStack {
                ForEach(0..<bebidas.count){ i in
                    
                    let scale = getScaleEffect(i)
                    let offset = self.getOffset(i)
                    let opacity = self.getOpacity(i)
                    
                    BotonDrink(bebida: bebidas[i])
                    
                    .frame(width:175, height: 200)
                    
                    .scaleEffect(scale)
                    .animation(.interpolatingSpring(stiffness: 270, damping: 30.0, initialVelocity: 10.0), value: scale)
                    
                    .offset(x: offset)
                    .animation(.interpolatingSpring(stiffness: 270, damping: 30.0, initialVelocity: 10.0), value: offset)
                    
                    .opacity(opacity)
                    .animation(.interpolatingSpring(stiffness: 270, damping: 30.0, initialVelocity: 10.0), value: opacity)
                }
                
            }.gesture(
                DragGesture()
                    .updating($dragState) { drag, state, transaction in
                        state = .dragging(translation: drag.translation)
                    }
                    .onEnded(onDragEnded)
            )
            .scaleEffect(0.9)
            
            
            HStack(spacing: 30) {
                Button(action: {
                    carouselLocation =  carouselLocation - 1
                    
                }, label: {
                    Image(systemName: "arrowtriangle.backward.fill")
                        .resizable()
                        .frame(width: 50, height: 40)
                        .foregroundColor(Color.white)
                })
                
                Button(action: {
                    withAnimation(Animation.spring(), {
                        estadoActual = .selectQuantity
                    })
                    
                    firebaseViewModel.drinkDataToAdd.0 = bebidas[relativeLoc()].nombreBebida
                    
                }, label: {
                    Text("Select")
                        .font(.custom("NewAcademy", size: 24))
                        .foregroundColor(Color(#colorLiteral(red: 0.1829789287, green: 0.2423677345, blue: 1, alpha: 1)))
                        .frame(width: 185, height: 55)
                        .background(
                            Color.white
                                .clipShape(EsquinasRedondeadas(esquinas: .allCorners, radio: 17))
                        )
                })
                
                Button(action: {
                    carouselLocation =  carouselLocation + 1
                    
                }, label: {
                    Image(systemName: "arrowtriangle.backward.fill")
                        .resizable()
                        .frame(width: 50, height: 40)
                        .foregroundColor(Color.white)
                        .rotationEffect(Angle(degrees: 180))
                })
            }.padding(.top, 15)
        }
    }
    
    
    func relativeLoc() -> Int {
        return ((bebidas.count * 10000) + carouselLocation) % bebidas.count
    }
    
    
    func getScaleEffect(_ i:Int) -> CGFloat {
        if i == relativeLoc() {
            return 1.5
        } else {
            return 1
        }
    }
    
    
    func getOpacity(_ i:Int) -> Double{
        
        if i == relativeLoc()
            || i + 1 == relativeLoc()
            || i - 1 == relativeLoc()
            || i + 2 == relativeLoc()
            || i - 2 == relativeLoc()
            || i + 3 == relativeLoc()
            || i - 3 == relativeLoc()
            || (i + 1) - bebidas.count == relativeLoc()
            || (i - 1) + bebidas.count == relativeLoc()
            || (i + 2) - bebidas.count == relativeLoc()
            || (i - 2) + bebidas.count == relativeLoc()
            || (i + 3) - bebidas.count == relativeLoc()
            || (i - 3) + bebidas.count == relativeLoc()
        {
            return 1
        } else {
            return 0
        }
    }
    
    func getOffset(_ i:Int) -> CGFloat{
        
        //This sets up the central offset
        if (i) == relativeLoc()
        {
            //Set offset of cental
            return self.dragState.translation.width
        }
        
        //These set up the offset +/- 1
        else if
            (i) == relativeLoc() + 1
                ||
                (relativeLoc() == bebidas.count - 1 && i == 0)
        {
            //Set offset +1
            return self.dragState.translation.width + (150)
        }
        else if
            (i) == relativeLoc() - 1
                ||
                (relativeLoc() == 0 && (i) == bebidas.count - 1)
        {
            //Set offset -1
            return self.dragState.translation.width - (150)
        }
        
        //These set up the offset +/- 2
        else if
            (i) == relativeLoc() + 2
                ||
                (relativeLoc() == bebidas.count-1 && i == 1)
                ||
                (relativeLoc() == bebidas.count-2 && i == 0)
        {
            return self.dragState.translation.width + (150 + 125)
        }
        else if
            (i) == relativeLoc() - 2
                ||
                (relativeLoc() == 1 && i == bebidas.count-1)
                ||
                (relativeLoc() == 0 && i == bebidas.count-2)
        {
            //Set offset -2
            return self.dragState.translation.width - (150 + 125)
        }
        
        //These set up the offset +/- 3
        else if
            (i) == relativeLoc() + 3
                ||
                (relativeLoc() == bebidas.count-1 && i == 2)
                ||
                (relativeLoc() == bebidas.count-2 && i == 1)
                ||
                (relativeLoc() == bebidas.count-3 && i == 0)
        {
            return self.dragState.translation.width + (150 + (2 * 125))
        }
        else if
            (i) == relativeLoc() - 3
                ||
                (relativeLoc() == 2 && i == bebidas.count-1)
                ||
                (relativeLoc() == 1 && i == bebidas.count-2)
                ||
                (relativeLoc() == 0 && i == bebidas.count-3)
        {
            //Set offset -3
            return self.dragState.translation.width - (150 + (2 * 125))
        }
        
        //These set up the offset of the remainder
        
        //Set left offset
        else if
            (i) == relativeLoc() - 4
                ||
                (relativeLoc() == 3 && i == bebidas.count-1)
                ||
                (relativeLoc() == 2 && i == bebidas.count-2)
                ||
                (relativeLoc() == 1 && i == bebidas.count-3)
                ||
                (relativeLoc() == 0 && i == bebidas.count-4)
        {
            return -10000
        }
        
        //Set right offset
        else {
            return 10000
        }
    }
}



enum DragState {
    case inactive
    case dragging(translation: CGSize)
    
    var translation: CGSize {
        switch self {
        case .inactive:
            return .zero
        case .dragging(let translation):
            return translation
        }
    }
    
    var isDragging: Bool {
        switch self {
        case .inactive:
            return false
        case .dragging:
            return true
        }
    }
}
