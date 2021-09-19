//
//  Water_ReminderApp.swift
//  Water Reminder
//
//  Created by Mu qi Zhang on 05/03/2021.
//

import SwiftUI
import Firebase

@main
struct Water_ReminderApp: App {
    
    @StateObject var firebaseViewModel = FirebaseViewModel()
    @StateObject var waveViewModel = WaveViewModel()
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(firebaseViewModel)
                .environmentObject(waveViewModel)
                .onAppear {
                    firebaseViewModel.loggedIn = firebaseViewModel.isLogedIn
                }
        }
    }
}

extension Color {
    
    static let primaryBlue = Color("PrimaryBlue")
    static let primaryDarkBlue = Color("PrimaryDarkBlue")
    static let primaryLightBlue1 = Color("PrimaryLightBlue1")
    static let primaryLightBlue2 = Color("PrimaryLightBlue2")
    
    static let secondaryBlue = Color("SecondaryBlue")
    static let secondaryDarkBlue = Color("SecondaryDarkBlue")
    static let secondaryLightBlue = Color("SecondaryLightBlue")
    
    static let purple = Color("Purple")
    static let lightPurple = Color("LightPurple")
    
    static let magenta = Color("Magenta")
}
