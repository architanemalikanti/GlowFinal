//
//  ChatbotSignUpPage.swift
//  GlowGirl
//
//  Created by Archita Nemalikanti on 8/3/25.
//

import SwiftUI

struct ChatMessage {
    let id = UUID()
    let content: String
    let isUser: Bool
    let timestamp: Date
}

struct ChatbotSignUpPage: View {
    @State private var messages: [ChatMessage] = []
    @State private var currentMessage = ""
    @State private var isTyping = false
    
    // Store the initial messages to send sequentially
    private let initialMessages = [
        "HEY BABE!!!! i'm Glow <3 your ride-or-die glow up bestie 😌💖",
        "we're not just healing — we're entering your hot girl villain era and looking unreal while doing it. buckle up.",
        "you vent. i decode the drama. and then? i serve you OUTFITS that match your emotional plotline. we're glowing up out of SPITE, STYLE, and straight-up DELUSION 💅🔥",
        "LET'S GLOW TF UP WOOOOOO 💔🕶️🍾"
    ]
    
    // ADD THESE NEW STATE VARIABLES:
    @State private var showError = false
    @State private var errorMessage = ""
    @State private var navigateToMainApp = false
    @StateObject private var chatService = ChatService()
    
    var body: some View {
        NavigationStack {
            ZStack {
                // Keep the beautiful gradient background
                LinearGradient(
                    colors: [Color.pink, Color.purple],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
                
                VStack(spacing: 0) {
                    // Chat messages
                    ScrollViewReader { proxy in
                        ScrollView {
                            LazyVStack(spacing: 16) {
                                ForEach(messages, id: \.id) { message in
                                    ChatBubbleView(message: message)
                                        .id(message.id)
                                }
                                
                                if isTyping {
                                    TypingIndicatorView()
                                }
                            }
                            .padding(.horizontal, 20)
                            .padding(.top, 20)
                            .padding(.bottom, 16)
                        }
                        .onChange(of: messages.count) { _ in
                            if let lastMessage = messages.last {
                                withAnimation(.easeInOut(duration: 0.5)) {
                                    proxy.scrollTo(lastMessage.id, anchor: .bottom)
                                }
                            }
                        }
                    }
                    
                    // Message input
                    HStack(spacing: 12) {
                        HStack(spacing: 12) {
                            TextField("type ur message bestie...", text: $currentMessage, axis: .vertical)
                                .font(.system(size: 16, design: .default))
                                .foregroundColor(.primary)
                                .lineLimit(1...4)
                                .padding(.vertical, 12)
                                .padding(.leading, 16)
                            
                            Button(action: sendMessage) {
                                Circle()
                                    .fill(currentMessage.isEmpty ? .gray.opacity(0.3) : .white)
                                    .frame(width: 36, height: 36)
                                    .overlay(
                                        Image(systemName: "arrow.up")
                                            .font(.system(size: 16, weight: .semibold))
                                            .foregroundColor(currentMessage.isEmpty ? .gray : .pink)
                                    )
                            }
                            .disabled(currentMessage.isEmpty)
                            .padding(.trailing, 8)
                        }
                        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 25))
                        .overlay(
                            RoundedRectangle(cornerRadius: 25)
                                .stroke(.white.opacity(0.2), lineWidth: 1)
                        )
                    }
                    .padding(.horizontal, 20)
                    .padding(.bottom, 16)
                }
            }
        }
        .navigationBarHidden(true)
        .onAppear {
            sendInitialMessages()
        }
        // ADD THESE NEW MODIFIERS:
        .alert("Connection Error", isPresented: $showError) {
            Button("OK") { }
        } message: {
            Text(errorMessage)
        }
        .fullScreenCover(isPresented: $navigateToMainApp) {
            // Replace ContentView() with your main app view
            DashboardHomeView() // Or whatever your main app view is called
        }
    }
    
    private func sendInitialMessages() {
        for (index, messageContent) in initialMessages.enumerated() {
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(index) * 1.0) {
                // Show typing indicator
                if index < initialMessages.count - 1 {
                    isTyping = true
                }
                
                let message = ChatMessage(content: messageContent, isUser: false, timestamp: Date())
                messages.append(message)
                
                // Hide typing indicator after a short delay
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                    isTyping = false
                }
            }
        }
    }

    private func sendMessage() {
        guard !currentMessage.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else { return }
        
        let userMessage = ChatMessage(content: currentMessage, isUser: true, timestamp: Date())
        messages.append(userMessage)
        
        let messageToSend = currentMessage
        currentMessage = ""
        
        // Show typing indicator
        isTyping = true
        
        // Make real API call to your Flask backend
        Task {
            do {
                let response = try await chatService.sendMessage(messageToSend)
                
                await MainActor.run {
                    isTyping = false
                    let botMessage = ChatMessage(content: response.response, isUser: false, timestamp: Date())
                    messages.append(botMessage)
                    
                    // Check if signup is complete
                    if let action = response.action, action == "launch_app" {
                        // Signup complete! Navigate to main app
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                            navigateToMainApp = true
                        }
                    }
                }
            } catch {
                await MainActor.run {
                    isTyping = false
                    errorMessage = "uhhh babe??? the server's acting like your ex — completely unreliable and giving nothing. try again in a sec, and if it still doesn’t work… just refresh😭💅"
                    showError = true
                    
                    // Add error message to chat
                    let errorBotMessage = ChatMessage(content: errorMessage, isUser: false, timestamp: Date())
                    messages.append(errorBotMessage)
                }
            }
        }
    }
    
}

struct ChatBubbleView: View {
    let message: ChatMessage
    
    var body: some View {
        HStack {
            if message.isUser {
                Spacer()
                
                Text(message.content)
                    .font(.system(size: 16, design: .default))
                    .foregroundColor(.white)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 12)
                    .background(.ultraThinMaterial.opacity(0.3), in: RoundedRectangle(cornerRadius: 20))
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(.white.opacity(0.3), lineWidth: 1)
                    )
            } else {
                Text(message.content)
                    .font(.system(size: 16, design: .default))
                    .foregroundColor(.white)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 12)
                    .background(.white.opacity(0.15), in: RoundedRectangle(cornerRadius: 20))
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(.white.opacity(0.2), lineWidth: 1)
                    )
                
                Spacer()
            }
        }
    }
}

struct TypingIndicatorView: View {
    @State private var animateScale = false
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                HStack(spacing: 4) {
                    ForEach(0..<3) { index in
                        Circle()
                            .fill(.white.opacity(0.6))
                            .frame(width: 8, height: 8)
                            .scaleEffect(animateScale ? 1.0 : 0.5)
                            .animation(
                                Animation.easeInOut(duration: 0.6)
                                    .repeatForever()
                                    .delay(Double(index) * 0.2),
                                value: animateScale
                            )
                    }
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 12)
                .background(.white.opacity(0.15), in: RoundedRectangle(cornerRadius: 20))
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(.white.opacity(0.2), lineWidth: 1)
                )
                
                Text("glow is typing...")
                    .font(.caption2)
                    .foregroundColor(.white.opacity(0.6))
                    .padding(.leading, 8)
            }
            
            Spacer()
        }
        .onAppear {
            animateScale = true
        }
    }
}

#Preview {
    ChatbotSignUpPage()
}
