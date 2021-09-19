//
//  CustomSelector.swift
//  Water Reminder
//
//  Created by Mu qi Zhang on 19/9/21.
//

import SwiftUI

struct CustomGenderSelector: View {
    
    @State var expand = false
    
    @Binding var selectedGender: Gender
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 18) {
            HStack {
                Text("Genre").font(.custom("NewAcademy", size: 22)).foregroundColor(.primaryDarkBlue)
                    
                Spacer()
                
                Image(systemName: expand ? "chevron.up" : "chevron.down").resizable().frame(width: 13, height: 6).foregroundColor(.primaryDarkBlue)
                 
            }.onTapGesture {
                self.expand.toggle()
            }
            .frame(width: 100)
            
            
            if expand {
                
                Button(action: {
                    
                    selectedGender = .notSelected
                    
                    
                }, label: {
                    Text("----")
                        .foregroundColor(selectedGender == .notSelected ? Color.primaryDarkBlue : Color.white)
                        .background(selectedGender == .notSelected ? FondoBordeRedondeado(fondo: Color.white.opacity(0.6), borde: Color.clear, width: 100, height: 30, scaleX: 0, scaleY: 0, radio: 7).offset(x: 25) : nil)
                }).frame(width: 100, height: 30, alignment: .leading)
                
                Button(action: {
                    
                    selectedGender = .male
                    
                    
                }, label: {
                    Text("Male")
                        .foregroundColor(selectedGender == .male ? Color.primaryDarkBlue : Color.white)
                        .background(selectedGender == .male ? FondoBordeRedondeado(fondo: Color.white.opacity(0.6), borde: Color.clear, width: 100, height: 30, scaleX: 0, scaleY: 0, radio: 7).offset(x: 25) : nil)
                }).frame(width: 100, height: 30, alignment: .leading)
                
                Button(action: {
                    
                    selectedGender = .female
                    
                    
                }, label: {
                    Text("Female")
                        .foregroundColor(selectedGender == .female ? Color.primaryDarkBlue : Color.white)
                        .background(selectedGender == .female ? FondoBordeRedondeado(fondo: Color.white.opacity(0.6), borde: Color.clear, width: 100, height: 30, scaleX: 0, scaleY: 0, radio: 7).offset(x: 15) : nil)
                }).frame(width: 100, height: 30, alignment: .leading)
            }
        }
        .frame(width: 100, height: expand ? 185 : 40)
        .background(FondoBordeRedondeado(fondo: Color.primaryLightBlue2, borde: Color.primaryLightBlue1, width: 125, height: expand ? 185 : 40, scaleX: expand ? 1.1 : 1.1, scaleY: expand ? 1.08 : 1.25, radio: expand ? 20 : 13))
        .animation(.spring())
    }
}
