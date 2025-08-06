//
//  IntroductionPage.swift
//  GlowGirl
//
//  Created by Archita Nemalikanti on 8/3/25.
//

import SwiftUI

struct HeartParticle {
    let id = UUID()
    var x: CGFloat
    var y: CGFloat
    var size: CGFloat
    var opacity: Double
    var scale: CGFloat
    var duration: Double
}

struct IntroductionPage: View {
    @State private var showHeartAnimation = false
    @State private var navigateToChatbot = false
    @State private var hearts: [HeartParticle] = []
    
    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(
                    colors: [Color.pink, Color.purple],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing)
                .ignoresSafeArea()
                
                if !showHeartAnimation {
                    VStack(spacing: 40) {
                        VStack(spacing: 20) {
                            Image(systemName: "sparkles")
                                .imageScale(.large)
                                .foregroundStyle(.white)
                            Text("welcome to glow!")
                                .foregroundColor(.white)
                                .font(.title2)
                                .bold()
                        }
                        
                        // Cute pink girly button
                        Button(action: {
                            startHeartAnimation()
                        }) {
                            HStack {
                                Image(systemName: "heart.fill")
                                    .foregroundColor(.pink)
                                Text("start your glow up journey")
                                    .fontWeight(.semibold)
                                    .foregroundColor(.pink)
                                Image(systemName: "arrow.right.heart.fill")
                                    .foregroundColor(.pink)
                            }
                            .padding(.horizontal, 30)
                            .padding(.vertical, 15)
                            .background(
                                RoundedRectangle(cornerRadius: 25)
                                    .fill(.white)
                                    .shadow(color: .pink.opacity(0.3), radius: 10, x: 0, y: 5)
                            )
                            .overlay(
                                RoundedRectangle(cornerRadius: 25)
                                    .stroke(
                                        LinearGradient(
                                            colors: [.pink.opacity(0.5), .purple.opacity(0.3)],
                                            startPoint: .leading,
                                            endPoint: .trailing
                                        ),
                                        lineWidth: 2
                                    )
                            )
                            .scaleEffect(1.0)
                            .animation(.easeInOut(duration: 0.1), value: false)
                        }
                        .buttonStyle(PlainButtonStyle())
                        .onTapGesture {
                            // Optional: Add haptic feedback
                            let impact = UIImpactFeedbackGenerator(style: .heavy)
                            impact.impactOccurred()
                        }
                    }
                }
                
                // Heart animation overlay
                if showHeartAnimation {
                    ForEach(hearts, id: \.id) { heart in
                        Text("💖")
                            .font(.system(size: heart.size))
                            .position(x: heart.x, y: heart.y)
                            .opacity(heart.opacity)
                            .scaleEffect(heart.scale)
                            .animation(.easeInOut(duration: heart.duration), value: heart.scale)
                    }
                }
            }
            .fullScreenCover(isPresented: $navigateToChatbot) {
                ChatbotSignUpPage()
            }
        }
    }
    
    private func startHeartAnimation() {
        // Haptic feedback
        let impact = UIImpactFeedbackGenerator(style: .heavy)
        impact.impactOccurred()
        
        showHeartAnimation = true
        
        // Create hearts that fill the screen
        hearts = []
        let screenWidth = UIScreen.main.bounds.width
        let screenHeight = UIScreen.main.bounds.height
        
        // Generate 1000 HEARTS - ABSOLUTE UNHINGED CHAOS! 💖💖💖💖💖
        for _ in 0..<1000 {
            let heart = HeartParticle(
                x: CGFloat.random(in: 0...screenWidth),
                y: CGFloat.random(in: 0...screenHeight),
                size: CGFloat.random(in: 25...80),
                opacity: Double.random(in: 0.7...1.0),
                scale: 0.1,
                duration: Double.random(in: 0.2...1.0)
            )
            hearts.append(heart)
        }
        
        // Animate hearts scaling up
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            withAnimation {
                for i in 0..<hearts.count {
                    hearts[i].scale = Double.random(in: 1.0...1.5)
                }
            }
        }
        
        // Navigate to chatbot after animation
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            navigateToChatbot = true
        }
    }

}


#Preview {
    IntroductionPage()
}
