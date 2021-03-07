//
//  ImageView.swift
//  Water Reminder
//
//  Created by Mu qi Zhang on 05/03/2021.
//

import SwiftUI

struct ImageView: View {
    var body: some View {
        VStack {
            Spacer()
            
            Image("Imagen Prueba").resizable().frame(maxWidth: 500, maxHeight: 500).clipShape(Circle()).overlay(Circle().stroke(Color.orange, lineWidth: 6)).shadow(color: Color.yellow, radius: 20)
            
            Spacer(minLength: 35)
            
            Image(systemName: "house.circle.fill").resizable().frame(maxWidth: 100, maxHeight: 100).clipShape(Circle()).overlay(Circle().stroke(Color.blue, lineWidth: 6)).shadow(color: Color.blue, radius: 20).offset(x:-350)
            
        }.frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
        
    }
}

struct ImageView_Previews: PreviewProvider {
    static var previews: some View {
        ImageView()
    }
}
