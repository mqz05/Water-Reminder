//
//  SectionView.swift
//  Water Reminder
//
//  Created by Mu qi Zhang on 06/03/2021.
//

import SwiftUI

struct SectionView: View {
    
    var section: MenuSections
    
    var body: some View {
        VStack(spacing: 10) {
            Text(section.title)
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.top, 20.0).padding([.leading, .trailing], 10)
            
            section.image.resizable().frame(width: 100, height: 100).padding(.bottom, 20.0).padding([.leading, .trailing], 10)
        }.padding(.leading, 30).padding(.trailing, 15)
        
    }
}

struct SectionView_Previews: PreviewProvider {
    static var previews: some View {
        SectionView(section: MenuSections(id: 1, title: "Mode ...", image: Image(systemName: "pencil.circle.fill"))).previewLayout (.fixed(width: 250, height: 250))
    }
}
