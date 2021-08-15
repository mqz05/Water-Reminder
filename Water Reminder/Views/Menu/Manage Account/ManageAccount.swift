//
//  ManageAccount.swift
//  Water Reminder
//
//  Created by Mu qi Zhang on 9/8/21.
//

import SwiftUI


//
// MARK: Cuenta de Usuario
//

struct ManageAccount: View {
    
    @EnvironmentObject var firebaseViewModel: FirebaseViewModel
    
    @Binding var showLogOutNotification: Bool
    
    var body: some View {
        
        if firebaseViewModel.loggedIn {
            Button(action: {
                showLogOutNotification = true
                firebaseViewModel.logOut()
                
                
            }, label: {
                HStack(spacing: 15) {
                    Image(systemName: "rectangle.righthalf.inset.fill.arrow.right").resizable().frame(width: 35, height: 26.25).foregroundColor(.white)
                    
                    Text("Log Out")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                }
            })
            
        } else {
            
            NavigationLink(destination: AccountView().frame(width: 834, height: 1400).clipped(), label: {
                HStack(spacing: 15) {
                    Image(systemName: "rectangle.righthalf.inset.fill.arrow.right").resizable().frame(width: 35, height: 26.25).foregroundColor(.white)
                    
                    Text("Log In")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                }
            })
        }
    }
}
