import SwiftUI

struct AnalysisView: View {
    @EnvironmentObject var glowViewModel: GlowGirlViewModel
    @Environment(\.dismiss) private var dismiss
    @State private var selectedPage = 0
    @State private var sparkleAnimation = false
    
    var body: some View {
        ZStack {
            // Clean gradient background
            LinearGradient(
                colors: [Color.pink.opacity(0.05), Color.purple.opacity(0.08)],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            VStack(spacing: 0) {
                // Minimal header
                HStack {
                    Button("close") {
                        dismiss()
                    }
                    .font(.caption)
                    .foregroundColor(.purple.opacity(0.7))
                    
                    Spacer()
                    
                    Text("ur glow up plan")
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundColor(.pink)
                    
                    Spacer()
                    
                    Button("new tea") {
                        glowViewModel.resetAnalysis()
                        dismiss()
                    }
                    .font(.caption)
                    .foregroundColor(.pink.opacity(0.7))
                }
                .padding(.horizontal, 25)
                .padding(.top, 15)
                .padding(.bottom, 20)
                
                // Page content
                TabView(selection: $selectedPage) {
                    // Page 1: Connections
                    ConnectionsPage()
                        .tag(0)
                    
                    // Page 2: Your Glow Up
                    GlowUpOutfitsPage()
                        .tag(1)
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                
                // Clean bottom navigation
                HStack(spacing: 60) {
                    VStack(spacing: 8) {
                        Button(action: { selectedPage = 0 }) {
                            VStack(spacing: 4) {
                                Image(systemName: "heart.fill")
                                    .font(.system(size: 20))
                                    .foregroundColor(selectedPage == 0 ? .pink : .pink.opacity(0.3))
                                Text("connect")
                                    .font(.caption)
                                    .foregroundColor(selectedPage == 0 ? .pink : .pink.opacity(0.3))
                            }
                        }
                    }
                    
                    VStack(spacing: 8) {
                        Button(action: { selectedPage = 1 }) {
                            VStack(spacing: 4) {
                                Image(systemName: "sparkles")
                                    .font(.system(size: 20))
                                    .foregroundColor(selectedPage == 1 ? .purple : .purple.opacity(0.3))
                                Text("glow up")
                                    .font(.caption)
                                    .foregroundColor(selectedPage == 1 ? .purple : .purple.opacity(0.3))
                            }
                        }
                    }
                }
                .padding(.bottom, 40)
            }
        }
    }
}

// MARK: - Page 1: Connections (Clean & Minimal)
struct ConnectionsPage: View {
    @State private var emotionallyAvailable = true
    
    var body: some View {
        ScrollView {
            VStack(spacing: 30) {
                // Emotionally available toggle - clean design
                VStack(spacing: 15) {
                    HStack {
                        VStack(alignment: .leading, spacing: 4) {
                            Text("ready for love?")
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundColor(.pink)
                            
                            Text("turn on to connect with others")
                                .font(.caption)
                                .foregroundColor(.purple.opacity(0.7))
                        }
                        
                        Spacer()
                        
                        Toggle("", isOn: $emotionallyAvailable)
                            .tint(.pink)
                            .scaleEffect(1.2)
                    }
                }
                .padding(20)
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.white.opacity(0.8))
                        .shadow(color: .pink.opacity(0.1), radius: 10, x: 0, y: 5)
                )
                
                if emotionallyAvailable {
                    // Other girls in same situation - minimal cards
                    VStack(alignment: .leading, spacing: 15) {
                        Text("girls going thru it too 💕")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(.purple)
                        
                        LazyVStack(spacing: 12) {
                            ForEach(mockGirls, id: \.id) { girl in
                                MinimalGirlCard(girl: girl)
                            }
                        }
                    }
                }
                
                // Future predictions - your favorite feature!
                EnhancedFuturePredictionsCard()
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 10)
        }
    }
}

// MARK: - Page 2: Glow Up Outfits (Main Focus!)
struct GlowUpOutfitsPage: View {
    @State private var rashiAnimation = false
    
