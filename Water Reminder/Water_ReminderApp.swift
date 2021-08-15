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
