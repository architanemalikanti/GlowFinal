import SwiftUI
import Speech

// MARK: - Dashboard Home
struct DashboardHomeView: View {
    @EnvironmentObject var authManager: AuthManager
    @EnvironmentObject var glowViewModel: GlowGirlViewModel
    @StateObject private var speechService = SpeechToTextService()
    @State private var showAnalyzeButton = false
    @State private var recordingDuration: TimeInterval = 0
    @State private var timer: Timer?
    @State private var pulseAnimation = false
    
    var body: some View {
        ZStack {
            // Dynamic background with multiple gradients
            ZStack {
                RadialGradient(
                    colors: [Color.pink.opacity(0.3), Color.purple.opacity(0.2), Color.clear],
                    center: .topLeading,
                    startRadius: 50,
                    endRadius: 400
                )
                
                RadialGradient(
                    colors: [Color.orange.opacity(0.2), Color.pink.opacity(0.1), Color.clear],
                    center: .bottomTrailing,
                    startRadius: 100,
                    endRadius: 500
                )
                
                LinearGradient(
                    colors: [Color.purple.opacity(0.05), Color.pink.opacity(0.05)],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
            }
            .ignoresSafeArea()
            
            VStack(spacing: 0) {
                // Header with cute logout
                HStack {
                    Spacer()
                    Button(action: {
                        authManager.logout()
                    }) {
                        Text("bye babe 👋")
                            .font(.caption)
                            .fontWeight(.medium)
                            .foregroundColor(.purple.opacity(0.8))
                            .padding(.horizontal, 12)
                            .padding(.vertical, 6)
                            .background(
                                Capsule()
                                    .fill(Color.white.opacity(0.3))
                                    .shadow(color: .pink.opacity(0.2), radius: 5, x: 0, y: 2)
                            )
                    }
                }
                .padding(.horizontal, 25)
                .padding(.top, 15)
                
                Spacer(minLength: 40)
                
                // Bold header section
                VStack(spacing: 12) {
                    Text("spill ur tea bestie")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundStyle(
                            LinearGradient(
                                colors: [.pink, .purple, .orange],
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                        .shadow(color: .pink.opacity(0.3), radius: 8, x: 0, y: 4)
                    
                    Text("tap to vent & get that glow up ✨")
                        .font(.subheadline)
                        .foregroundColor(.purple.opacity(0.9))
                        .multilineTextAlignment(.center)
                }
                .padding(.horizontal, 20)
                
                Spacer(minLength: 30)
                
                // Transcribed text with extra flair
                if !speechService.transcribedText.isEmpty {
                    VStack(spacing: 8) {
                        Text("your tea so far...")
                            .font(.caption)
                            .foregroundColor(.purple.opacity(0.7))
                            .textCase(.lowercase)
                        
                        ScrollView {
                            Text(speechService.transcribedText)
                                .font(.body)
                                .foregroundColor(.primary.opacity(0.9))
                                .lineSpacing(2)
                                .padding(16)
                                .background(
                                    RoundedRectangle(cornerRadius: 20)
                                        .fill(
                                            LinearGradient(
                                                colors: [Color.white.opacity(0.9), Color.pink.opacity(0.1)],
                                                startPoint: .topLeading,
                                                endPoint: .bottomTrailing
                                            )
                                        )
                                        .shadow(color: .pink.opacity(0.2), radius: 15, x: 0, y: 8)
                                )
                        }
                        .frame(maxHeight: 120)
                    }
                    .padding(.horizontal, 25)
                }
                
                Spacer()
                
                // MAIN Recording Circle - extra dramatic
                VStack(spacing: 25) {
                    Button(action: {
                        if speechService.isRecording {
                            stopRecording()
                        } else {
                            startRecording()
                        }
                    }) {
                        ZStack {
                            // Outer glow ring
                            Circle()
                                .stroke(
                                    LinearGradient(
                                        colors: speechService.isRecording ?
                                        [.red.opacity(0.6), .pink.opacity(0.4)] :
                                        [.pink.opacity(0.4), .purple.opacity(0.3)],
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                    ),
                                    lineWidth: 3
                                )
                                .frame(width: 220, height: 220)
                                .scaleEffect(pulseAnimation ? 1.05 : 1.0)
                                .opacity(pulseAnimation ? 0.7 : 0.3)
                                .animation(.easeInOut(duration: 1.5).repeatForever(autoreverses: true), value: pulseAnimation)
                            
                            // Main circle
                            Circle()
                                .fill(
                                    LinearGradient(
                                        colors: speechService.isRecording ? [.red, .pink] : [.pink, .purple],
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                    )
                                )
                                .frame(width: 190, height: 190)
                                .shadow(color: speechService.isRecording ? .red.opacity(0.4) : .pink.opacity(0.4), radius: 25, x: 0, y: 15)
                                .scaleEffect(speechService.isRecording ? 1.08 : 1.0)
                                .animation(.easeInOut(duration: 0.3), value: speechService.isRecording)
                            
                            // Heart icon with extra flair
                            Image(systemName: speechService.isRecording ? "stop.fill" : "heart.fill")
                                .font(.system(size: 55, weight: .bold))
                                .foregroundColor(.white)
                                .shadow(color: .black.opacity(0.2), radius: 3, x: 0, y: 2)
                                .scaleEffect(speechService.isRecording ? 0.9 : 1.0)
                                .animation(.easeInOut(duration: 0.3), value: speechService.isRecording)
                        }
                    }
                    .buttonStyle(PlainButtonStyle())
                    
                    // Status with personality
                    Group {
                        if speechService.isRecording {
                            VStack(spacing: 4) {
                                Text("recording ur vibe")
                                    .font(.headline)
                                    .foregroundColor(.pink)
                                Text("\(formatDuration(recordingDuration))")
                                    .font(.caption)
                                    .foregroundColor(.purple.opacity(0.8))
                            }
                        } else if showAnalyzeButton {
                            VStack(spacing: 15) {
                                Text("tea spilled successfully babes")
                                    .font(.headline)
                                    .foregroundColor(.purple)
                                
                                // Analyze Button right here!
                                Button(action: {
                                    analyzeText()
                                }) {
                                    HStack(spacing: 10) {
                                        if glowViewModel.isLoading {
                                            ProgressView()
                                                .progressViewStyle(CircularProgressViewStyle(tint: .white))
                                                .scaleEffect(0.9)
                                        }
                                        Text(glowViewModel.isLoading ? "brewing ur glow up..." : "analyze this tea NOW")
                                            .font(.headline)
                                            .fontWeight(.bold)
                                            .textCase(.lowercase)
                                    }
                                    .foregroundColor(.white)
                                    .frame(maxWidth: .infinity)
                                    .padding(.vertical, 18)
                                    .background(
                                        RoundedRectangle(cornerRadius: 30)
                                            .fill(
                                                LinearGradient(
                                                    colors: [.pink, .purple, .orange.opacity(0.8)],
                                                    startPoint: .leading,
                                                    endPoint: .trailing
                                                )
                                            )
                                            .shadow(color: .pink.opacity(0.5), radius: 20, x: 0, y: 10)
                                    )
                                    .scaleEffect(glowViewModel.isLoading ? 0.98 : 1.0)
                                    .animation(.easeInOut(duration: 0.2), value: glowViewModel.isLoading)
                                }
                                .disabled(glowViewModel.isLoading)
                                .padding(.horizontal, 30)
                            }
                        } else {
                            Text("ready to spill? tap the heart")
                                .font(.headline)
                                .foregroundColor(.purple.opacity(0.8))
                        }
                    }
                    .textCase(.lowercase)
                }
                
                Spacer()
                
                // Remove the old analyze button section since it's now integrated above
                
                // Error with personality
                if let errorMessage = glowViewModel.errorMessage {
                    Text("oops bestie: \(errorMessage)")
                        .font(.caption)
                        .foregroundColor(.red.opacity(0.8))
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 25)
                        .textCase(.lowercase)
                }
                
                Spacer(minLength: 30)
            }
        }
        .fullScreenCover(isPresented: $glowViewModel.showAnalysisView) {
            AnalysisView()
                .environmentObject(glowViewModel)
        }
        .onAppear {
            pulseAnimation = true
            Task {
                await glowViewModel.testBackendConnection()
            }
        }
    }
    
    private func startRecording() {
        do {
            try speechService.startRecording()
            startDurationTimer()
            withAnimation(.spring(response: 0.5, dampingFraction: 0.7)) {
                showAnalyzeButton = false
            }
        } catch {
            glowViewModel.errorMessage = "Failed to start recording: \(error.localizedDescription)"
        }
    }
    
    private func stopRecording() {
        // CAPTURE the text BEFORE stopping the service
        let capturedText = speechService.transcribedText
        print("🎤 Captured text before stopping: '\(capturedText)'")
        
        speechService.stopRecording()
        timer?.invalidate()
        timer = nil
        
        // Store the captured text immediately in the view model
        glowViewModel.ventText = capturedText
        print("🎤 Stored in ventText: '\(glowViewModel.ventText)'")
        
        withAnimation(.spring(response: 0.6, dampingFraction: 0.7)) {
            showAnalyzeButton = !capturedText.isEmpty
        }
    }
    
    private func startDurationTimer() {
        recordingDuration = 0
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            recordingDuration += 1
        }
    }
    
    private func formatDuration(_ duration: TimeInterval) -> String {
        let minutes = Int(duration) / 60
        let seconds = Int(duration) % 60
        return String(format: "%d:%02d", minutes, seconds)
    }
    
    private func analyzeText() {
        print("🎯 analyzeText() called")
        print("🎯 speechService.transcribedText: '\(speechService.transcribedText)'")
        print("🎯 glowViewModel.ventText BEFORE assignment: '\(glowViewModel.ventText)'")
        
        
        print("🎯 glowViewModel.ventText AFTER assignment: '\(glowViewModel.ventText)'")
        
        // Add a small delay to see if something clears it
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            print("🎯 glowViewModel.ventText after 0.1s delay: '\(self.glowViewModel.ventText)'")
            self.glowViewModel.startVoiceAnalysis()
        }
    }
}

#Preview {
    DashboardHomeView()
        .environmentObject(AuthManager())
        .environmentObject(GlowGirlViewModel())
}
