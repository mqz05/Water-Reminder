//
//  SectionView.swift
//  Water Reminder
//
//  Created by Mu qi Zhang on 06/03/2021.
//

import SwiftUI

struct SectionView: View {
    
    var section: MenuSectionsViewsModel
    @Binding var modoSeleccionado: String
    
    var body: some View {
        HStack(spacing: 15) {
            
            section.imageName == "Settings Icon" ? Image("\(section.imageName)").resizable().font(.title2).frame(width: 40, height: 40) : Image(systemName: section.imageName).resizable().font(.title2).frame(width: 30, height: 30)
            
                
            /*
             .resizable()
             .frame(width: 100, height: 100)
             .foregroundColor(Color.black)*/
            
            Text(section.sectionName)
                .fontWeight(.semibold)
            /*
             .font(.largeTitle)
             .fontWeight(.bold)
             .foregroundColor(Color.black)*/
        }
        
    }
}

