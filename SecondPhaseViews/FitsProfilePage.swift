//
//  FitsProfilePage.swift
//  GlowGirl
//
//  Created by Archita Nemalikanti on 7/29/25.
//

import SwiftUI

// MARK: - Fits Profile Page, for now we will add Deepika's stuff here.
struct FitsProfilePage: View {
    let profile: UserProfile
    @State private var sparkleOffset: CGFloat = 0
    @State private var currentVibe: VibeTheme = .elegant // Temporary for testing
    
    // Get the assigned vibe for this profile (only one per person)
    var assignedVibe: VibeTheme {
        getVibeForProfile(profile)
    }
    
    var body: some View {
        ZStack {
            DeepikaGlamView()
        }
    }
    
    // Function to determine vibe based on profile (this is where your backend logic goes)
    private func getVibeForProfile(_ profile: UserProfile) -> VibeTheme {
        // This is where you'd implement the vector embedding logic
        // For now, using a simple mapping - replace with your backend logic
        switch profile.name {
        case "archita":
            return .elegant
        case "priya":
            return .glamorous
        case "maya":
            return .natural
        case "zara":
            return .adventurous
        case "luna":
            return .luxury
        case "nova":
            return .bold
        default:
            return .elegant
        }
    }
}


#Preview {
    FitsProfilePage(profile: UserProfile(
        name: "archita",
        nakshatra: "ashwini",
        currentMood: "super pumped ✨",
        currentStatus: "locked in for apple internship",
        isEmotionallyAvailable: false,
        recentVent: "finally getting over aditya and focusing on my career glow up",
        lifeEvents: []
    ))
}
