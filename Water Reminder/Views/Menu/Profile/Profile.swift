//
//  Profile.swift
//  Water Reminder
//
//  Created by Mu qi Zhang on 9/8/21.
//

import SwiftUI


//
// MARK: Perfil del Usuario
//

struct Profile: View {
    
    @EnvironmentObject var firebaseViewModel: FirebaseViewModel
    
    var body: some View {
        
        VStack(alignment: .leading) {
            
            Image("Imagen Prueba")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 120, height: 120)
                .cornerRadius(10)
            
            VStack(alignment: .leading, spacing: 4) {
                
                Text(firebaseViewModel.isLogedIn ? firebaseViewModel.userData.nickname : "Default")
                    .font(.title)
                    .fontWeight(.heavy)
                    .foregroundColor(.white)
                
                HStack(spacing: 4) {
                    Image("Imagen Prueba"/* Emblem */)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 20, height: 20)
                        .cornerRadius(5)
                    
                    Text(firebaseViewModel.isLogedIn ? firebaseViewModel.userData.level : "Beginner")
                        .fontWeight(.semibold)
                        .opacity(0.7)
                        .foregroundColor(.white)
                }
            }.scaleEffect(1.2)
            .padding(.leading, 10)
            .padding(.top, 6)
        }
    }
}
