//
//  MessageBubble.swift
//  GlowGirl
//
//  Created by Archita Nemalikanti on 6/23/25.
//

import SwiftUI

// MARK: - Analyzing View
struct AnalyzingView: View {
    @EnvironmentObject var glowViewModel: GlowGirlViewModel
    @State private var breathingAnimation = false
    @State private var sparkleAnimation = false
    @State private var currentStep = 0
    
    let glowSteps = [
        "reading ur tea 👀",
        "mixing the perfect vibes ✨",
        "brewing ur glow up 💅",
        "serving looks bestie 💋"
    ]
    
    var body: some View {
        ZStack {
            // Multi-layer dreamy background
            ZStack {
                RadialGradient(
                    colors: [Color.pink.opacity(0.4), Color.purple.opacity(0.2), Color.clear],
                    center: .topLeading,
                    startRadius: 80,
                    endRadius: 400
                )
                
                RadialGradient(
                    colors: [Color.orange.opacity(0.3), Color.pink.opacity(0.2), Color.clear],
                    center: .bottomTrailing,
                    startRadius: 120,
                    endRadius: 500
                )
                
                // Subtle floating elements - more mature
                ForEach(0..<4, id: \.self) { index in
                    Circle()
                        .fill(
                            RadialGradient(
                                colors: [.pink.opacity(0.3), .purple.opacity(0.1), .clear],
                                center: .center,
                                startRadius: 5,
                                endRadius: 15
                            )
                        )
                        .frame(width: CGFloat.random(in: 20...40))
                        .position(
                            x: CGFloat.random(in: 80...320),
                            y: CGFloat.random(in: 150...550)
                        )
                        .opacity(sparkleAnimation ? 0.6 : 0.2)
                        .scaleEffect(sparkleAnimation ? 1.1 : 0.9)
                        .animation(
                            .easeInOut(duration: Double.random(in: 3...5))
                            .repeatForever(autoreverses: true)
                            .delay(Double(index) * 0.5),
                            value: sparkleAnimation
                        )
                }
            }
            .ignoresSafeArea()
            
            VStack(spacing: 0) {
                Spacer()
                
                // Main content centered
                VStack(spacing: 40) {
                    // Breathing heart animation
                    ZStack {
                        // Outer glow rings
                        ForEach(0..<3, id: \.self) { ring in
                            Circle()
                                .stroke(
                                    LinearGradient(
                                        colors: [.pink.opacity(0.3), .purple.opacity(0.2)],
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                    ),
                                    lineWidth: 2
                                )
                                .frame(width: 140 + CGFloat(ring * 20))
                                .scaleEffect(breathingAnimation ? 1.1 : 0.9)
                                .opacity(breathingAnimation ? 0.3 : 0.6)
                                .animation(
                                    .easeInOut(duration: 2.0)
                                    .repeatForever(autoreverses: true)
                                    .delay(Double(ring) * 0.2),
                                    value: breathingAnimation
                                )
                        }
                        
                        // Main heart
                        Image(systemName: "heart.fill")
                            .font(.system(size: 60, weight: .bold))
                            .foregroundStyle(
                                LinearGradient(
                                    colors: [.pink, .purple, .orange.opacity(0.8)],
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                )
                            )
                            .shadow(color: .pink.opacity(0.4), radius: 20, x: 0, y: 10)
                            .scaleEffect(breathingAnimation ? 1.15 : 1.0)
                            .animation(
                                .easeInOut(duration: 1.5)
                                .repeatForever(autoreverses: true),
                                value: breathingAnimation
                            )
                    }
                    
                    // Status text with typing animation
                    VStack(spacing: 20) {
                        Text("analyzing ur tea bestie")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundStyle(
                                LinearGradient(
                                    colors: [.pink, .purple],
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )
                            .shadow(color: .pink.opacity(0.3), radius: 8, x: 0, y: 4)
                        
                        // Current step with smooth transition
                        Text(glowSteps[currentStep])
                            .font(.headline)
                            .foregroundColor(.purple.opacity(0.9))
                            .transition(.asymmetric(
                                insertion: .move(edge: .bottom).combined(with: .opacity),
                                removal: .move(edge: .top).combined(with: .opacity)
                            ))
                            .animation(.spring(response: 0.6, dampingFraction: 0.8), value: currentStep)
                        
                        // Dots animation
                        HStack(spacing: 8) {
                            ForEach(0..<3, id: \.self) { dot in
                                Circle()
                                    .fill(
                                        LinearGradient(
                                            colors: [.pink, .purple],
                                            startPoint: .topLeading,
                                            endPoint: .bottomTrailing
                                        )
                                    )
                                    .frame(width: 12, height: 12)
                                    .scaleEffect(breathingAnimation ? 1.2 : 0.8)
                                    .animation(
                                        .easeInOut(duration: 0.6)
                                        .repeatForever(autoreverses: true)
                                        .delay(Double(dot) * 0.2),
                                        value: breathingAnimation
                                    )
                            }
                        }
                        .padding(.top, 10)
                    }
                }
                
                Spacer()
                
                // Bottom cute message
                VStack(spacing: 8) {
                    Text("✨ ur about to be so iconic ✨")
                        .font(.subheadline)
                        .foregroundColor(.purple.opacity(0.8))
                    
                    Text("trust the process babe 💅")
                        .font(.caption)
                        .foregroundColor(.pink.opacity(0.7))
                }
                .padding(.bottom, 40)
            }
        }
        .onAppear {
            breathingAnimation = true
            sparkleAnimation = true
            startStepAnimation()
        }
    }
    
    private func startStepAnimation() {
        Timer.scheduledTimer(withTimeInterval: 2.0, repeats: true) { _ in
            withAnimation(.spring(response: 0.6, dampingFraction: 0.8)) {
                currentStep = (currentStep + 1) % glowSteps.count
            }
        }
    }
}

#Preview {
    AnalyzingView()
        .environmentObject(GlowGirlViewModel())
}

