//
//  DatingRecommendation.swift
//  GlowGirl
//
//  Created by Archita Nemalikanti on 1/3/25.
//

import SwiftUI

// MARK: - API Models
struct DatingMatch: Codable {
    let name: String
    let age: Int
    let occupation: String
    let personality: String
    let traits: [String]
    let compatibilityScore: Int
    let emoji: String
    
    enum CodingKeys: String, CodingKey {
        case name, age, occupation, personality, traits, emoji
        case compatibilityScore = "compatibility_score"
    }
}

struct DatingMatchesResponse: Codable {
    let matches: [DatingMatch]
    let message: String
}

// MARK: - API Service
class DatingAPIService {
    static let shared = DatingAPIService()
    private let baseURL = "https://glow-app-lhi6n.ondigitalocean.app"
    
    private init() {}
    
    func getDatingMatches(ventText: String) async throws -> [DatingMatch] {
        guard let url = URL(string: "\(baseURL)/api/dating-matches") else {
            throw URLError(.badURL)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let requestBody = ["vent_text": ventText]
        request.httpBody = try JSONSerialization.data(withJSONObject: requestBody)
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }
        
        let matchesResponse = try JSONDecoder().decode(DatingMatchesResponse.self, from: data)
        return matchesResponse.matches
    }
}

// MARK: - Dating Profile Model
struct DatingProfile: Identifiable {
    let id = UUID()
    let name: String
    let age: Int
    let occupation: String
    let personality: String
    let compatibility: String
    let whyPerfect: String
    let dealBreaker: String
    let dateIdea: String
    let emoji: String
    let compatibilityScore: Int
    let imageUrl: String
    let traits: [String]
    let lifestyle: String
}

