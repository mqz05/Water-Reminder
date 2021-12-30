//
//  CustomStepper.swift
//  Water Reminder
//
//  Created by Mu qi Zhang on 19/9/21.
//

import SwiftUI

struct CustomDoubleStepper: View {
    
    @Binding var hoursData: Double
    
    @Binding var caloriesData: Double
    
    var body: some View {
        ZStack {
            FondoBordeRedondeado(fondo: Color.primaryLightBlue2, borde: Color.primaryLightBlue1, width: 720, height: 200, scaleX: 1.03, scaleY: 1.11, radio: 35)
            
            VStack(spacing: 30) {
                
                HStack {
                    Text("Physical Activity")
                        .frame(width: 400, alignment: .leading)
                        .font(.custom("NewAcademy", size: 26))
                        .foregroundColor(.primaryDarkBlue)
                        .padding(.top, 20)
                    
                    Spacer()
                    
                    Text("(Optional)")
                        .frame(width: 100, alignment: .trailing)
                        .font(.custom("NewAcademy", size: 16))
                        .foregroundColor(.gray)
                        .padding(.top, 20)
                    
                }.frame(width: 680)
                
                HStack(spacing: 40) {
                    CustomStepper(title: "Hours ", extraTitle: "(exercise per week)", unit: "h", decimal: true, stepDifferece: 0.25, data: $hoursData)
                    
                    CustomStepper(title: "Calories ", extraTitle: "(per workout)", unit: "cal", decimal: false, stepDifferece: 10, data: $caloriesData)
                }
                .padding(.bottom, 35)
            }
        }
    }
}



//
// MARK: Custom Stepper
//

struct CustomStepper: View {
    
    @ObservedObject var minusPressViewModel: PressViewModel
    
    @ObservedObject var plusPressViewModel: PressViewModel
    
    
    var title: String
    
    var extraTitle: String
    
    var unit: String
    
    var decimal: Bool
    
    
    @Binding var data: Double
    
    
    
    init(title: String, extraTitle: String, unit: String, decimal: Bool, stepDifferece: Double, data: Binding<Double>) {
        
        self.minusPressViewModel = PressViewModel(isPlus: false, stepDiff: stepDifferece)
        self.plusPressViewModel = PressViewModel(isPlus: true, stepDiff: stepDifferece)
        
        self.title = title
        self.extraTitle = extraTitle
        
        self.unit = unit
        self.decimal = decimal
        
        self._data = data
    }
    
    
    
    var body: some View {
        VStack {
            
            HStack(spacing: 0) {
                Text(title)
                    .frame(alignment: .leading)
                    .font(.custom("NewAcademy", size: 22))
                    .foregroundColor(.primaryDarkBlue)
                
                Text(extraTitle)
                    .frame(alignment: .leading)
                    .font(.custom("NewAcademy", size: 16))
                    .foregroundColor(.primaryDarkBlue)
                
            }.frame(width: 300)
            
            HStack(spacing: 15) {
                
                PlusMinusButton(pressViewModel: minusPressViewModel, data: $data)
                
                ZStack {
                    FondoBordeRedondeado(fondo: Color.primaryLightBlue2, borde: Color.white, width: 150, height: 50, scaleX: 1.05, scaleY: 1.1, radio: 25)
                    
                    Text(calculateText())
                        .font(.custom("NewAcademy", size: 20))
                }
                
                PlusMinusButton(pressViewModel: plusPressViewModel, data: $data)
            }
        }
    }
    
    private func calculateText() -> String {
        
        if minusPressViewModel.started {
            if data + minusPressViewModel.value <= 0 {
                return decimal
                    ? String("\(Double(0)) " + "\(unit)")
                    : String("\(Int(0)) " + "\(unit)")
                
            } else {
                return decimal
                    ? String("\(Double(data + minusPressViewModel.value)) " + "\(unit)")
                    : String("\(Int(data + minusPressViewModel.value)) " + "\(unit)")
            }
        } else if plusPressViewModel.started {
            return decimal
                ? String("\(Double(data + plusPressViewModel.value)) " + "\(unit)")
                : String("\(Int(data + plusPressViewModel.value)) " + "\(unit)")
            
        } else {
            return decimal
                ? String("\(Double(data)) " + "\(unit)")
                : String("\(Int(data)) " + "\(unit)")
        }
    }
}

struct PlusMinusButton: View {
    
    var pressViewModel: PressViewModel
    
    @State var pressed: Bool = false
    
    @Binding var data: Double
    
    var body: some View {
        ZStack {
            Circle()
                .fill(pressed ? Color.purple : Color.lightPurple)
                .frame(width: 35, height: 35)
                .animation(.linear, value: pressed)
            
            Capsule()
                .fill(pressed ? Color.lightPurple : Color.purple)
                .animation(.linear, value: pressed)
                .frame(width: 20, height: 2)
            
            pressViewModel.isPlus
                ? Capsule()
                .fill(pressed ? Color.lightPurple : Color.purple)
                .animation(.linear, value: pressed)
                .frame(width: 2, height: 20)
                : nil
        }
        .onTapGesture {
            
            pressed = true
            
            Timer.scheduledTimer(withTimeInterval: 0.2, repeats: false, block: {_ in
                pressed = false
            })
            
            if pressViewModel.isPlus {
                data += pressViewModel.stepDifference
            } else {
                if data != 0 {
                    data -= pressViewModel.stepDifference
                }
            }
        }
        .gesture(DragGesture(minimumDistance: 0)
                    .onChanged { _ in
                        pressViewModel.start()
                        
                        pressed = true
                    }
                    .onEnded { _ in
                        pressViewModel.stop()
                        
                        pressed = false
                        
                        if pressViewModel.isPlus {
                            data += pressViewModel.value
                            
                        } else {
                            if (data + pressViewModel.value) >= 0 {
                                data += pressViewModel.value
                            } else {
                                data = 0
                            }
                        }
                    })
    }
}

class PressViewModel: ObservableObject {
    
    @Published var value: Double = 0
    
    @Published var started = false
    
    private var timer: Timer?
    
    var stepDifference: Double
    
    var isPlus: Bool
    
    init(isPlus: Bool, stepDiff: Double) {
        self.isPlus = isPlus
        self.stepDifference = stepDiff
    }
    
    
    func start() {
        if !started {
            started = true
            value = 0
            startTimer()
        }
    }
    
    func stop() {
        timer?.invalidate()
        started = false
    }
    
    private func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 0.2, repeats: false) {[unowned self] _ in
            
            if isPlus {
                value += stepDifference
                
            } else {
                value -= stepDifference
            }
            
            self.startTimer()
        }
    }
}
