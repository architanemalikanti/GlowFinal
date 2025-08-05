//
//  DeepikaGlamView.swift
//  GlowGirl
//
//  Created by Archita Nemalikanti on 7/30/25.
//

import SwiftUI
// MARK: - Deepika Glam View
struct DeepikaGlamView: View {
    @State private var deepikaOutfits: [Outfit] = [
        Outfit(
            name: "princess polly halter mini dress",
            emoji: "🪩",
            description: "giving main character energy with that iconic disco glam aesthetic",
            vibe: "sparkly queen",
            items: ["disco ball dress", "sparkly jewelry", "glitter heels", "shimmer makeup"],
            price: "$$$$$",
            category: "Disco",
            colorScheme: [Color(red: 0.8, green: 0.8, blue: 1.0), Color(red: 1.0, green: 0.9, blue: 0.8)]
            
            
        ),
        Outfit(
            name: "sparkly heels for the win",
            emoji: "👑",
            description: "shimmery fits for when you're literally the moment",
            vibe: "cinematic glamour",
            items: ["sequin saree", "diamond jewelry", "sparkly dupatta", "glitter accessories"],
            price: "$$$$$",
            category: "Cinema",
            colorScheme: [Color(red: 1.0, green: 0.8, blue: 0.9), Color(red: 0.9, green: 0.7, blue: 1.0)]
        ),
        Outfit(
            name: "statement earrings moment",
            emoji: "🌟",
            description: "camera-ready glamour with that international star energy",
            vibe: "global icon",
            items: ["designer gown", "statement jewelry", "red carpet heels", "luxury clutch"],
            price: "$$$$$",
            category: "Red Carpet",
            colorScheme: [Color(red: 0.9, green: 0.6, blue: 0.8), Color(red: 1.0, green: 0.8, blue: 0.9)]
        ),
        Outfit(
            name: "golden bangles stack",
            emoji: "💫",
            description: "sparkly vibes for when you're the main event",
            vibe: "radiant beauty",
            items: ["shimmer dress", "crystal jewelry", "sparkly shoes", "glitter makeup"],
            price: "$$$$",
            category: "Party",
            colorScheme: [Color(red: 1.0, green: 0.9, blue: 0.8), Color(red: 0.8, green: 0.8, blue: 1.0)]
        ),
        Outfit(
            name: "diamond rings collection",
            emoji: "🎭",
            description: "dramatic elegance with that show-stopping energy",
            vibe: "dramatic queen",
            items: ["evening gown", "diamond necklace", "sparkly heels", "luxury bag"],
            price: "$$$$$",
            category: "Evening",
            colorScheme: [Color(red: 0.7, green: 0.5, blue: 0.8), Color(red: 1.0, green: 0.8, blue: 0.9)]
        ),
        Outfit(
            name: "luxury bag essentials",
            emoji: "✨",
            description: "timeless sparkle with that iconic diva energy",
            vibe: "timeless glamour",
            items: ["sparkly lehenga", "traditional jewelry", "glitter accessories", "shimmer dupatta"],
            price: "$$$$$",
            category: "Traditional",
            colorScheme: [Color(red: 1.0, green: 0.8, blue: 0.0), Color(red: 0.9, green: 0.7, blue: 1.0)]
        )
    ]
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack(spacing: 25) {
                    // Header
                    VStack(alignment: .leading, spacing: 12) {
                        HStack {
                            Text("ur a girl written by")
                                .font(.title2)
                                .fontWeight(.light)
                            .foregroundColor(.white)
                            Spacer()
                            //Text("🪩✨💫")
                                //.font(.title)
                        }
                        Text("deepika! 🪩✨💫")
                            .font(.system(size: 42, weight: .bold, design: .serif))
                            .foregroundColor(Color(red: 0.9, green: 0.7, blue: 1.0))
                        //Text("u are the life of the party rn")
                            //.font(.subheadline)
                            //.foregroundColor(.gray)
                            //.italic()
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 20)
                    
                    // Outfit Cards
                    ForEach(deepikaOutfits, id: \.id) { outfit in
                        DeepikaOutfitCard(outfit: outfit)
                    }
                }
            }
            .background(
                LinearGradient(
                    colors: [
                        Color(red: 0.3, green: 0.2, blue: 0.4),
                        Color(red: 0.5, green: 0.3, blue: 0.6)
                    ],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
            )
            .navigationBarHidden(true)
        }
    }
}


#Preview {
    DeepikaGlamView()
}