// MARK: - Dating Recommendations View
struct DatingRecommendationView: View {
    @EnvironmentObject var viewModel: GlowGirlViewModel
    @State private var recommendedProfiles: [DatingProfile] = []
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack(spacing: 25) {
                    // Header
                    VStack(alignment: .leading, spacing: 12) {
                        HStack {
                            Text("based on ur tea spill...")
                                .font(.title2)
                                .fontWeight(.light)
                                .foregroundColor(.white)
                            Spacer()
                        }
                        Text("ur dating matches ✨💕")
                            .font(.system(size: 36, weight: .bold, design: .serif))
                            .foregroundColor(Color(red: 1.0, green: 0.8, blue: 0.9))
                        
                        Text("people who can keep up with ur energy bestie")
                            .font(.subheadline)
                            .foregroundColor(.white.opacity(0.8))
                            .italic()
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 20)
                    
                    // Dating Profile Cards
                    ForEach(recommendedProfiles, id: \.id) { profile in
                        DatingProfileCard(profile: profile)
                    }
                }
            }
            .background(
                LinearGradient(
                    colors: [
                        Color(red: 0.4, green: 0.2, blue: 0.4),
                        Color(red: 0.6, green: 0.3, blue: 0.5),
                        Color(red: 0.5, green: 0.4, blue: 0.6)
                    ],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
            )
            .navigationBarHidden(true)
        }
        .onAppear {
            generateDatingRecommendations()
        }
    }
    
    private func generateDatingRecommendations() {
        // Use real vector-based API matching!
        Task {
            await fetchRealMatches()
        }
    }
    
    @MainActor
    private func fetchRealMatches() async {
        guard !viewModel.ventText.isEmpty else {
            // Fallback to static profiles if no venting text
            recommendedProfiles = createStaticProfiles()
            return
        }
        
        do {
            let matches = try await DatingAPIService.shared.getDatingMatches(ventText: viewModel.ventText)
            recommendedProfiles = matches.map { match in
                DatingProfile(
                    name: match.name,
                    age: match.age,
                    occupation: match.occupation,
                    personality: match.personality,
                    compatibility: "Vector match: \(match.compatibilityScore)%",
                    whyPerfect: "Based on your venting patterns, you two have \(match.compatibilityScore)% compatibility!",
                    dealBreaker: "Potential issue: Different communication styles",
                    dateIdea: "Perfect first date based on your shared interests",
                    emoji: match.emoji,
                    compatibilityScore: match.compatibilityScore,
                    imageUrl: "\(match.name.lowercased())_profile",
                    traits: match.traits,
                    lifestyle: "Lifestyle compatible with your venting patterns"
                )
            }
        } catch {
            print("Failed to fetch real matches: \(error)")
            // Fallback to static profiles
            recommendedProfiles = createStaticProfiles()
        }
    }
    
    private func analyzeVentingForDating() -> [String: Any] {
        let ventText = viewModel.ventText.lowercased()
        
        var traits: [String] = []
        var lifestyle: [String] = []
        var needs: [String] = []
        
        // Analyze for independence and ambition
        if ventText.contains("hackathon") || ventText.contains("study") || ventText.contains("work") || ventText.contains("busy") {
            traits.append("ambitious")
            lifestyle.append("career-focused")
            needs.append("understanding")
        }
        
        if ventText.contains("independent") || ventText.contains("alone") || ventText.contains("myself") {
            traits.append("independent")
            needs.append("space")
        }
        
        // Analyze for stress and need for care
        if ventText.contains("tired") || ventText.contains("overwhelm") || ventText.contains("stress") {
            needs.append("nurturing")
            needs.append("support")
        }
        
        // Default traits based on your preferences
        traits.append("masc-presenting")
        needs.append("feminine-energy")
        needs.append("caring")
        
        return [
            "traits": traits,
            "lifestyle": lifestyle,
            "needs": needs
        ]
    }
    
    private func createStaticProfiles() -> [DatingProfile] {
        return [
            // Feminine guys who can handle independence
            DatingProfile(
                name: "Adrian",
                age: 24,
                occupation: "UX Designer & Part-time Barista",
                personality: "Soft-spoken creative with a nurturing side",
                compatibility: "Perfect match for ur independent energy",
                whyPerfect: "He's got that gentle, caring vibe but totally gets the grind. Will bring you coffee during late study sessions and won't get clingy when you're in hackathon mode.",
                dealBreaker: "Sometimes overthinks social situations",
                dateIdea: "Cozy café coding session where he makes you aesthetic lattes",
                emoji: "☕️",
                compatibilityScore: 94,
                imageUrl: "adrian_profile",
                traits: ["Gentle", "Creative", "Understanding", "Feminine energy"],
                lifestyle: "Balanced work-life, values creativity and connection"
            ),
            
            DatingProfile(
                name: "Marcus",
                age: 26,
                occupation: "Software Engineer & Yoga Instructor",
                personality: "Tech-savvy with a zen, caring nature",
                compatibility: "Your perfect coding companion",
                whyPerfect: "Literally gets the tech world AND has that soft, mindful energy. Will debug your code and then give you the most relaxing shoulder massage after.",
                dealBreaker: "Can be too zen sometimes when you need high energy",
                dateIdea: "Pair programming session followed by sunset yoga",
                emoji: "🧘‍♂️",
                compatibilityScore: 92,
                imageUrl: "marcus_profile",
                traits: ["Intelligent", "Calm", "Supportive", "Tech-savvy"],
                lifestyle: "Mindful living with tech career focus"
            ),
            
            DatingProfile(
                name: "Jamie",
                age: 23,
                occupation: "Art Student & Plant Parent",
                personality: "Artistic soul with a nurturing, gentle spirit",
                compatibility: "Your creative safe haven",
                whyPerfect: "Has that soft boy aesthetic with the most caring heart. Will turn your space into a plant paradise and always knows when you need a mental health break.",
                dealBreaker: "Not super career-driven, prefers slower pace",
                dateIdea: "Plant shopping followed by art museum and homemade dinner",
                emoji: "🌱",
                compatibilityScore: 88,
                imageUrl: "jamie_profile",
                traits: ["Artistic", "Nurturing", "Gentle", "Intuitive"],
                lifestyle: "Creative, slow living, values emotional connection"
            ),
            
            DatingProfile(
                name: "Kai",
                age: 25,
                occupation: "Product Manager & Weekend Chef",
                personality: "Organized achiever with a soft, caring side",
                compatibility: "Matches your ambition but balances you out",
                whyPerfect: "Gets the hustle but also knows how to slow down and take care of you. Will meal prep for your busy weeks and celebrate every win with homemade treats.",
                dealBreaker: "Can be too organized/controlling sometimes",
                dateIdea: "Cooking class where he teaches you his signature dishes",
                emoji: "👨‍🍳",
                compatibilityScore: 90,
                imageUrl: "kai_profile",
                traits: ["Ambitious", "Caring", "Organized", "Supportive"],
                lifestyle: "Career-focused but values work-life balance"
            ),
            
            DatingProfile(
                name: "River",
                age: 22,
                occupation: "Music Producer & Vintage Collector",
                personality: "Creative dreamer with an old soul and gentle heart",
                compatibility: "Your artistic muse and emotional support",
                whyPerfect: "Has that soft indie boy vibe with the most caring energy. Will create playlists for your study sessions and always knows how to calm your stressed mind.",
                dealBreaker: "Can be flaky with time management",
                dateIdea: "Vinyl record shopping and private concert in his home studio",
                emoji: "🎵",
                compatibilityScore: 86,
                imageUrl: "river_profile",
                traits: ["Creative", "Gentle", "Artistic", "Empathetic"],
                lifestyle: "Creative, flexible schedule, values authentic expression"
            ),
            
            DatingProfile(
                name: "Elliot",
                age: 27,
                occupation: "Therapist & Weekend Photographer",
                personality: "Emotionally intelligent with a calming presence",
                compatibility: "Your emotional safe space",
                whyPerfect: "Literally trained to understand and support you. Has that gentle, feminine energy but also the emotional intelligence to handle your independent streak perfectly.",
                dealBreaker: "Sometimes brings work mindset to relationship",
                dateIdea: "Golden hour photoshoot followed by deep conversation over wine",
                emoji: "📸",
                compatibilityScore: 95,
                imageUrl: "elliot_profile",
                traits: ["Emotionally intelligent", "Supportive", "Gentle", "Understanding"],
                lifestyle: "Helping others, values deep connections and mental health"
            )
        ]
    }
}