    var body: some View {
        ScrollView {
            VStack(spacing: 25) {
                // Indian Rashi section - clean
                VStack(spacing: 15) {
                    Text("ur rashi guidance")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.orange)
                    
                    IndianRashiCard()
                }
                
                // TODAY'S GLOW UP FITS - Main focus
                VStack(alignment: .leading, spacing: 20) {
                    Text("today's fits to serve 💅")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.pink)
                    
                    // Outfit cards
                    VStack(spacing: 15) {
                        GlowUpFitCard(
                            category: "power outfit",
                            items: ["black blazer", "gold chain necklace", "sleek ponytail"],
                            vibe: "boss babe energy",
                            color: .purple
                        )
                        
                        GlowUpFitCard(
                            category: "date night look",
                            items: ["silk top", "statement earrings", "red lipstick"],
                            vibe: "main character moment",
                            color: .pink
                        )
                        
                        GlowUpFitCard(
                            category: "casual slay",
                            items: ["crop top", "layered necklaces", "glossy lips"],
                            vibe: "effortlessly iconic",
                            color: .orange
                        )
                    }
                }
                
                // Makeup focus
                VStack(alignment: .leading, spacing: 15) {
                    Text("makeup that hits different ✨")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.purple)
                    
                    MakeupRecsCard()
                }
                
                // Jewelry section
                VStack(alignment: .leading, spacing: 15) {
                    Text("jewelry to complete the look 💎")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.orange)
                    
                    JewelryRecsCard()
                }
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 10)
        }
        .onAppear {
            rashiAnimation = true
        }
    }
}

// MARK: - Clean Supporting Views

struct MinimalGirlCard: View {
    let girl: MockGirl
    
    var body: some View {
        HStack(spacing: 15) {
            Circle()
                .fill(
                    LinearGradient(
                        colors: [.pink.opacity(0.6), .purple.opacity(0.4)],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .frame(width: 45, height: 45)
                .overlay(
                    Text(girl.initial)
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                )
            
            VStack(alignment: .leading, spacing: 4) {
                Text(girl.name)
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundColor(.purple)
                
                Text(girl.vibe)
                    .font(.caption)
                    .foregroundColor(.purple.opacity(0.7))
            }
            
            Spacer()
            
            Button("connect") {
                // Connect action
            }
            .font(.caption)
            .fontWeight(.medium)
            .foregroundColor(.white)
            .padding(.horizontal, 15)
            .padding(.vertical, 8)
            .background(
                Capsule()
                    .fill(.pink)
            )
        }
        .padding(.horizontal, 18)
        .padding(.vertical, 15)
        .background(
            RoundedRectangle(cornerRadius: 18)
                .fill(Color.white.opacity(0.9))
                .shadow(color: .pink.opacity(0.1), radius: 8, x: 0, y: 4)
        )
    }
}

struct IndianRashiCard: View {
    var body: some View {
        VStack(spacing: 12) {
            HStack {
                Text("वृश्चिक (vrishchik)")
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundColor(.orange)
                
                Spacer()
                
                Text("🦂")
                    .font(.title)
            }
            
            Text("scorpio energy calls for bold transformation. time to shed old skin and emerge powerful, bestie ✨")
                .font(.subheadline)
                .foregroundColor(.orange.opacity(0.8))
                .lineSpacing(2)
        }
        .padding(20)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.orange.opacity(0.1))
                .stroke(Color.orange.opacity(0.3), lineWidth: 1)
        )
    }
}

struct GlowUpFitCard: View {
    let category: String
    let items: [String]
    let vibe: String
    let color: Color
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text(category)
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundColor(color)
                
                Spacer()
                
