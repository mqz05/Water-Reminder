//
//  MenuView.swift
//  Water Reminder
//
//  Created by Mu qi Zhang on 06/03/2021.
//

import SwiftUI

private let sections = [MenuSections(id: 1, title: "Modo 1", image: Image(systemName: "pencil.circle.fill")), MenuSections(id: 2, title: "Modo 2", image: Image(systemName: "pencil.circle.fill")), MenuSections(id: 3, title: "Modo 3", image: Image(systemName: "pencil.circle.fill")), MenuSections(id: 4, title: "", image: Image(systemName: "")), MenuSections(id: 5, title: "", image: Image(systemName: "")), MenuSections(id: 6, title: "", image: Image(systemName: ""))]

struct MenuView: View {
    var body: some View {
        
        HStack(spacing: 0) {
            VStack(alignment: .center, spacing: 10) {
                HStack {
                    
                    Image(systemName: "list.bullet.rectangle").resizable().frame(width: 40, height: 30).padding(.trailing, 15)
                    
                    Text("Menu")
                        .font(.largeTitle)
                        .fontWeight(.heavy)
                        .foregroundColor(Color.black)
                        .padding(.leading, 5).padding(.trailing, 40)
                }
                
                WiderDivisorHorizontal()
                
                List{
                    ForEach(sections, id: \.id) { seccion in
                        SectionView(section: seccion).background(Color.blue)
                        
                    }.listRowBackground(Color.blue)
                }
                
                WiderDivisorHorizontal()
                
                HStack {
                    
                    Image("Settings Icon").resizable().frame(width: 65, height: 65)
                    Text("Settings")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(Color.black)
                        
                }
                
            }.frame(maxWidth: 220, maxHeight: 1200).background(Color.blue.ignoresSafeArea()).shadow(color: Color.blue, radius: 10)
            
            WiderDivisorVertical(color: Color.black, width: 7)
        }
    }
    // CHECKEAR .onAppear y .hidden (para mostrar y esconder la lista de modos, titulo de "Menu", settings, etc.
    
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView().previewLayout (.fixed(width: 230, height: 1200))
    }
}
