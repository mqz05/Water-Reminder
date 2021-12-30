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
    @StateObject var statisticsViewModel = StatisticsViewModel()
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(firebaseViewModel)
                .environmentObject(waveViewModel)
                .environmentObject(statisticsViewModel)
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
    static let primaryLightBlue3 = Color("PrimaryLightBlue3")
    
    static let secondaryBlue = Color("SecondaryBlue")
    static let secondaryDarkBlue1 = Color("SecondaryDarkBlue1")
    static let secondaryDarkBlue2 = Color("SecondaryDarkBlue2")
    static let secondaryLightBlue1 = Color("SecondaryLightBlue1")
    static let secondaryLightBlue2 = Color("SecondaryLightBlue2")
    
    static let purple = Color("Purple")
    static let lightPurple = Color("LightPurple1")
    static let lightPurple2 = Color("LightPurple2")
    
    static let purpleMagenta = Color("PurpleMagenta")
    
    static let magenta = Color("Magenta")
    static let lightMagenta = Color("LightMagenta")
    
    static let orange1 = Color("Orange1")
    static let orange2 = Color("Orange2")
    static let orange3 = Color("Orange3")
    static let orange4 = Color("Orange4")
    static let orange5 = Color("Orange5")
    static let orange6 = Color("Orange6")
    static let orange7 = Color("Orange7")
    static let orange8 = Color("Orange8")
    static let orange9 = Color("Orange9")
    static let orange10 = Color("Orange10")
}