// MARK: - Dating Profile Card
struct DatingProfileCard: View {
    let profile: DatingProfile
    @State private var isExpanded = false
    
    var body: some View {
        VStack(spacing: 0) {
            // Main Card
            VStack(alignment: .leading, spacing: 16) {
                // Header with name and compatibility
                HStack {
                    VStack(alignment: .leading, spacing: 4) {
                        HStack {
                            Text(profile.name)
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                            Text(profile.emoji)
                                .font(.title2)
                        }
                        
                        Text("\(profile.age) • \(profile.occupation)")
                            .font(.subheadline)
                            .foregroundColor(.white.opacity(0.8))
                    }
                    
                    Spacer()
                    
                    VStack {
                        Text("\(profile.compatibilityScore)%")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                        Text("match")
                            .font(.caption)
                            .foregroundColor(.white.opacity(0.8))
                    }
                }
                
                // Personality and compatibility
                VStack(alignment: .leading, spacing: 8) {
                    Text(profile.personality)
                        .font(.body)
                        .foregroundColor(.white.opacity(0.9))
                        .italic()
                    
                    Text(profile.compatibility)
                        .font(.subheadline)
                        .fontWeight(.medium)
                        .foregroundColor(Color(red: 1.0, green: 0.8, blue: 0.9))
                }
                
                // Traits tags
                LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 2), spacing: 8) {
                    ForEach(profile.traits, id: \.self) { trait in
                        Text(trait)
                            .font(.caption)
                            .padding(.horizontal, 8)
                            .padding(.vertical, 4)
                            .background(Color.white.opacity(0.2))
                            .foregroundColor(.white)
                            .cornerRadius(12)
                    }
                }
                
                // Expand button
                Button(action: {
                    withAnimation(.spring(response: 0.6, dampingFraction: 0.8)) {
                        isExpanded.toggle()
                    }
                }) {
                    HStack {
                        Text(isExpanded ? "show less" : "why he's perfect for u")
                            .font(.subheadline)
                            .fontWeight(.medium)
                        
                        Image(systemName: isExpanded ? "chevron.up" : "chevron.down")
                            .font(.caption)
                    }
                    .foregroundColor(Color(red: 1.0, green: 0.8, blue: 0.9))
                }
            }
            .padding(20)
            .background(
                LinearGradient(
                    colors: [
                        Color.white.opacity(0.15),
                        Color.white.opacity(0.05)
                    ],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
            )
            
            // Expanded Details
            if isExpanded {
                VStack(alignment: .leading, spacing: 16) {
                    // Why Perfect
                    VStack(alignment: .leading, spacing: 8) {
                        Text("why he's ur person:")
                            .font(.subheadline)
                            .fontWeight(.bold)
                            .foregroundColor(Color(red: 1.0, green: 0.8, blue: 0.9))
                        
                        Text(profile.whyPerfect)
                            .font(.body)
                            .foregroundColor(.white.opacity(0.9))
                    }
                    
                    // Deal Breaker
                    VStack(alignment: .leading, spacing: 8) {
                        Text("potential red flag:")
                            .font(.subheadline)
                            .fontWeight(.bold)
                            .foregroundColor(.red.opacity(0.8))
                        
                        Text(profile.dealBreaker)
                            .font(.body)
                            .foregroundColor(.white.opacity(0.8))
                    }
                    
                    // Date Idea
                    VStack(alignment: .leading, spacing: 8) {
                        Text("perfect first date:")
                            .font(.subheadline)
                            .fontWeight(.bold)
                            .foregroundColor(Color(red: 0.8, green: 1.0, blue: 0.8))
                        
                        Text(profile.dateIdea)
                            .font(.body)
                            .foregroundColor(.white.opacity(0.9))
                    }
                    
                    // Action buttons
                    HStack(spacing: 12) {
                        Button("message him 💌") {
                            // Action for messaging
                        }
                        .font(.subheadline)
                        .fontWeight(.medium)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 8)
                        .background(Color(red: 1.0, green: 0.8, blue: 0.9))
                        .foregroundColor(.black)
                        .cornerRadius(20)
                        
                        Button("save for later 📌") {
                            // Action for saving
                        }
                        .font(.subheadline)
                        .fontWeight(.medium)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 8)
                        .background(Color.white.opacity(0.2))
                        .foregroundColor(.white)
                        .cornerRadius(20)
                    }
                }
                .padding(20)
                .background(Color.white.opacity(0.05))
            }
        }
        .cornerRadius(20)
        .padding(.horizontal, 20)
    }
}