// MARK: - Recommendations View
struct RecommendationsView: View {
    @EnvironmentObject var glowViewModel: GlowGirlViewModel
    
    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(
                    colors: [Color.pink.opacity(0.1), Color.purple.opacity(0.1)],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing)
                .ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: 25) {
                        // Header
                        VStack(spacing: 15) {
                            Text("Your Glow-Up Plan ✨")
                                .font(.largeTitle)
                                .fontWeight(.bold)
                                .foregroundColor(.pink)
                            
                            Text("Based on your tea, here's how to slay! 💅")
                                .font(.headline)
                                .foregroundColor(.purple)
                                .multilineTextAlignment(.center)
                        }
                        .padding(.top)
                        
                        // AI Message
                        if let glowUpResponse = glowViewModel.glowUpResponse {
                            VStack(alignment: .leading, spacing: 15) {
                                Text("Your Personal Message 💕")
                                    .font(.title2)
                                    .fontWeight(.bold)
                                    .foregroundColor(.pink)
                                
                                Text(glowUpResponse.message)
                                    .font(.body)
                                    .foregroundColor(.purple)
                                    .multilineTextAlignment(.leading)
                                    .padding()
                                    .background(
                                        RoundedRectangle(cornerRadius: 12)
                                            .fill(.white.opacity(0.5))
                                    )
                            }
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 15)
                                    .fill(.white.opacity(0.3))
                                    .shadow(color: .pink.opacity(0.2), radius: 10, x: 0, y: 5)
                            )
                            .padding(.horizontal)
                            
                            // Quick Wins Section
                            if !glowUpResponse.quickWins.isEmpty {
                                VStack(alignment: .leading, spacing: 15) {
                                    Text("Quick Wins 🚀")
                                        .font(.title2)
                                        .fontWeight(.bold)
                                        .foregroundColor(.pink)
                                    
                                    VStack(spacing: 8) {
                                        ForEach(Array(glowUpResponse.quickWins.enumerated()), id: \.offset) { index, quickWin in
                                            HStack(alignment: .top) {
                                                Text("\(index + 1).")
                                                    .font(.headline)
                                                    .foregroundColor(.pink)
                                                    .fontWeight(.bold)
                                                
                                                Text(quickWin)
                                                    .font(.body)
                                                    .foregroundColor(.purple)
                                                    .multilineTextAlignment(.leading)
                                                
                                                Spacer()
                                            }
                                            .padding(.vertical, 2)
                                        }
                                    }
                                }
                                .padding()
                                .background(
                                    RoundedRectangle(cornerRadius: 15)
                                        .fill(.white.opacity(0.3))
                                        .shadow(color: .pink.opacity(0.2), radius: 10, x: 0, y: 5)
                                )
                                .padding(.horizontal)
                            }
                            
                            // Transformation Plan
                            if !glowUpResponse.transformationPlan.isEmpty {
                                VStack(alignment: .leading, spacing: 15) {
                                    Text("Your Transformation Plan 🦋")
                                        .font(.title2)
                                        .fontWeight(.bold)
                                        .foregroundColor(.pink)
                                    
                                    Text(glowUpResponse.transformationPlan)
                                        .font(.body)
                                        .foregroundColor(.purple)
                                        .multilineTextAlignment(.leading)
                                        .padding()
                                        .background(
                                            RoundedRectangle(cornerRadius: 12)
                                                .fill(.white.opacity(0.5))
                                        )
                                }
                                .padding()
                                .background(
                                    RoundedRectangle(cornerRadius: 15)
                                        .fill(.white.opacity(0.3))
                                        .shadow(color: .pink.opacity(0.2), radius: 10, x: 0, y: 5)
                                )
                                .padding(.horizontal)
                            }
                            
                            // Makeup Recommendations
                            if !glowUpResponse.makeupRecommendations.isEmpty {
                                ProductRecommendationSection(
                                    title: "Makeup Recommendations 💄",
                                    icon: "paintbrush.fill",
                                    recommendations: glowUpResponse.makeupRecommendations
                                )
                            }
                            
                            // Outfit Recommendations
                            if !glowUpResponse.outfitRecommendations.isEmpty {
                                ProductRecommendationSection(
                                    title: "Outfit Recommendations 👗",
                                    icon: "tshirt.fill",
                                    recommendations: glowUpResponse.outfitRecommendations
                                )
                            }
                        }
                        
                        // Start Over Button
                        Button(action: {
                            print("reset analysis called in the start over button")
                            glowViewModel.resetAnalysis()
                        }) {
                            HStack {
                                Image(systemName: "heart.fill")
                                Text("Vent Again! 💕")
                                    .fontWeight(.bold)
                            }
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 20)
                            .background(
                                RoundedRectangle(cornerRadius: 25)
                                    .fill(
                                        LinearGradient(
                                            colors: [.pink, .purple],
                                            startPoint: .leading,
                                            endPoint: .trailing
                                        )
                                    )
                                    .shadow(color: .pink.opacity(0.3), radius: 10, x: 0, y: 5)
                            )
                        }
                        .padding(.horizontal)
                        .padding(.top, 20)                    }
                    .padding(.bottom)
                }
            }
            .navigationTitle("")
            .navigationBarHidden(true)
        }
    }
}