                Text(vibe)
                    .font(.caption)
                    .fontWeight(.medium)
                    .foregroundColor(.white)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 4)
                    .background(
                        Capsule()
                            .fill(color.opacity(0.8))
                    )
            }
            
            LazyVGrid(columns: [
                GridItem(.flexible()),
                GridItem(.flexible()),
                GridItem(.flexible())
            ], spacing: 8) {
                ForEach(items, id: \.self) { item in
                    Text(item)
                        .font(.caption)
                        .foregroundColor(color)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 6)
                        .background(
                            RoundedRectangle(cornerRadius: 12)
                                .fill(color.opacity(0.1))
                                .stroke(color.opacity(0.3), lineWidth: 1)
                        )
                }
            }
        }
        .padding(18)
        .background(
            RoundedRectangle(cornerRadius: 18)
                .fill(Color.white.opacity(0.8))
                .shadow(color: color.opacity(0.1), radius: 8, x: 0, y: 4)
        )
    }
}

struct MakeupRecsCard: View {
    let makeupItems = ["winged eyeliner", "red lipstick", "highlighter", "bold brows", "mascara", "concealer"]
    
    var body: some View {
        LazyVGrid(columns: [
            GridItem(.flexible()),
            GridItem(.flexible())
        ], spacing: 10) {
            ForEach(makeupItems, id: \.self) { item in
                Text(item)
                    .font(.subheadline)
                    .fontWeight(.medium)
                    .foregroundColor(.purple)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 10)
                    .background(
                        RoundedRectangle(cornerRadius: 15)
                            .fill(Color.purple.opacity(0.1))
                            .stroke(Color.purple.opacity(0.3), lineWidth: 1)
                    )
            }
        }
    }
}

struct JewelryRecsCard: View {
    let jewelryItems = ["gold hoops", "layered chains", "statement rings", "delicate bracelet"]
    
    var body: some View {
        LazyVGrid(columns: [
            GridItem(.flexible()),
            GridItem(.flexible())
        ], spacing: 10) {
            ForEach(jewelryItems, id: \.self) { item in
                Text(item)
                    .font(.subheadline)
                    .fontWeight(.medium)
                    .foregroundColor(.orange)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 10)
                    .background(
                        RoundedRectangle(cornerRadius: 15)
                            .fill(Color.orange.opacity(0.1))
                            .stroke(Color.orange.opacity(0.3), lineWidth: 1)
                    )
            }
        }
    }
}

struct EnhancedFuturePredictionsCard: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 18) {
            Text("what's coming for u ⭐")
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(.purple)
            
            VStack(spacing: 15) {
                PredictionRow(
                    timeframe: "2 weeks",
                    prediction: "someone's gonna notice ur glow up and slide into ur dms 👀",
                    color: .pink
                )
                PredictionRow(
                    timeframe: "1 month",
                    prediction: "ur confidence hits different - people can't stop staring ✨",
                    color: .orange
                )
                PredictionRow(
                    timeframe: "3 months",
                    prediction: "new romantic energy enters - they're gonna be obsessed bestie 💕",
                    color: .purple
                )
            }
        }
        .padding(20)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.white.opacity(0.9))
                .shadow(color: .purple.opacity(0.1), radius: 12, x: 0, y: 6)
        )
    }
}

struct PredictionRow: View {
    let timeframe: String
    let prediction: String
    let color: Color
    
    var body: some View {
        HStack(alignment: .top, spacing: 15) {
            Text(timeframe)
                .font(.caption)
                .fontWeight(.bold)
                .foregroundColor(.white)
                .padding(.horizontal, 10)
                .padding(.vertical, 6)
                .background(
                    Capsule()
                        .fill(color)
                )
            
            Text(prediction)
                .font(.subheadline)
                .foregroundColor(.purple.opacity(0.8))
                .lineLimit(nil)
            
            Spacer()
        }
    }
}

// MARK: - Mock Data
struct MockGirl {
    let id = UUID()
    let name: String
    let initial: String
    let vibe: String
}

let mockGirls = [
    MockGirl(name: "priya", initial: "P", vibe: "healing era but serving looks"),
    MockGirl(name: "maya", initial: "M", vibe: "phoenix rising from heartbreak"),
    MockGirl(name: "aria", initial: "A", vibe: "glowing up and moving on")
]

#Preview {
    AnalysisView()
        .environmentObject(GlowGirlViewModel())
}
