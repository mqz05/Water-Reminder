//
//  SectionMode.swift
//  Water Reminder
//
//  Created by Mu qi Zhang on 9/8/21.
//

import SwiftUI


//
// MARK: Seccion del Menu
//

struct SectionView: View {
    
    var section: MenuModesData
    @Binding var modoSeleccionado: String
    
    var body: some View {
        HStack(spacing: 15) {
            
            section.imageName == "Settings Icon" ? Image("\(section.imageName)").resizable().font(.title2).frame(width: 40, height: 40) : Image(systemName: section.imageName).resizable().font(.title2).frame(width: 30, height: 30)
            
                
            Text(section.sectionName)
                .fontWeight(.semibold)
        }
    }
}