// MARK: - Product Recommendation Section
struct ProductRecommendationSection: View {
    let title: String
    let icon: String
    let recommendations: [ProductRecommendation]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            HStack {
                Image(systemName: icon)
                    .foregroundColor(.pink)
                    .font(.title2)
                
                Text(title)
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.pink)
            }
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 15) {
                    ForEach(recommendations, id: \.id) { recommendation in
                        ProductRecommendationCard(recommendation: recommendation)
                    }
                }
                .padding(.horizontal)
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 15)
                .fill(.white.opacity(0.3))
                .shadow(color: .pink.opacity(0.1), radius: 5, x: 0, y: 2)
        )
        .padding(.horizontal)
    }
}

// MARK: - Product Recommendation Card
struct ProductRecommendationCard: View {
    let recommendation: ProductRecommendation
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            // Product Image Placeholder
            RoundedRectangle(cornerRadius: 15)
                .fill(
                    LinearGradient(
                        colors: [.pink.opacity(0.3), .purple.opacity(0.3)],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .frame(width: 180, height: 120)
                .overlay(
                    Image(systemName: "sparkles")
                        .font(.system(size: 30))
                        .foregroundColor(.pink)
                )
            
            VStack(alignment: .leading, spacing: 8) {
                Text(recommendation.product)
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundColor(.pink)
                    .lineLimit(2)
                
                Text(recommendation.price)
                    .font(.subheadline)
                    .foregroundColor(.purple)
                    .fontWeight(.semibold)
                
                Text(recommendation.whyPerfect)
                    .font(.caption)
                    .foregroundColor(.purple.opacity(0.8))
                    .lineLimit(3)
                
                Text(recommendation.confidenceBoost)
                    .font(.caption)
                    .foregroundColor(.pink.opacity(0.8))
                    .lineLimit(2)
                    .italic()
                
                Text(recommendation.stylingTip)
                    .font(.caption)
                    .foregroundColor(.purple.opacity(0.7))
                    .lineLimit(2)
                    .padding(.top, 2)
                
                // Link button (if you want to make it clickable)
                if !recommendation.link.isEmpty {
                    Button(action: {
                        if let url = URL(string: recommendation.link) {
                            UIApplication.shared.open(url)
                        }
                    }) {
                        HStack {
                            Image(systemName: "link")
                            Text("View Product")
                        }
                        .font(.caption)
                        .foregroundColor(.pink)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(
                            RoundedRectangle(cornerRadius: 8)
                                .fill(.pink.opacity(0.1))
                        )
                    }
                }
            }
        }
        .frame(width: 180)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(.white.opacity(0.8))
                .shadow(color: .pink.opacity(0.2), radius: 10, x: 0, y: 5)
        )
    }
}

