//
//  FreeModeView.swift
//  Water Reminder
//
//  Created by Mu qi Zhang on 07/03/2021.
//

import SwiftUI

struct FreeModeView: View {
    var body: some View {
        
        ZStack {
            BackgroundView(topColor: Color(#colorLiteral(red: 0.4080183647, green: 0.6348306513, blue: 1, alpha: 1)), bottomColor: Color(#colorLiteral(red: 0.1829789287, green: 0.2423677345, blue: 1, alpha: 1)), isHorizontal: false)
            Text("Free Mode")
        }
    }
}

struct FreeModeView_Previews: PreviewProvider {
    static var previews: some View {
        FreeModeView()
    }
}