// MARK: - Legacy Simple Component (keeping for backwards compatibility)
struct DatingRecommendation: View {
    let name: String
    let age: String
    let vibe: String
    let match: String
    let color: Color
    
    var body: some View {
        HStack(spacing: 15) {
            Circle()
                .fill(color.opacity(0.2))
                .frame(width: 45, height: 45)
                .overlay(
                    Text(name.prefix(1).uppercased())
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(color)
                )
            
            VStack(alignment: .leading, spacing: 4) {
                HStack {
                    Text(name)
                        .font(.system(size: 15, weight: .bold))
                    .foregroundColor(color)
            
                    Text(age)
                        .font(.system(size: 13, weight: .medium))
                        .foregroundColor(.purple.opacity(0.7))
                }
                
                Text(vibe)
                    .font(.system(size: 12, weight: .medium))
                    .foregroundColor(.purple.opacity(0.6))
            }
            
            Spacer()
            
            VStack(spacing: 4) {
                Text(match)
                    .font(.system(size: 14, weight: .bold))
                    .foregroundColor(color)
                
                Text("match")
                    .font(.system(size: 10, weight: .medium))
                    .foregroundColor(.purple.opacity(0.6))
            }
        }
        .padding(15)
        .background(
            RoundedRectangle(cornerRadius: 15)
                .fill(Color.white.opacity(0.8))
                .stroke(color.opacity(0.2), lineWidth: 1)
        )
    }
}

#Preview {
    DatingRecommendationView()
        .environmentObject(GlowGirlViewModel())
}