//// MARK: - Recommendation Section
//struct RecommendationSection: View {
//    let category: RecommendationType
//    let recommendations: [BeautyRecommendation]
//    
//    var body: some View {
//        VStack(alignment: .leading, spacing: 15) {
//            HStack {
//                Image(systemName: categoryIcon(for: category))
//                    .foregroundColor(.pink)
//                    .font(.title2)
//                
//                Text(category.rawValue)
//                    .font(.title2)
//                    .fontWeight(.bold)
//                    .foregroundColor(.pink)
//            }
//            
//            ScrollView(.horizontal, showsIndicators: false) {
//                HStack(spacing: 15) {
//                    ForEach(recommendations) { rec in
//                        RecommendationCard(recommendation: rec)
//                    }
//                }
//                .padding(.horizontal)
//            }
//        }
//        .padding()
//        .background(
//            RoundedRectangle(cornerRadius: 15)
//                .fill(.white.opacity(0.3))
//                .shadow(color: .pink.opacity(0.1), radius: 5, x: 0, y: 2)
//        )
//    }
//    
//    private func categoryIcon(for category: RecommendationType) -> String {
//        switch category {
//        case .makeup:
//            return "paintbrush.fill"
//        case .skincare:
//            return "drop.fill"
//        case .haircare:
//            return "scissors"
//        case .hairdye:
//            return "paintpalette.fill"
//        case .clothing:
//            return "tshirt.fill"
//        }
//    }
//}

// MARK: - Recommendation Card
struct RecommendationCard: View {
    let recommendation: BeautyRecommendation
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            // Product Image Placeholder
            RoundedRectangle(cornerRadius: 15)
                .fill(
                    LinearGradient(
                        colors: [.pink.opacity(0.3), .purple.opacity(0.3)],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .frame(width: 160, height: 120)
                .overlay(
                    Image(systemName: "sparkles")
                        .font(.system(size: 30))
                        .foregroundColor(.pink)
                )
            
            VStack(alignment: .leading, spacing: 8) {
                Text(recommendation.title)
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundColor(.pink)
                    .lineLimit(2)
                
                Text(recommendation.description)
                    .font(.subheadline)
                    .foregroundColor(.purple)
                    .lineLimit(3)
                
                if let price = recommendation.price {
                    Text(price)
                        .font(.headline)
                        .foregroundColor(.pink)
                        .fontWeight(.bold)
                }
                
                Text(recommendation.reasoning)
                    .font(.caption)
                    .foregroundColor(.purple.opacity(0.7))
                    .lineLimit(2)
            }
        }
        .frame(width: 160)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(.white.opacity(0.8))
                .shadow(color: .pink.opacity(0.2), radius: 10, x: 0, y: 5)
        )
    }
}
