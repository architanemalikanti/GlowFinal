//
//  DeepikaOutfitCard.swift
//  GlowGirl
//
//  Created by Archita Nemalikanti on 7/30/25.
//

import SwiftUI

// MARK: - Deepika Outfit Card
struct DeepikaOutfitCard: View {
    let outfit: Outfit
    @State private var isLiked = false
    
    var imageName: String {
        switch outfit.name {
        case "princess polly halter mini dress":
            return "DeepikaDress"
        case "sparkly heels for the win":
            return "DeepikaShoes"
        case "statement earrings moment":
            return "DeepikaEarrings"
        case "golden bangles stack":
            return "DeepikaBangles"
        case "diamond rings collection":
            return "DeepikaRings"
        case "luxury bag essentials":
            return "DeepikaBag"
        default:
            return "DeepikaDress"
        }
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            // Header
            HStack {
                Text(outfit.name)
                    .font(.title3)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                Spacer()
                Button(action: { isLiked.toggle() }) {
                    Image(systemName: isLiked ? "heart.fill" : "heart")
                        .foregroundColor(isLiked ? .pink : Color(red: 1.0, green: 0.6, blue: 0.8))
                        .font(.title2)
                }
            }
            
            // Single Image
            VStack(spacing: 12) {
                Image(imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: .infinity)
                    .frame(height: 300)
                    .cornerRadius(20)
                    .shadow(color: Color.black.opacity(0.3), radius: 10, x: 0, y: 5)
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color.white.opacity(0.2), lineWidth: 1)
                    )
                
                Text("this is the dress you wear after the ef matcha event when rishi from waterloo called you shy and you realized you're actually just too powerful for small talk 🪩💅🏼🫖✨")
                    .font(.caption)
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
                    }
                }
                .padding(20)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(
                    LinearGradient(
                        colors: [
                            Color(red: 0.3, green: 0.2, blue: 0.4),
                            Color(red: 0.5, green: 0.3, blue: 0.6)
                        ],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(
                            LinearGradient(
                                colors: outfit.colorScheme,
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            ),
                            lineWidth: 1
                        )
                )
        )
        .padding(.horizontal, 20)
    }
}


#Preview {
    DeepikaOutfitCard(outfit: Outfit(
        name: "princess polly halter mini dress",
        emoji: "🪩",
        description: "giving main character energy with that iconic disco glam aesthetic",
        vibe: "sparkly queen",
        items: ["disco ball dress", "sparkly jewelry", "glitter heels", "shimmer makeup"],
        price: "$$$$$",
        category: "Disco",
        colorScheme: [Color(red: 0.8, green: 0.8, blue: 1.0), Color(red: 1.0, green: 0.9, blue: 0.8)]
    ))
}
