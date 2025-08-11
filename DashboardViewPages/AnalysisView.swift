import SwiftUI

struct AnalysisView: View {
    @EnvironmentObject var viewModel: GlowGirlViewModel
    @State private var teaCupRotation: Double = 0
    @State private var sparkleOpacity: Double = 0
    @State private var bubbleOffset: CGFloat = 0
    @State private var loadingText = "analyzing ur tea..."
    @State private var textIndex = 0
    
    let loadingMessages = [
        "analyzing ur tea...",
        "reading ur vibe...",
        "finding ur matches...",
        "brewing some magic...",
        "almost ready bestie..."
    ]
    
    var body: some View {
        ZStack {
            // Dreamy background
            LinearGradient(
                colors: [
                    Color.pink.opacity(0.1),
                    Color.purple.opacity(0.05),
                    Color.orange.opacity(0.08),
                    Color.pink.opacity(0.12)
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            if viewModel.isLoading {
                // Cute loading animation
                VStack(spacing: 40) {
                    Spacer()
                    
                    // Animated tea cup with sparkles
                    ZStack {
                        // Sparkles around tea cup
                        ForEach(0..<8, id: \.self) { index in
                            Circle()
                                .fill(Color.pink.opacity(sparkleOpacity))
                                .frame(width: 4, height: 4)
                                .offset(
                                    x: cos(Double(index) * .pi / 4) * 60,
                                    y: sin(Double(index) * .pi / 4) * 60
                                )
                                .scaleEffect(sparkleOpacity)
                        }
                        
                        // Tea cup emoji with rotation
                        Text("🍵")
                            .font(.system(size: 80))
                            .rotationEffect(.degrees(teaCupRotation))
                            .scaleEffect(1.0 + sin(teaCupRotation * .pi / 180) * 0.1)
                    }
                    
                    // Cute loading text
                    VStack(spacing: 15) {
                        Text(loadingText)
                            .font(.title2)
                            .fontWeight(.medium)
                            .foregroundStyle(
                                LinearGradient(
                                    colors: [.pink, .purple, .orange],
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )
                            .textCase(.lowercase)
                            .multilineTextAlignment(.center)
                        
                        // Animated dots
                        HStack(spacing: 8) {
                            ForEach(0..<3, id: \.self) { index in
                                Circle()
                                    .fill(Color.purple.opacity(0.6))
                                    .frame(width: 8, height: 8)
                                    .scaleEffect(bubbleOffset == CGFloat(index) ? 1.3 : 0.8)
                                    .animation(
                                        .easeInOut(duration: 0.6)
                                        .repeatForever()
                                        .delay(Double(index) * 0.2),
                                        value: bubbleOffset
                                    )
                            }
                        }
                    }
                    
                    Spacer()
                    
                    // Progress indicator
                    VStack(spacing: 10) {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: .pink))
                            .scaleEffect(1.2)
                        
                        Text("hold tight babe, magic is happening ✨")
                            .font(.caption)
                            .foregroundColor(.purple.opacity(0.7))
                            .textCase(.lowercase)
                    }
                    
                    Spacer()
                }
                .onAppear {
                    startAnimations()
                }
            } else {
                // Show dating recommendations when loading is done
                DatingRecommendationView()
                    .environmentObject(viewModel)
                    .transition(.asymmetric(
                        insertion: .move(edge: .trailing).combined(with: .opacity),
                        removal: .move(edge: .leading).combined(with: .opacity)
                    ))
            }
        }
        .animation(.easeInOut(duration: 0.8), value: viewModel.isLoading)
    }
    
    private func startAnimations() {
        // Tea cup rotation
        withAnimation(.linear(duration: 3).repeatForever(autoreverses: false)) {
            teaCupRotation = 360
        }
        
        // Sparkle animation
        withAnimation(.easeInOut(duration: 1.5).repeatForever(autoreverses: true)) {
            sparkleOpacity = 1.0
        }
        
        // Bubble animation
        withAnimation(.easeInOut(duration: 1.8).repeatForever()) {
            bubbleOffset = 2
        }
        
        // Text cycling
        Timer.scheduledTimer(withTimeInterval: 2.0, repeats: true) { _ in
            withAnimation(.easeInOut(duration: 0.5)) {
                textIndex = (textIndex + 1) % loadingMessages.count
                loadingText = loadingMessages[textIndex]
            }
        }
    }
}

// MARK: - Color Extensions
extension Color {
    static let cream = Color(red: 0.98, green: 0.96, blue: 0.92)
    static let gold = Color(red: 1.0, green: 0.84, blue: 0.0)
}

#Preview {
    AnalysisView()
        .environmentObject(GlowGirlViewModel())
}
