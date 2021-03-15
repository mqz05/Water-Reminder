//
//  SectionView.swift
//  Water Reminder
//
//  Created by Mu qi Zhang on 06/03/2021.
//

import SwiftUI

struct SectionView: View {
    
    var section: MenuSectionsViewsModel
    
    var body: some View {
        ZStack {
            VStack(spacing: 10) {
                Text(section.sectionName)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(Color.black)
                
                Image(systemName: section.imageName)
                    .resizable()
                    .frame(width: 100, height: 100)
                    .foregroundColor(Color.black)
            }
            .padding(20)
            
            Rectangle()
                .frame(width: 235, height: 200)
                .opacity(0)
                .border(Color.white, width: 4)
                .cornerRadius(20)
            
        }
    }
}

struct SectionView_Previews: PreviewProvider {
    static var previews: some View {
        SectionView(section: .dailyMode)
    }
}
