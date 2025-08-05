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
