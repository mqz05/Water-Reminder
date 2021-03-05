//
//  ContentView.swift
//  Water Reminder
//
//  Created by Mu qi Zhang on 05/03/2021.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 20) {
            Text("Hello, world!")
                .font(.largeTitle)
                .fontWeight(.heavy)
                .foregroundColor(Color.orange)
                .multilineTextAlignment(.center)
                .padding()
            
            Spacer()
            
            ZStack {
                Text("")
                    .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                    .background(Color.green)
                    .padding()
                Text("")
                    .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                    .background(Color.purple)
                    .padding(90)
                Text("")
                    .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                    .background(Color.yellow)
                    .padding(180)
                Text("")
                    .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                    .background(Color.red)
                    .padding(270)
            }
            
            Spacer()
            
            HStack {
                Text("This is my amzing app")
                    .font(.body)
                    .padding()
                
                Spacer()
                
                Text("Water Reminder!")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(Color.blue)
                    .padding()
            }
            
        }.frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
        .background(Color.gray)
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
