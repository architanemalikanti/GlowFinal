import SwiftUI

// MARK: - Color Extensions
extension Color {
    static let cream = Color(red: 0.98, green: 0.96, blue: 0.92)
    static let gold = Color(red: 1.0, green: 0.84, blue: 0.0)
}

struct AnalysisView: View {
    @EnvironmentObject var glowViewModel: GlowGirlViewModel
    @Environment(\.dismiss) private var dismiss
    @State private var selectedPage = 0
    @State private var sparkleAnimation = false
    @State private var currentProfileIndex = 0
    
    // Sample profiles for exploration
    let profiles = [
        UserProfile(
            name: "archita",
            nakshatra: "ashwini",
            currentMood: "super pumped ✨",
            currentStatus: "locked in for apple internship",
            isEmotionallyAvailable: false,
            recentVent: "finally getting over aditya and focusing on my career glow up",
            lifeEvents: [
                LifeEvent(year: "2022", event: "started at cornell", description: "new chapter begins"),
                LifeEvent(year: "2022", event: "met aditya", description: "first real love"),
                LifeEvent(year: "2023-2025", event: "single era", description: "healing and growth"),
                LifeEvent(year: "2025", event: "apple internship", description: "career breakthrough")
            ]
        ),
        UserProfile(
            name: "priya",
            nakshatra: "rohini",
            currentMood: "manifesting ✨",
            currentStatus: "dating someone new",
            isEmotionallyAvailable: true,
            recentVent: "finally ready to open my heart again after my breakup",
            lifeEvents: [
                LifeEvent(year: "2023", event: "graduated stanford", description: "big achievement"),
                LifeEvent(year: "2024", event: "moved to nyc", description: "new city energy"),
                LifeEvent(year: "2025", event: "met alex", description: "new love story")
            ]
        ),
        UserProfile(
            name: "maya",
            nakshatra: "krittika",
            currentMood: "focused 🔥",
            currentStatus: "grinding for tech interviews",
            isEmotionallyAvailable: false,
            recentVent: "prioritizing my career over everything right now",
            lifeEvents: [
                LifeEvent(year: "2024", event: "left toxic relationship", description: "self-love era"),
                LifeEvent(year: "2025", event: "tech interviews", description: "career focus")
            ]
        ),
        UserProfile(
            name: "zara",
            nakshatra: "ashwini",
            currentMood: "adventurous 🚀",
            currentStatus: "traveling the world solo",
            isEmotionallyAvailable: false,
            recentVent: "just booked a one-way ticket to bali - ashwini energy is unstoppable",
            lifeEvents: [
                LifeEvent(year: "2023", event: "quit corporate job", description: "freedom over everything"),
                LifeEvent(year: "2024", event: "started digital nomad life", description: "living the dream"),
                LifeEvent(year: "2025", event: "bali adventure", description: "new chapter begins")
            ]
        ),
        UserProfile(
            name: "luna",
            nakshatra: "ashwini",
            currentMood: "manifesting ✨",
            currentStatus: "building my startup",
            isEmotionallyAvailable: true,
            recentVent: "my app just hit 10k users - ashwini speed is real",
            lifeEvents: [
                LifeEvent(year: "2024", event: "founded tech startup", description: "entrepreneur era"),
                LifeEvent(year: "2025", event: "app launch success", description: "dreams becoming reality")
            ]
        ),
        UserProfile(
            name: "nova",
            nakshatra: "ashwini",
            currentMood: "unstoppable ⚡",
            currentStatus: "training for marathon",
            isEmotionallyAvailable: false,
            recentVent: "ashwini energy got me running 10 miles before breakfast",
            lifeEvents: [
                LifeEvent(year: "2024", event: "discovered running", description: "found my passion"),
                LifeEvent(year: "2025", event: "marathon training", description: "pushing limits")
            ]
        )
    ]
    
    var body: some View {
        ZStack {
            // Dynamic gradient background based on current profile
            LinearGradient(
                colors: selectedPage == 0 ? 
                    [Color.pink.opacity(0.3), Color.purple.opacity(0.4), Color.orange.opacity(0.2)] :
                    [Color.red.opacity(0.4), Color.orange.opacity(0.3), Color.pink.opacity(0.2)],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            VStack(spacing: 0) {
                // Bold header with profile navigation
                VStack(spacing: 15) {
                    HStack {
                        Button("close") {
                            dismiss()
                        }
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(.purple.opacity(0.8))
                        
                        Spacer()
                        
                        Text(selectedPage == 0 ? "explore 💫" : selectedPage == 1 ? "nakshatra ✨" : "fits 💅")
                            .font(.system(size: 24, weight: .bold))
                            .foregroundStyle(
                                LinearGradient(
                                    colors: [.pink, .purple, .orange],
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )
                        
                        Spacer()
                        
                        Button("new tea") {
                            glowViewModel.resetAnalysis()
                            dismiss()
                        }
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(.pink.opacity(0.8))
                    }
                    
                    // Profile navigation for explore page
                    if selectedPage == 0 {
                        HStack(spacing: 20) {
                            ForEach(0..<profiles.count, id: \.self) { index in
                                Button(action: {
                                    withAnimation(.spring(response: 0.6, dampingFraction: 0.8)) {
                                        currentProfileIndex = index
                                    }
                                }) {
                                    VStack(spacing: 4) {
                                        Circle()
                                            .fill(
                                                LinearGradient(
                                                    colors: currentProfileIndex == index ? 
                                                        [.pink.opacity(0.8), .purple.opacity(0.8)] : 
                                                        [.pink.opacity(0.3), .purple.opacity(0.3)],
                                                    startPoint: .topLeading,
                                                    endPoint: .bottomTrailing
                                                )
                                            )
                                            .frame(width: 50, height: 50)
                                            .overlay(
                                                Text(profiles[index].name.prefix(1).uppercased())
                                                    .font(.system(size: 18, weight: .bold))
                                                    .foregroundColor(.white)
                                            )
                                            .scaleEffect(currentProfileIndex == index ? 1.1 : 1.0)
                                        
                                        Text(profiles[index].name)
                                            .font(.system(size: 12, weight: .semibold))
                                            .foregroundColor(currentProfileIndex == index ? .pink.opacity(0.8) : .pink.opacity(0.5))
<<<<<<< Updated upstream
                                    }
=======
<<<<<<< HEAD
                        }
>>>>>>> Stashed changes
                                }
                            }
                        }
=======
                                    }
                                }
                            }
                        }
>>>>>>> a5513a5 (changed analysisview)
                        .padding(.top, 10)
                    }
                }
                .padding(.horizontal, 25)
                .padding(.top, 15)
                .padding(.bottom, 20)
                
                // Page content
                TabView(selection: $selectedPage) {
                    // Page 0: Explore (Other Profiles)
                    ExplorePage(profiles: profiles, currentProfileIndex: $currentProfileIndex)
                        .tag(0)
<<<<<<< Updated upstream
                        .onChange(of: currentProfileIndex) { _ in
=======
<<<<<<< HEAD
                        .onChange(of: currentProfileIndex) { oldValue, newValue in
=======
                        .onChange(of: currentProfileIndex) { _ in
>>>>>>> a5513a5 (changed analysisview)
>>>>>>> Stashed changes
                            // Auto-navigate to nakshatra page when profile changes
                            withAnimation(.spring(response: 0.6, dampingFraction: 0.8)) {
                                selectedPage = 1
                            }
                        }
                    
                    // Page 1: Nakshatra Profile
                    NakshatraProfilePage(profile: profiles[currentProfileIndex])
                        .tag(1)
                    
                    // Page 2: Fits Profile
                    FitsProfilePage(profile: profiles[currentProfileIndex])
                        .tag(2)
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                
                // Bold bottom navigation
                HStack(spacing: 60) {
                    NavigationButton(
                        title: "explore",
                        icon: "person.2.fill",
                        isSelected: selectedPage == 0,
                        action: { withAnimation(.spring(response: 0.6, dampingFraction: 0.8)) { selectedPage = 0 } }
                    )
                    
                    NavigationButton(
                        title: "nakshatra",
                        icon: "sparkles",
                        isSelected: selectedPage == 1,
                        action: { withAnimation(.spring(response: 0.6, dampingFraction: 0.8)) { selectedPage = 1 } }
                    )
                    
                    NavigationButton(
                        title: "fits",
                        icon: "wand.and.stars",
                        isSelected: selectedPage == 2,
                        action: { withAnimation(.spring(response: 0.6, dampingFraction: 0.8)) { selectedPage = 2 } }
                    )
                }
                .padding(.bottom, 30)
            }
        }
        .onAppear {
            sparkleAnimation = true
        }
    }
}

// MARK: - Data Models
struct UserProfile {
    let name: String
    let nakshatra: String
    let currentMood: String
    let currentStatus: String
    let isEmotionallyAvailable: Bool
    let recentVent: String
    let lifeEvents: [LifeEvent]
}

struct LifeEvent {
    let year: String
    let event: String
    let description: String
}

// MARK: - Navigation Button
struct NavigationButton: View {
    let title: String
    let icon: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack(spacing: 6) {
<<<<<<< Updated upstream
                ZStack {
                    Circle()
                        .fill(
                            LinearGradient(
=======
<<<<<<< HEAD
                               ZStack {
                                   Circle()
                                       .fill(
                                           LinearGradient(
>>>>>>> Stashed changes
                                colors: isSelected ? 
                                    [.pink.opacity(0.8), .purple.opacity(0.8)] : 
                                    [.pink.opacity(0.2), .purple.opacity(0.2)],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .frame(width: 50, height: 50)
                        .scaleEffect(isSelected ? 1.1 : 1.0)
                    
                    Image(systemName: icon)
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(isSelected ? .white : .pink.opacity(0.6))
                }
                
                Text(title)
                    .font(.system(size: 12, weight: .semibold))
                    .foregroundColor(isSelected ? .pink.opacity(0.8) : .pink.opacity(0.5))
<<<<<<< Updated upstream
            }
        }
    }
=======
                           }
                       }
                   }
=======
                ZStack {
                    Circle()
                        .fill(
                            LinearGradient(
                                colors: isSelected ? 
                                    [.pink.opacity(0.8), .purple.opacity(0.8)] : 
                                    [.pink.opacity(0.2), .purple.opacity(0.2)],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .frame(width: 50, height: 50)
                        .scaleEffect(isSelected ? 1.1 : 1.0)
                    
                    Image(systemName: icon)
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(isSelected ? .white : .pink.opacity(0.6))
                }
                
                Text(title)
                    .font(.system(size: 12, weight: .semibold))
                    .foregroundColor(isSelected ? .pink.opacity(0.8) : .pink.opacity(0.5))
            }
        }
    }
>>>>>>> a5513a5 (changed analysisview)
>>>>>>> Stashed changes
}

// MARK: - Explore Page
struct ExplorePage: View {
    let profiles: [UserProfile]
    @Binding var currentProfileIndex: Int
    @State private var emotionallyAvailable = false
    @State private var searchText = ""
    @State private var showingSearchResults = false
    @State private var selectedSearchProfile: UserProfile?
    
    // Filter profiles to show only those with same nakshatra (ashwini)
    var sameNakshatraProfiles: [UserProfile] {
        profiles.filter { $0.nakshatra == "ashwini" }
    }
    
    // Search results
    var searchResults: [UserProfile] {
        if searchText.isEmpty {
            return []
        }
        return profiles.filter { profile in
            profile.name.localizedCaseInsensitiveContains(searchText) ||
            profile.nakshatra.localizedCaseInsensitiveContains(searchText)
        }
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 25) {
                // Search section
                SearchSection(
                    searchText: $searchText,
                    showingResults: $showingSearchResults,
                    results: searchResults,
                    onProfileSelect: { profile in
                        selectedSearchProfile = profile
                        currentProfileIndex = profiles.firstIndex(where: { $0.name == profile.name }) ?? 0
                        showingSearchResults = false
                        searchText = ""
                    }
                )
                
                // Emotional availability section
                EmotionalAvailabilitySection(isAvailable: $emotionallyAvailable)
                
                // Dating recommendations (if emotionally available)
                if emotionallyAvailable {
                    DatingRecommendationsCard()
                        .transition(.asymmetric(
                            insertion: .scale.combined(with: .opacity),
                            removal: .scale.combined(with: .opacity)
                        ))
<<<<<<< Updated upstream
                }
                
=======
<<<<<<< HEAD
                                }
                                
=======
                }
                
>>>>>>> a5513a5 (changed analysisview)
>>>>>>> Stashed changes
                // Recent connections
                RecentConnectionsSection(profiles: sameNakshatraProfiles)
            }
            .padding(.horizontal, 25)
            .padding(.top, 20)
            .padding(.bottom, 120)
        }
        .animation(.spring(response: 0.8, dampingFraction: 0.8), value: emotionallyAvailable)
        .animation(.spring(response: 0.8, dampingFraction: 0.8), value: showingSearchResults)
    }
}

// MARK: - Search Section
struct SearchSection: View {
    @Binding var searchText: String
    @Binding var showingResults: Bool
    let results: [UserProfile]
    let onProfileSelect: (UserProfile) -> Void
    @State private var isSearching = false
    
    var body: some View {
        VStack(spacing: 18) {
            // Search header
<<<<<<< Updated upstream
            HStack {
                Text("find ur cosmic sisters ✨")
=======
<<<<<<< HEAD
                    HStack {
                Text("find ur cosmic sisters ✨")
                                .font(.system(size: 20, weight: .bold))
                                .foregroundStyle(
=======
            HStack {
                Text("find ur cosmic sisters ✨")
>>>>>>> Stashed changes
                    .font(.system(size: 20, weight: .bold))
                    .foregroundStyle(
                        LinearGradient(
                            colors: [.pink, .purple],
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                
<<<<<<< Updated upstream
=======
                Spacer()
                
                Text("🔍")
                    .font(.system(size: 18))
                    .scaleEffect(isSearching ? 1.2 : 1.0)
                    .animation(
                        .easeInOut(duration: 1.5)
                        .repeatForever(autoreverses: true),
                        value: isSearching
                    )
            }
            
            // Search bar
            HStack(spacing: 12) {
                Image(systemName: "magnifyingglass")
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(.pink.opacity(0.6))
                
                TextField("search by name or nakshatra...", text: $searchText)
                    .font(.system(size: 16, weight: .medium))
                    .onChange(of: searchText) { _ in
                        showingResults = !searchText.isEmpty
                    }
                
                if !searchText.isEmpty {
                    Button(action: {
                        searchText = ""
                        showingResults = false
                    }) {
                        Image(systemName: "xmark.circle.fill")
                            .font(.system(size: 16))
                            .foregroundColor(.pink.opacity(0.6))
                    }
                }
            }
            .padding(.horizontal, 18)
            .padding(.vertical, 16)
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color.white.opacity(0.9))
                    .stroke(
                        LinearGradient(
                            colors: [.pink.opacity(0.3), .purple.opacity(0.2)],
                            startPoint: .leading,
                            endPoint: .trailing
                        ),
                        lineWidth: 1.5
                    )
            )
            .shadow(color: .pink.opacity(0.1), radius: 8, x: 0, y: 4)
            
            // Search results
            if showingResults && !results.isEmpty {
                VStack(spacing: 12) {
                    ForEach(results, id: \.name) { profile in
                        SearchResultRow(profile: profile) {
                            onProfileSelect(profile)
                        }
                    }
                }
                .transition(.asymmetric(
                    insertion: .scale.combined(with: .opacity),
                    removal: .scale.combined(with: .opacity)
                ))
            } else if showingResults && results.isEmpty {
                VStack(spacing: 12) {
                    Text("no cosmic sisters found 💫")
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(.purple.opacity(0.7))
                    
                    Text("try searching for a different name or nakshatra")
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(.purple.opacity(0.5))
                        .multilineTextAlignment(.center)
                }
                .padding(.vertical, 20)
                .transition(.asymmetric(
                    insertion: .scale.combined(with: .opacity),
                    removal: .scale.combined(with: .opacity)
                ))
            }
        }
        .onAppear {
            isSearching = true
        }
    }
}

// MARK: - Search Result Row
struct SearchResultRow: View {
    let profile: UserProfile
    let onTap: () -> Void
    @State private var isFollowing = false
    
    var body: some View {
        HStack(spacing: 15) {
            // Avatar
            Circle()
                .fill(
                    LinearGradient(
                        colors: [.pink.opacity(0.8), .purple.opacity(0.8)],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .frame(width: 45, height: 45)
                .overlay(
                    Text(profile.name.prefix(1).uppercased())
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(.white)
                )
            
            // Profile info
            VStack(alignment: .leading, spacing: 4) {
                HStack {
                    Text(profile.name)
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(.purple.opacity(0.8))
                    
                    Text("•")
                        .font(.system(size: 14))
                        .foregroundColor(.pink.opacity(0.6))
                    
                    Text(profile.nakshatra)
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(.pink.opacity(0.7))
                }
                
                Text(profile.currentStatus)
                    .font(.system(size: 13, weight: .medium))
                    .foregroundColor(.purple.opacity(0.6))
                    .lineLimit(1)
            }
            
            Spacer()
            
            // Follow button
            Button(action: {
                withAnimation(.spring(response: 0.6, dampingFraction: 0.8)) {
                    isFollowing.toggle()
                }
            }) {
                Text(isFollowing ? "following" : "follow")
                    .font(.system(size: 13, weight: .semibold))
                    .foregroundColor(isFollowing ? .purple.opacity(0.7) : .white)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
                    .background(
                        Capsule()
                            .fill(
                                isFollowing ? 
                                    LinearGradient(
                                        colors: [Color.purple.opacity(0.1), Color.purple.opacity(0.05)],
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                    ) : 
>>>>>>> a5513a5 (changed analysisview)
                                    LinearGradient(
                                        colors: [.pink, .purple],
                                        startPoint: .leading,
                                        endPoint: .trailing
                                    )
<<<<<<< HEAD
                                )
                            
>>>>>>> Stashed changes
                Spacer()
                
                Text("🔍")
                    .font(.system(size: 18))
                    .scaleEffect(isSearching ? 1.2 : 1.0)
                    .animation(
                        .easeInOut(duration: 1.5)
                        .repeatForever(autoreverses: true),
                        value: isSearching
                    )
            }
            
            // Search bar
            HStack(spacing: 12) {
                Image(systemName: "magnifyingglass")
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(.pink.opacity(0.6))
                
                TextField("search by name or nakshatra...", text: $searchText)
                    .font(.system(size: 16, weight: .medium))
                    .onChange(of: searchText) { _ in
                        showingResults = !searchText.isEmpty
                    }
                
                if !searchText.isEmpty {
                    Button(action: {
                        searchText = ""
                        showingResults = false
                    }) {
                        Image(systemName: "xmark.circle.fill")
                            .font(.system(size: 16))
                            .foregroundColor(.pink.opacity(0.6))
                    }
                }
            }
            .padding(.horizontal, 18)
            .padding(.vertical, 16)
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color.white.opacity(0.9))
                    .stroke(
                        LinearGradient(
                            colors: [.pink.opacity(0.3), .purple.opacity(0.2)],
                            startPoint: .leading,
                            endPoint: .trailing
                        ),
                        lineWidth: 1.5
                    )
            )
            .shadow(color: .pink.opacity(0.1), radius: 8, x: 0, y: 4)
            
            // Search results
            if showingResults && !results.isEmpty {
                VStack(spacing: 12) {
                    ForEach(results, id: \.name) { profile in
                        SearchResultRow(profile: profile) {
                            onProfileSelect(profile)
                        }
                    }
                }
                .transition(.asymmetric(
                    insertion: .scale.combined(with: .opacity),
                    removal: .scale.combined(with: .opacity)
                ))
            } else if showingResults && results.isEmpty {
                VStack(spacing: 12) {
                    Text("no cosmic sisters found 💫")
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(.purple.opacity(0.7))
                    
                    Text("try searching for a different name or nakshatra")
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(.purple.opacity(0.5))
                        .multilineTextAlignment(.center)
                }
                .padding(.vertical, 20)
                .transition(.asymmetric(
                    insertion: .scale.combined(with: .opacity),
                    removal: .scale.combined(with: .opacity)
                ))
            }
        }
        .onAppear {
            isSearching = true
        }
    }
}

// MARK: - Search Result Row
struct SearchResultRow: View {
    let profile: UserProfile
    let onTap: () -> Void
    @State private var isFollowing = false
    
    var body: some View {
        HStack(spacing: 15) {
            // Avatar
            Circle()
                .fill(
                    LinearGradient(
                        colors: [.pink.opacity(0.8), .purple.opacity(0.8)],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .frame(width: 45, height: 45)
                .overlay(
                    Text(profile.name.prefix(1).uppercased())
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(.white)
                )
            
            // Profile info
            VStack(alignment: .leading, spacing: 4) {
                HStack {
                    Text(profile.name)
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(.purple.opacity(0.8))
                    
                    Text("•")
                        .font(.system(size: 14))
                        .foregroundColor(.pink.opacity(0.6))
                    
                    Text(profile.nakshatra)
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(.pink.opacity(0.7))
                }
                
                Text(profile.currentStatus)
                    .font(.system(size: 13, weight: .medium))
                    .foregroundColor(.purple.opacity(0.6))
                    .lineLimit(1)
            }
            
            Spacer()
            
            // Follow button
            Button(action: {
                withAnimation(.spring(response: 0.6, dampingFraction: 0.8)) {
                    isFollowing.toggle()
                }
            }) {
                Text(isFollowing ? "following" : "follow")
                    .font(.system(size: 13, weight: .semibold))
                    .foregroundColor(isFollowing ? .purple.opacity(0.7) : .white)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
                    .background(
                        Capsule()
                            .fill(
                                isFollowing ? 
                                    LinearGradient(
                                        colors: [Color.purple.opacity(0.1), Color.purple.opacity(0.05)],
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                    ) : 
                                    LinearGradient(
                                        colors: [.pink, .purple],
                                        startPoint: .leading,
                                        endPoint: .trailing
                                    )
                            )
=======
                            )
>>>>>>> a5513a5 (changed analysisview)
                    )
                    .overlay(
                        Capsule()
                            .stroke(
                                isFollowing ? .purple.opacity(0.3) : .clear,
<<<<<<< Updated upstream
                                lineWidth: 1
                            )
                    )
=======
<<<<<<< HEAD
                            lineWidth: 1
                        )
                )
=======
                                lineWidth: 1
                            )
                    )
>>>>>>> a5513a5 (changed analysisview)
>>>>>>> Stashed changes
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.white.opacity(0.8))
                .stroke(.pink.opacity(0.15), lineWidth: 1)
        )
        .onTapGesture {
            onTap()
        }
    }
}

// MARK: - Emotional Availability Section
struct EmotionalAvailabilitySection: View {
    @Binding var isAvailable: Bool
    
    var body: some View {
<<<<<<< Updated upstream
        VStack(spacing: 20) {
            HStack {
=======
<<<<<<< HEAD
            VStack(spacing: 20) {
                HStack {
=======
        VStack(spacing: 20) {
            HStack {
>>>>>>> a5513a5 (changed analysisview)
>>>>>>> Stashed changes
                VStack(alignment: .leading, spacing: 6) {
                    Text("ready to date? 💕")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundStyle(
                            LinearGradient(
                                colors: [.pink, .purple],
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                    
                    Text(isAvailable ? "open to new connections ✨" : "focusing on self-love 💅")
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(.purple.opacity(0.7))
<<<<<<< HEAD
                }
                
                Spacer()
                
                Toggle("", isOn: $isAvailable)
                    .tint(.pink)
                    .scaleEffect(1.2)
                    .animation(.spring(response: 0.6), value: isAvailable)
<<<<<<< Updated upstream
            }
=======
                }
=======
                }
                
                Spacer()
                
                Toggle("", isOn: $isAvailable)
                    .tint(.pink)
                    .scaleEffect(1.2)
                    .animation(.spring(response: 0.6), value: isAvailable)
            }
>>>>>>> a5513a5 (changed analysisview)
>>>>>>> Stashed changes
        }
        .padding(20)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(
                    LinearGradient(
                        colors: [Color.white.opacity(0.95), Color.pink.opacity(0.03)],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .shadow(color: .pink.opacity(0.1), radius: 10, x: 0, y: 5)
        )
    }
}

// MARK: - Recent Connections Section
struct RecentConnectionsSection: View {
    let profiles: [UserProfile]
    
    var body: some View {
        VStack(spacing: 20) {
            HStack {
                Text("recent ashwini sisters 💫")
                    .font(.system(size: 20, weight: .bold))
                    .foregroundStyle(
                        LinearGradient(
                            colors: [.purple, .pink],
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                
                Spacer()
                
                Text("\(profiles.count)")
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(.pink.opacity(0.7))
                    .padding(.horizontal, 12)
                    .padding(.vertical, 6)
                    .background(
                        Capsule()
                            .fill(.pink.opacity(0.1))
                    )
            }
            
            if profiles.isEmpty {
                VStack(spacing: 12) {
                    Text("✨")
                        .font(.system(size: 32))
                    
                    Text("be the first ashwini girl here!")
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(.purple.opacity(0.7))
                    
                    Text("ur cosmic energy will attract others")
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(.purple.opacity(0.5))
                }
                .padding(.vertical, 30)
            } else {
                VStack(spacing: 12) {
                    ForEach(profiles.prefix(3), id: \.name) { profile in
                        RecentConnectionRow(profile: profile)
                    }
                }
            }
        }
    }
}

// MARK: - Recent Connection Row
struct RecentConnectionRow: View {
    let profile: UserProfile
    @State private var isFollowing = false
    
    var body: some View {
        HStack(spacing: 15) {
            // Avatar
            Circle()
<<<<<<< Updated upstream
                .fill(
                    LinearGradient(
=======
<<<<<<< HEAD
                            .fill(
                                LinearGradient(
=======
                .fill(
                    LinearGradient(
>>>>>>> a5513a5 (changed analysisview)
>>>>>>> Stashed changes
                        colors: [.pink.opacity(0.7), .purple.opacity(0.7)],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .frame(width: 40, height: 40)
                .overlay(
                    Text(profile.name.prefix(1).uppercased())
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(.white)
                )
            
            // Info
            VStack(alignment: .leading, spacing: 3) {
                Text(profile.name)
                    .font(.system(size: 15, weight: .semibold))
                    .foregroundColor(.purple.opacity(0.8))
                
                Text(profile.currentMood)
                    .font(.system(size: 13, weight: .medium))
                    .foregroundColor(.pink.opacity(0.7))
            }
            
            Spacer()
            
            // Status indicator
            Circle()
                .fill(.green)
                .frame(width: 8, height: 8)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .background(
            RoundedRectangle(cornerRadius: 14)
                .fill(Color.white.opacity(0.6))
                .stroke(.pink.opacity(0.1), lineWidth: 1)
        )
    }
}



// MARK: - Current Profile Card
struct CurrentProfileCard: View {
    let profile: UserProfile
    @State private var pulseAnimation = false
    
    var body: some View {
        VStack(spacing: 20) {
            HStack {
                VStack(alignment: .leading, spacing: 8) {
                    Text(profile.name)
                        .font(.system(size: 28, weight: .bold))
                        .foregroundStyle(
                            LinearGradient(
                                colors: [.pink, .purple],
<<<<<<< Updated upstream
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
=======
<<<<<<< HEAD
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )
=======
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
>>>>>>> a5513a5 (changed analysisview)
>>>>>>> Stashed changes
                    
                    Text(profile.currentMood)
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(.purple.opacity(0.8))
                }
                
                Spacer()
                
                Text("✨")
                    .font(.system(size: 24))
                    .scaleEffect(pulseAnimation ? 1.2 : 1.0)
                    .animation(
                        .easeInOut(duration: 1.5)
                        .repeatForever(autoreverses: true),
                        value: pulseAnimation
                    )
            }
            
            VStack(spacing: 15) {
                ProfileStatusRow(
                    title: "currently",
                    status: profile.currentStatus,
                    emoji: "🎯",
                    color: .orange
                )
                
                ProfileStatusRow(
                    title: "recently vented",
                    status: profile.recentVent,
                    emoji: "💭",
                    color: .pink
                )
            }
        }
        .padding(25)
        .background(
            RoundedRectangle(cornerRadius: 25)
                .fill(
                    LinearGradient(
                        colors: [Color.white.opacity(0.95), Color.pink.opacity(0.05)],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .shadow(color: .pink.opacity(0.2), radius: 15, x: 0, y: 8)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 25)
                .stroke(
                    LinearGradient(
                        colors: [.pink.opacity(0.3), .purple.opacity(0.2)],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    ),
                    lineWidth: 1
                )
        )
        .onAppear {
            pulseAnimation = true
        }
    }
}

struct ProfileStatusRow: View {
    let title: String
    let status: String
    let emoji: String
    let color: Color
    
    var body: some View {
        HStack(spacing: 15) {
            Text(emoji)
                .font(.system(size: 20))
            
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.system(size: 14, weight: .bold))
                    .foregroundColor(color)
                
                Text(status)
                    .font(.system(size: 13, weight: .medium))
                    .foregroundColor(.purple.opacity(0.8))
                    .lineLimit(2)
            }
            
            Spacer()
        }
        .padding(.horizontal, 15)
        .padding(.vertical, 12)
        .background(
            RoundedRectangle(cornerRadius: 15)
                .fill(color.opacity(0.08))
                .stroke(color.opacity(0.2), lineWidth: 1)
        )
    }
}

// MARK: - Emotional Availability Card
struct EmotionalAvailabilityCard: View {
    @Binding var isAvailable: Bool
    
    var body: some View {
        VStack(spacing: 20) {
            HStack {
                VStack(alignment: .leading, spacing: 8) {
                    Text("emotionally available?")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundStyle(
                            LinearGradient(
                                colors: [.pink, .purple],
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                    
                    Text(isAvailable ? "ready to date ✨" : "focusing on me 💅")
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(.purple.opacity(0.7))
                }
                
                Spacer()
                
                Toggle("", isOn: $isAvailable)
                    .tint(.pink)
                    .scaleEffect(1.3)
                    .animation(.spring(response: 0.6), value: isAvailable)
<<<<<<< HEAD
            }
        }
        .padding(25)
        .background(
            RoundedRectangle(cornerRadius: 25)
                .fill(
                    LinearGradient(
                        colors: [Color.white.opacity(0.9), Color.purple.opacity(0.05)],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .shadow(color: .purple.opacity(0.15), radius: 12, x: 0, y: 6)
        )
    }
}

// MARK: - Nakshatra Profile Page
struct NakshatraProfilePage: View {
    let profile: UserProfile
    @State private var scrollOffset: CGFloat = 0
    
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                // Dynamic header that changes color based on scroll
                VStack(spacing: 20) {
                    Text(profile.nakshatra.uppercased())
                        .font(.system(size: 42, weight: .black))
                        .foregroundStyle(
                            LinearGradient(
                                colors: [.red, .orange],
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                    
                    Text("the cosmic horsemen")
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(.orange.opacity(0.9))
                    
                    Text("fast • free • unstoppable")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.red.opacity(0.7))
                }
                .padding(.top, 30)
                .padding(.bottom, 40)
                .background(
                    LinearGradient(
                        colors: [.red.opacity(0.3), .orange.opacity(0.2), .pink.opacity(0.1)],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
                
                // Content cards
                VStack(spacing: 25) {
                    // Current Year Prediction
                    CurrentYearPredictionCard()
                    
                    // Life Timeline
                    LifeTimelineCard(events: profile.lifeEvents)
                    
                    // Nakshatra Traits
                    NakshatraTraitsCard()
                }
                .padding(.horizontal, 20)
                .padding(.top, 30)
                .padding(.bottom, 120)
            }
        }
=======
            }
        }
        .padding(25)
        .background(
            RoundedRectangle(cornerRadius: 25)
                .fill(
                    LinearGradient(
                        colors: [Color.white.opacity(0.9), Color.purple.opacity(0.05)],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .shadow(color: .purple.opacity(0.15), radius: 12, x: 0, y: 6)
        )
    }
}

// MARK: - Nakshatra Profile Page
struct NakshatraProfilePage: View {
    let profile: UserProfile
    @State private var scrollOffset: CGFloat = 0
    
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                // Dynamic header that changes color based on scroll
                VStack(spacing: 20) {
                    Text(profile.nakshatra.uppercased())
                        .font(.system(size: 42, weight: .black))
                        .foregroundStyle(
                            LinearGradient(
                                colors: [.red, .orange],
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                    
                    Text("the cosmic horsemen")
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(.orange.opacity(0.9))
                    
                    Text("fast • free • unstoppable")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.red.opacity(0.7))
                }
                .padding(.top, 30)
                .padding(.bottom, 40)
                .background(
                    LinearGradient(
                        colors: [.red.opacity(0.3), .orange.opacity(0.2), .pink.opacity(0.1)],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
                
                // Content cards
                VStack(spacing: 25) {
                    // Current Year Prediction
                    CurrentYearPredictionCard()
                    
                    // Life Timeline
                    LifeTimelineCard(events: profile.lifeEvents)
                    
                    // Nakshatra Traits
                    NakshatraTraitsCard()
                }
                .padding(.horizontal, 20)
                .padding(.top, 30)
                .padding(.bottom, 120)
            }
        }
>>>>>>> a5513a5 (changed analysisview)
        .background(
            LinearGradient(
                colors: [.pink.opacity(0.1), .purple.opacity(0.1), .orange.opacity(0.05)],
                startPoint: .top,
                endPoint: .bottom
            )
        )
    }
}

// MARK: - Current Year Prediction Card
struct CurrentYearPredictionCard: View {
    @State private var glowAnimation = false
    
    var body: some View {
        VStack(spacing: 20) {
            HStack {
                Text("2025 is ur year ✨")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundStyle(
                        LinearGradient(
                            colors: [.pink, .purple],
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                
                Spacer()
                
                Text("⭐")
                    .font(.system(size: 24))
                    .scaleEffect(glowAnimation ? 1.3 : 1.0)
                    .animation(
                        .easeInOut(duration: 2.0)
                        .repeatForever(autoreverses: true),
                        value: glowAnimation
                    )
            }
            
            VStack(spacing: 15) {
                Text("the stars have aligned perfectly for u this year! this might be a tough phase getting over aditya, but u have so much more coming. focus on ur career and watch everything fall into place.")
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(.purple.opacity(0.8))
                    .lineSpacing(4)
                
                HStack(spacing: 15) {
                    PredictionTag(text: "career breakthrough", color: .orange)
                    PredictionTag(text: "self-love era", color: .pink)
                    PredictionTag(text: "new beginnings", color: .purple)
                }
            }
        }
        .padding(25)
        .background(
            RoundedRectangle(cornerRadius: 25)
                .fill(
                    LinearGradient(
                        colors: [Color.white.opacity(0.95), Color.pink.opacity(0.05)],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .shadow(color: .pink.opacity(0.2), radius: 15, x: 0, y: 8)
        )
        .onAppear {
            glowAnimation = true
        }
    }
}

struct PredictionTag: View {
    let text: String
    let color: Color
    
    var body: some View {
        Text(text)
            .font(.system(size: 12, weight: .bold))
<<<<<<< Updated upstream
            .foregroundColor(.white)
            .padding(.horizontal, 12)
            .padding(.vertical, 6)
            .background(
                Capsule()
=======
<<<<<<< HEAD
                    .foregroundColor(.white)
            .padding(.horizontal, 12)
            .padding(.vertical, 6)
                    .background(
                        Capsule()
=======
            .foregroundColor(.white)
            .padding(.horizontal, 12)
            .padding(.vertical, 6)
            .background(
                Capsule()
>>>>>>> a5513a5 (changed analysisview)
>>>>>>> Stashed changes
                    .fill(color)
            )
    }
}

// MARK: - Life Timeline Card
struct LifeTimelineCard: View {
    let events: [LifeEvent]
    
    var body: some View {
        VStack(spacing: 20) {
            Text("ur life story 📖")
                .font(.system(size: 22, weight: .bold))
<<<<<<< HEAD
                .foregroundStyle(
                    LinearGradient(
                        colors: [.purple, .pink],
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )
            
            VStack(spacing: 15) {
                ForEach(Array(events.enumerated()), id: \.offset) { index, event in
                    TimelineEventRow(
                        event: event,
                        isLast: index == events.count - 1
                    )
                }
            }
        }
        .padding(25)
        .background(
            RoundedRectangle(cornerRadius: 25)
                .fill(
                    LinearGradient(
                        colors: [Color.white.opacity(0.95), Color.purple.opacity(0.05)],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .shadow(color: .purple.opacity(0.15), radius: 12, x: 0, y: 6)
        )
    }
}

struct TimelineEventRow: View {
    let event: LifeEvent
    let isLast: Bool
    
    var body: some View {
        HStack(spacing: 15) {
            VStack(spacing: 0) {
                Circle()
                    .fill(
                        LinearGradient(
                            colors: [.pink, .purple],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .frame(width: 12, height: 12)
                
                if !isLast {
                    Rectangle()
                        .fill(.purple.opacity(0.3))
                        .frame(width: 2, height: 40)
                }
            }
            
            VStack(alignment: .leading, spacing: 4) {
                HStack {
                    Text(event.year)
                        .font(.system(size: 14, weight: .bold))
                        .foregroundColor(.pink)
                    
                    Text(event.event)
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.purple.opacity(0.8))
                }
                
                Text(event.description)
                    .font(.system(size: 13, weight: .medium))
                    .foregroundColor(.purple.opacity(0.6))
            }
            
            Spacer()
        }
    }
}

// MARK: - Nakshatra Traits Card
struct NakshatraTraitsCard: View {
    var body: some View {
        VStack(spacing: 20) {
            Text("ur cosmic energy ⚡")
                .font(.system(size: 22, weight: .bold))
=======
>>>>>>> a5513a5 (changed analysisview)
                .foregroundStyle(
                    LinearGradient(
                        colors: [.red, .orange],
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )
            
            VStack(spacing: 15) {
<<<<<<< HEAD
=======
                ForEach(Array(events.enumerated()), id: \.offset) { index, event in
                    TimelineEventRow(
                        event: event,
                        isLast: index == events.count - 1
                    )
                }
            }
        }
        .padding(25)
        .background(
            RoundedRectangle(cornerRadius: 25)
                .fill(
                    LinearGradient(
                        colors: [Color.white.opacity(0.95), Color.purple.opacity(0.05)],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .shadow(color: .purple.opacity(0.15), radius: 12, x: 0, y: 6)
        )
    }
}

struct TimelineEventRow: View {
    let event: LifeEvent
    let isLast: Bool
    
    var body: some View {
        HStack(spacing: 15) {
            VStack(spacing: 0) {
                Circle()
                    .fill(
                        LinearGradient(
                            colors: [.pink, .purple],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .frame(width: 12, height: 12)
                
                if !isLast {
                    Rectangle()
                        .fill(.purple.opacity(0.3))
                        .frame(width: 2, height: 40)
                }
            }
            
            VStack(alignment: .leading, spacing: 4) {
                HStack {
                    Text(event.year)
                        .font(.system(size: 14, weight: .bold))
                        .foregroundColor(.pink)
                    
                    Text(event.event)
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.purple.opacity(0.8))
                }
                
                Text(event.description)
                    .font(.system(size: 13, weight: .medium))
                    .foregroundColor(.purple.opacity(0.6))
            }
            
            Spacer()
        }
    }
}

// MARK: - Nakshatra Traits Card
struct NakshatraTraitsCard: View {
    var body: some View {
        VStack(spacing: 20) {
            Text("ur cosmic energy ⚡")
                .font(.system(size: 22, weight: .bold))
                .foregroundStyle(
                    LinearGradient(
                        colors: [.red, .orange],
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )
            
            VStack(spacing: 15) {
>>>>>>> a5513a5 (changed analysisview)
                NakshatraTrait(
                    trait: "lightning-fast decisions",
                    description: "u see the path and take it before others notice",
                    emoji: "⚡",
                    color: .red
                )
                
                NakshatraTrait(
                    trait: "freedom is non-negotiable",
                    description: "cages are for birds, not cosmic forces like u",
                    emoji: "🗽",
                    color: .orange
                )
                
                NakshatraTrait(
                    trait: "unstoppable momentum",
                    description: "once u start moving, the universe shifts to match ur energy",
                    emoji: "🚀",
                    color: .red
                )
            }
        }
        .padding(25)
        .background(
            RoundedRectangle(cornerRadius: 25)
                .fill(
                    LinearGradient(
                        colors: [Color.white.opacity(0.95), Color.orange.opacity(0.05)],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .shadow(color: .orange.opacity(0.15), radius: 12, x: 0, y: 6)
        )
    }
}

struct NakshatraTrait: View {
    let trait: String
    let description: String
    let emoji: String
    let color: Color
    @State private var pulse = false
    
    var body: some View {
        HStack(spacing: 15) {
            Text(emoji)
                .font(.system(size: 22))
                .scaleEffect(pulse ? 1.2 : 1.0)
                .animation(
                    .easeInOut(duration: 1.4)
                    .repeatForever(autoreverses: true),
                    value: pulse
                )
            
            VStack(alignment: .leading, spacing: 4) {
                Text(trait)
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(color)
                
                Text(description)
                    .font(.system(size: 13, weight: .medium))
                    .foregroundColor(.purple.opacity(0.7))
                    .lineLimit(2)
            }
            
            Spacer()
        }
        .padding(.horizontal, 18)
        .padding(.vertical, 15)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(color.opacity(0.08))
                .stroke(color.opacity(0.2), lineWidth: 1)
        )
        .onAppear {
            pulse = true
        }
    }
}

// MARK: - Fits Profile Page
struct FitsProfilePage: View {
    let profile: UserProfile
<<<<<<< Updated upstream
    @State private var sparkleOffset: CGFloat = 0
    @State private var currentVibe: VibeTheme = .elegant // Temporary for testing
    
    var body: some View {
=======
<<<<<<< HEAD
    
    var body: some View {
        DeepikaGlamView()
=======
    @State private var sparkleOffset: CGFloat = 0
    @State private var currentVibe: VibeTheme = .elegant // Temporary for testing
    
    var body: some View {
>>>>>>> Stashed changes
        ZStack {
            // Dynamic background based on current vibe
            currentVibe.backgroundGradient
                .ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 25) {
                    // Vibe header
                    VStack(spacing: 15) {
                        HStack {
                            Text("ur aesthetic")
                                .font(.system(size: 28, weight: .bold))
                                .foregroundStyle(currentVibe.titleGradient)
                            
                            Spacer()
                            
                            Text(currentVibe.emoji)
                                .font(.system(size: 24))
                                .offset(x: sparkleOffset)
                                .animation(
                                    .easeInOut(duration: 2.0)
                                    .repeatForever(autoreverses: true),
                                    value: sparkleOffset
                                )
                        }
                        
                        Text(currentVibe.title)
                            .font(.system(size: 20, weight: .semibold))
                            .foregroundColor(currentVibe.textColor)
                        
                        Text(currentVibe.description)
                            .font(.system(size: 16, weight: .medium))
                            .foregroundColor(currentVibe.textColor.opacity(0.8))
                            .multilineTextAlignment(.leading)
                            .lineSpacing(4)
                    }
                    .padding(.horizontal, 25)
                    .padding(.top, 25)
                    
                    // Temporary vibe selector bubbles
                    HStack(spacing: 12) {
                        ForEach(VibeTheme.allCases, id: \.self) { vibe in
                            Button(action: {
                                withAnimation(.spring(response: 0.6, dampingFraction: 0.8)) {
                                    currentVibe = vibe
                                }
                            }) {
                                Circle()
                                    .fill(currentVibe == vibe ? vibe.titleGradient : Color.white.opacity(0.8))
                                    .frame(width: 20, height: 20)
                                    .overlay(
                                        Circle()
                                            .stroke(currentVibe == vibe ? vibe.textColor : vibe.textColor.opacity(0.3), lineWidth: 2)
                                    )
                                    .shadow(color: currentVibe == vibe ? vibe.textColor.opacity(0.3) : Color.clear, radius: 4)
                            }
                        }
                    }
                    .padding(.horizontal, 25)
                    
                    // Outfit cards with vibe-specific styling
                    VStack(spacing: 20) {
                        ForEach(currentVibe.outfits, id: \.category) { outfit in
                            VibeOutfitCard(
                                outfit: outfit,
                                vibe: currentVibe
                            )
                        }
                    }
                    .padding(.horizontal, 25)
                }
                .padding(.bottom, 120)
            }
        }
        .onAppear {
            sparkleOffset = 10
            // Set initial vibe based on profile
            currentVibe = getVibeForProfile(profile)
        }
    }
    
    // Function to determine vibe based on profile (this is where your backend logic goes)
    private func getVibeForProfile(_ profile: UserProfile) -> VibeTheme {
        // This is where you'd implement the vector embedding logic
        // For now, using a simple mapping - replace with your backend logic
        switch profile.name {
        case "archita":
            return .elegant
        case "priya":
            return .glamorous
        case "maya":
            return .natural
        case "zara":
            return .adventurous
        case "luna":
            return .luxury
        case "nova":
            return .bold
        default:
            return .elegant
        }
<<<<<<< Updated upstream
=======
>>>>>>> a5513a5 (changed analysisview)
>>>>>>> Stashed changes
    }
}

// MARK: - Vibe Themes (Fixed to match your images exactly)
enum VibeTheme: CaseIterable {
    case elegant, glamorous, natural, adventurous, luxury, bold
    
    var title: String {
        switch self {
        case .elegant: return "elegant & serene"
        case .glamorous: return "glamorous & bold"
        case .natural: return "natural & free"
        case .adventurous: return "adventurous & wild"
        case .luxury: return "luxury & opulence"
        case .bold: return "bold & confident"
        }
    }
    
    var description: String {
        switch self {
        case .elegant: return "soft, sophisticated beauty with timeless grace. think pearls, silk, and gentle elegance."
        case .glamorous: return "dramatic, high-fashion energy that commands attention. think sequins, bold colors, and runway vibes."
        case .natural: return "effortless beauty that celebrates authenticity. think earth tones, flowing fabrics, and organic beauty."
        case .adventurous: return "free-spirited style that embraces bold choices. think leather, bright colors, and fearless energy."
        case .luxury: return "refined elegance with premium sophistication. think gold, diamonds, and timeless luxury."
        case .bold: return "confident, powerful presence that owns every room. think black, red, and unstoppable confidence."
<<<<<<< Updated upstream
        }
    }
=======
<<<<<<< HEAD
                }
            }
=======
        }
    }
>>>>>>> a5513a5 (changed analysisview)
>>>>>>> Stashed changes
    
    var emoji: String {
        switch self {
        case .elegant: return "✨"
        case .glamorous: return "💫"
        case .natural: return "🌸"
        case .adventurous: return "🚀"
        case .luxury: return "👑"
        case .bold: return "🔥"
        }
    }
    
    var backgroundGradient: LinearGradient {
        switch self {
        case .elegant:
            return LinearGradient(
                colors: [Color.white.opacity(0.9), Color.cream.opacity(0.3), Color.pink.opacity(0.1)],
<<<<<<< Updated upstream
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
=======
<<<<<<< HEAD
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
=======
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
>>>>>>> a5513a5 (changed analysisview)
>>>>>>> Stashed changes
        case .glamorous:
            return LinearGradient(
                colors: [Color.pink.opacity(0.4), Color.purple.opacity(0.3), Color.orange.opacity(0.2)],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        case .natural:
            return LinearGradient(
                colors: [Color.white.opacity(0.8), Color.green.opacity(0.2), Color.blue.opacity(0.1)],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        case .adventurous:
            return LinearGradient(
                colors: [Color.orange.opacity(0.3), Color.red.opacity(0.2), Color.pink.opacity(0.1)],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        case .luxury:
            return LinearGradient(
                colors: [Color.white.opacity(0.9), Color.gold.opacity(0.2), Color.purple.opacity(0.1)],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        case .bold:
            return LinearGradient(
                colors: [Color.black.opacity(0.2), Color.red.opacity(0.15), Color.purple.opacity(0.1)],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        }
    }
    
    var titleGradient: LinearGradient {
        switch self {
        case .elegant:
            return LinearGradient(colors: [.cream, .pink], startPoint: .leading, endPoint: .trailing)
        case .glamorous:
            return LinearGradient(colors: [.pink, .purple], startPoint: .leading, endPoint: .trailing)
        case .natural:
            return LinearGradient(colors: [.green, .blue], startPoint: .leading, endPoint: .trailing)
        case .adventurous:
            return LinearGradient(colors: [.orange, .red], startPoint: .leading, endPoint: .trailing)
        case .luxury:
            return LinearGradient(colors: [.gold, .purple], startPoint: .leading, endPoint: .trailing)
        case .bold:
            return LinearGradient(colors: [.black, .red], startPoint: .leading, endPoint: .trailing)
        }
    }
    
    var textColor: Color {
        switch self {
        case .elegant: return .purple.opacity(0.9)
        case .glamorous: return .purple.opacity(0.9)
        case .natural: return .green.opacity(0.9)
        case .adventurous: return .orange.opacity(0.9)
        case .luxury: return .purple.opacity(0.9)
        case .bold: return .black.opacity(0.9)
        }
    }
    
<<<<<<< Updated upstream
    var outfits: [VibeOutfit] {
        switch self {
        case .elegant:
            return [
=======
<<<<<<< HEAD
    var outfits: [Outfit] {
        switch self {
        case .elegant:
            return [
                Outfit(
                    name: "statement earrings moment",
                    emoji: "🌟",
                    description: "camera-ready glamour with that international star energy",
                    vibe: "global icon",
                    items: ["designer gown", "statement jewelry", "red carpet heels", "luxury clutch"],
                    price: "$$$$$",
                    category: "Red Carpet",
                    colorScheme: [Color(red: 0.9, green: 0.6, blue: 0.8), Color(red: 1.0, green: 0.8, blue: 0.9)]
=======
    var outfits: [VibeOutfit] {
        switch self {
        case .elegant:
            return [
>>>>>>> Stashed changes
                VibeOutfit(
                    category: "timeless elegance ✨",
                    outfit: "pearl necklace + silk blouse + tailored pants",
                    makeup: "natural glow + soft pink lips + defined brows",
                    earrings: "classic pearl studs for understated beauty",
                    vibe: "sophisticated grace",
                    colors: [.cream, .pink]
                ),
                VibeOutfit(
                    category: "evening refinement 💫",
                    outfit: "black cocktail dress + gold jewelry + sleek hair",
                    makeup: "smoky eyes + nude lips + highlighted cheekbones",
                    earrings: "gold hoops that whisper luxury",
                    vibe: "quiet confidence",
                    colors: [.gold, .black]
                ),
                VibeOutfit(
                    category: "daytime poise 🌸",
                    outfit: "flowing maxi dress + sandals + straw hat",
                    makeup: "dewy skin + tinted lip balm + fluttery lashes",
                    earrings: "delicate gold chains for effortless charm",
                    vibe: "gentle strength",
                    colors: [.pink, .cream]
<<<<<<< Updated upstream
=======
>>>>>>> a5513a5 (changed analysisview)
>>>>>>> Stashed changes
                )
            ]
        case .glamorous:
            return [
<<<<<<< Updated upstream
                VibeOutfit(
                    category: "red carpet goddess 💫",
                    outfit: "sequin gown + statement jewelry + dramatic hair",
                    makeup: "bold red lips + winged liner + contoured cheeks",
                    earrings: "chandelier earrings that demand attention",
                    vibe: "unapologetic glamour",
                    colors: [.pink, .purple]
                ),
=======
<<<<<<< HEAD
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
                    name: "golden bangles stack",
                    emoji: "💫",
                    description: "sparkly vibes for when you're the main event",
                    vibe: "radiant beauty",
                    items: ["shimmer dress", "crystal jewelry", "sparkly shoes", "glitter makeup"],
                    price: "$$$$",
                    category: "Party",
                    colorScheme: [Color(red: 1.0, green: 0.9, blue: 0.8), Color(red: 0.8, green: 0.8, blue: 1.0)]
=======
                VibeOutfit(
                    category: "red carpet goddess 💫",
                    outfit: "sequin gown + statement jewelry + dramatic hair",
                    makeup: "bold red lips + winged liner + contoured cheeks",
                    earrings: "chandelier earrings that demand attention",
                    vibe: "unapologetic glamour",
                    colors: [.pink, .purple]
                ),
>>>>>>> Stashed changes
                VibeOutfit(
                    category: "party queen ✨",
                    outfit: "mini dress + strappy heels + leather jacket",
                    makeup: "glitter eyeshadow + glossy lips + false lashes",
                    earrings: "oversized hoops for maximum impact",
                    vibe: "center of attention",
                    colors: [.purple, .orange]
                ),
                VibeOutfit(
                    category: "fashion week energy 🔥",
                    outfit: "power suit + stilettos + designer bag",
                    makeup: "bold brows + nude lips + bronzed glow",
                    earrings: "geometric statement pieces",
                    vibe: "runway ready",
                    colors: [.orange, .pink]
<<<<<<< Updated upstream
=======
>>>>>>> a5513a5 (changed analysisview)
>>>>>>> Stashed changes
                )
            ]
        case .natural:
            return [
<<<<<<< Updated upstream
=======
<<<<<<< HEAD
                Outfit(
                    name: "princess polly halter mini dress",
                    emoji: "🪩",
                    description: "giving main character energy with that iconic disco glam aesthetic",
                    vibe: "sparkly queen",
                    items: ["disco ball dress", "sparkly jewelry", "glitter heels", "shimmer makeup"],
                    price: "$$$$$",
                    category: "Disco",
                    colorScheme: [Color(red: 0.8, green: 0.8, blue: 1.0), Color(red: 1.0, green: 0.9, blue: 0.8)]
=======
>>>>>>> Stashed changes
                VibeOutfit(
                    category: "earth goddess 🌸",
                    outfit: "flowing dress + sandals + flower crown",
                    makeup: "minimal foundation + rosy cheeks + natural lips",
                    earrings: "wooden hoops with delicate charms",
                    vibe: "connected to nature",
                    colors: [.green, .blue]
                ),
                VibeOutfit(
                    category: "free spirit ✨",
                    outfit: "crop top + high waisted jeans + bare feet",
                    makeup: "sunscreen + lip balm + mascara only",
                    earrings: "tiny gold studs for subtle beauty",
                    vibe: "effortlessly beautiful",
                    colors: [.blue, .green]
                ),
                VibeOutfit(
                    category: "bohemian dream 🌿",
                    outfit: "maxi skirt + peasant blouse + layered jewelry",
                    makeup: "bronzer + tinted moisturizer + natural brows",
                    earrings: "feather earrings for wanderlust vibes",
                    vibe: "soulful beauty",
                    colors: [.yellow, .green]
<<<<<<< Updated upstream
=======
>>>>>>> a5513a5 (changed analysisview)
>>>>>>> Stashed changes
                )
            ]
        case .adventurous:
            return [
<<<<<<< Updated upstream
=======
<<<<<<< HEAD
                Outfit(
                    name: "princess polly halter mini dress",
                    emoji: "🪩",
                    description: "giving main character energy with that iconic disco glam aesthetic",
                    vibe: "sparkly queen",
                    items: ["disco ball dress", "sparkly jewelry", "glitter heels", "shimmer makeup"],
                    price: "$$$$$",
                    category: "Disco",
                    colorScheme: [Color(red: 0.8, green: 0.8, blue: 1.0), Color(red: 1.0, green: 0.9, blue: 0.8)]
=======
>>>>>>> Stashed changes
                VibeOutfit(
                    category: "wild child 🚀",
                    outfit: "leather jacket + ripped jeans + combat boots",
                    makeup: "smudged liner + bold lips + tousled hair",
                    earrings: "multiple piercings with silver hoops",
                    vibe: "fearless energy",
                    colors: [.orange, .red]
                ),
                VibeOutfit(
                    category: "explorer chic ✈️",
                    outfit: "cargo pants + tank top + hiking boots",
                    makeup: "sweat-proof foundation + waterproof mascara",
                    earrings: "small studs that won't get in the way",
                    vibe: "ready for anything",
                    colors: [.red, .orange]
                ),
                VibeOutfit(
                    category: "urban adventurer 🏙️",
                    outfit: "athleisure set + sneakers + backpack",
                    makeup: "quick concealer + tinted lip balm + brows",
                    earrings: "sporty studs for active lifestyle",
                    vibe: "city explorer",
                    colors: [.pink, .orange]
<<<<<<< Updated upstream
=======
>>>>>>> a5513a5 (changed analysisview)
>>>>>>> Stashed changes
                )
            ]
        case .luxury:
            return [
<<<<<<< Updated upstream
                VibeOutfit(
                    category: "royal elegance 👑",
                    outfit: "designer gown + diamond jewelry + updo",
                    makeup: "flawless base + red lips + winged liner",
                    earrings: "diamond studs that sparkle like stars",
                    vibe: "regal presence",
                    colors: [.gold, .purple]
=======
<<<<<<< HEAD
                Outfit(
                    name: "princess polly halter mini dress",
                    emoji: "🪩",
                    description: "giving main character energy with that iconic disco glam aesthetic",
                    vibe: "sparkly queen",
                    items: ["disco ball dress", "sparkly jewelry", "glitter heels", "shimmer makeup"],
                    price: "$$$$$",
                    category: "Disco",
                    colorScheme: [Color(red: 0.8, green: 0.8, blue: 1.0), Color(red: 1.0, green: 0.9, blue: 0.8)]
>>>>>>> Stashed changes
                ),
                VibeOutfit(
                    category: "luxury casual ✨",
                    outfit: "cashmere sweater + silk pants + loafers",
                    makeup: "natural glow + defined brows + nude lips",
                    earrings: "gold hoops with pearl accents",
                    vibe: "understated wealth",
                    colors: [.cream, .gold]
                ),
<<<<<<< Updated upstream
=======
                Outfit(
                    name: "luxury bag essentials",
                    emoji: "✨",
                    description: "timeless sparkle with that iconic diva energy",
                    vibe: "timeless glamour",
                    items: ["sparkly lehenga", "traditional jewelry", "glitter accessories", "shimmer dupatta"],
                    price: "$$$$$",
                    category: "Traditional",
                    colorScheme: [Color(red: 1.0, green: 0.8, blue: 0.0), Color(red: 0.9, green: 0.7, blue: 1.0)]
=======
                VibeOutfit(
                    category: "royal elegance 👑",
                    outfit: "designer gown + diamond jewelry + updo",
                    makeup: "flawless base + red lips + winged liner",
                    earrings: "diamond studs that sparkle like stars",
                    vibe: "regal presence",
                    colors: [.gold, .purple]
                ),
                VibeOutfit(
                    category: "luxury casual ✨",
                    outfit: "cashmere sweater + silk pants + loafers",
                    makeup: "natural glow + defined brows + nude lips",
                    earrings: "gold hoops with pearl accents",
                    vibe: "understated wealth",
                    colors: [.cream, .gold]
                ),
>>>>>>> Stashed changes
                VibeOutfit(
                    category: "evening opulence 💎",
                    outfit: "sequin dress + fur stole + stilettos",
                    makeup: "contoured cheeks + bold eyes + glossy lips",
                    earrings: "chandelier earrings with precious stones",
                    vibe: "luxury personified",
                    colors: [.purple, .gold]
<<<<<<< Updated upstream
=======
>>>>>>> a5513a5 (changed analysisview)
>>>>>>> Stashed changes
                )
            ]
        case .bold:
            return [
<<<<<<< Updated upstream
=======
<<<<<<< HEAD
                Outfit(
                    name: "princess polly halter mini dress",
                    emoji: "🪩",
                    description: "giving main character energy with that iconic disco glam aesthetic",
                    vibe: "sparkly queen",
                    items: ["disco ball dress", "sparkly jewelry", "glitter heels", "shimmer makeup"],
                    price: "$$$$$",
                    category: "Disco",
                    colorScheme: [Color(red: 0.8, green: 0.8, blue: 1.0), Color(red: 1.0, green: 0.9, blue: 0.8)]
=======
>>>>>>> Stashed changes
                VibeOutfit(
                    category: "power babe 🔥",
                    outfit: "black blazer + red dress + stilettos",
                    makeup: "bold red lips + smoky eyes + contoured cheeks",
                    earrings: "statement gold hoops for confidence",
                    vibe: "unstoppable force",
                    colors: [.black, .red]
                ),
                VibeOutfit(
                    category: "fashion rebel 💫",
                    outfit: "leather pants + crop top + ankle boots",
                    makeup: "dark lips + winged liner + bronzed glow",
                    earrings: "multiple ear cuffs and studs",
                    vibe: "rule breaker",
                    colors: [.red, .black]
                ),
                VibeOutfit(
                    category: "boss energy 👑",
                    outfit: "power suit + silk blouse + pointed heels",
                    makeup: "defined brows + nude lips + highlighted cheekbones",
                    earrings: "geometric gold earrings for authority",
                    vibe: "natural leader",
                    colors: [.purple, .black]
<<<<<<< Updated upstream
=======
>>>>>>> a5513a5 (changed analysisview)
>>>>>>> Stashed changes
                )
            ]
        }
    }
}

// MARK: - Vibe Outfit Model
struct VibeOutfit {
    let category: String
    let outfit: String
    let makeup: String
    let earrings: String
    let vibe: String
    let colors: [Color]
<<<<<<< Updated upstream
=======
<<<<<<< HEAD
    let imageNames: [String]
=======
>>>>>>> a5513a5 (changed analysisview)
>>>>>>> Stashed changes
}

// MARK: - Vibe Outfit Card
struct VibeOutfitCard: View {
    let outfit: VibeOutfit
    let vibe: VibeTheme
    
    var body: some View {
        VStack(spacing: 20) {
            HStack {
                Text(outfit.category)
                    .font(.system(size: 18, weight: .bold))
                    .foregroundColor(vibe.textColor)
                
                Spacer()
                
                Text(outfit.vibe)
                    .font(.system(size: 12, weight: .bold))
                    .foregroundColor(.white)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 6)
                    .background(
                        Capsule()
                            .fill(outfit.colors[0])
                    )
            }
            
<<<<<<< Updated upstream
=======
<<<<<<< HEAD
            // Image gallery for the outfit
            if !outfit.imageNames.isEmpty {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 15) {
                        ForEach(outfit.imageNames, id: \.self) { imageName in
                            AsyncImage(url: Bundle.main.url(forResource: imageName, withExtension: nil)) { image in
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 120, height: 120)
                                    .clipShape(RoundedRectangle(cornerRadius: 16))
                            } placeholder: {
                                // If the async image fails, use the regular Image
                                Image(imageName)
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 120, height: 120)
                                    .clipShape(RoundedRectangle(cornerRadius: 16))
                            }
                        }
                    }
                    .padding(.horizontal, 5)
                }
            }
            
=======
>>>>>>> a5513a5 (changed analysisview)
>>>>>>> Stashed changes
            VStack(spacing: 15) {
                VibeOutfitDetail(
                    title: "fit",
                    detail: outfit.outfit,
                    emoji: "👗",
                    color: outfit.colors[0],
                    vibe: vibe
                )
                
                VibeOutfitDetail(
                    title: "makeup",
                    detail: outfit.makeup,
                    emoji: "💄",
                    color: outfit.colors[1],
                    vibe: vibe
                )
                
                VibeOutfitDetail(
                    title: "earrings",
                    detail: outfit.earrings,
                    emoji: "💎",
                    color: outfit.colors[0],
                    vibe: vibe
                )
            }
        }
        .padding(25)
        .background(
            RoundedRectangle(cornerRadius: 25)
                .fill(Color.white.opacity(0.95))
                .shadow(color: outfit.colors[0].opacity(0.15), radius: 15, x: 0, y: 8)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 25)
                .stroke(
                    LinearGradient(
                        colors: [outfit.colors[0].opacity(0.3), outfit.colors[1].opacity(0.2)],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    ),
                    lineWidth: 1.5
                )
        )
    }
}

// MARK: - Vibe Outfit Detail
struct VibeOutfitDetail: View {
    let title: String
    let detail: String
    let emoji: String
    let color: Color
    let vibe: VibeTheme
    
    var body: some View {
        HStack(spacing: 15) {
            Text(emoji)
                .font(.system(size: 20))
            
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.system(size: 14, weight: .bold))
                    .foregroundColor(color)
                
                Text(detail)
                    .font(.system(size: 13, weight: .medium))
<<<<<<< Updated upstream
                    .foregroundColor(.black.opacity(0.8))
=======
<<<<<<< HEAD
                .foregroundColor(.black.opacity(0.8))
=======
                    .foregroundColor(.black.opacity(0.8))
>>>>>>> a5513a5 (changed analysisview)
>>>>>>> Stashed changes
                    .lineLimit(2)
            }
            
            Spacer()
        }
        .padding(.horizontal, 18)
        .padding(.vertical, 15)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(color.opacity(0.08))
<<<<<<< HEAD
                .stroke(color.opacity(0.2), lineWidth: 1)
        )
    }
}

// MARK: - Dating Recommendations Card
struct DatingRecommendationsCard: View {
    var body: some View {
        VStack(spacing: 18) {
            Text("dating recommendations ✨")
                .font(.system(size: 18, weight: .bold))
                .foregroundColor(.pink)
            
            VStack(spacing: 12) {
                DatingRecommendation(
                    name: "alex",
                    age: "26",
                    vibe: "emotionally available and ready",
                    match: "89%",
                    color: .pink
                )
                
                DatingRecommendation(
                    name: "jordan",
                    age: "28",
                    vibe: "mature energy, good communication",
                    match: "92%",
                    color: .purple
                )
                
                DatingRecommendation(
                    name: "riley",
                    age: "25",
                    vibe: "adventurous but grounded",
                    match: "85%",
                    color: .orange
                )
            }
        }
        .padding(25)
        .background(
            RoundedRectangle(cornerRadius: 25)
                .fill(
                    LinearGradient(
                        colors: [Color.white.opacity(0.95), Color.pink.opacity(0.05)],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .shadow(color: .pink.opacity(0.15), radius: 12, x: 0, y: 6)
        )
    }
}

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
=======
>>>>>>> a5513a5 (changed analysisview)
                .stroke(color.opacity(0.2), lineWidth: 1)
        )
    }
}

<<<<<<< HEAD
=======
// MARK: - Dating Recommendations Card
struct DatingRecommendationsCard: View {
    var body: some View {
        VStack(spacing: 18) {
            Text("dating recommendations ✨")
                .font(.system(size: 18, weight: .bold))
                .foregroundColor(.pink)
            
            VStack(spacing: 12) {
                DatingRecommendation(
                    name: "alex",
                    age: "26",
                    vibe: "emotionally available and ready",
                    match: "89%",
                    color: .pink
                )
                
                DatingRecommendation(
                    name: "jordan",
                    age: "28",
                    vibe: "mature energy, good communication",
                    match: "92%",
                    color: .purple
                )
                
                DatingRecommendation(
                    name: "riley",
                    age: "25",
                    vibe: "adventurous but grounded",
                    match: "85%",
                    color: .orange
                )
            }
        }
        .padding(25)
        .background(
            RoundedRectangle(cornerRadius: 25)
                .fill(
                    LinearGradient(
                        colors: [Color.white.opacity(0.95), Color.pink.opacity(0.05)],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .shadow(color: .pink.opacity(0.15), radius: 12, x: 0, y: 6)
        )
    }
}

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

>>>>>>> a5513a5 (changed analysisview)
// MARK: - Floating Sparkles
struct FloatingSparkle {
    var x: CGFloat = CGFloat.random(in: -50...400)
    var y: CGFloat = CGFloat.random(in: 0...800)
    var scale: CGFloat = CGFloat.random(in: 0.5...1.2)
    var opacity: Double = Double.random(in: 0.3...0.8)
    var speed: Double = Double.random(in: 3...8)
}


// MARK: - ICONIC Supporting Views

// Love Story Timeline - ICONIC
struct LoveStoryTimelineCard: View {
    var body: some View {
        VStack(spacing: 20) {
            Text("ur love story timeline 💕")
                .font(.system(size: 20, weight: .bold))
                .foregroundStyle(
                    LinearGradient(
                        colors: [.pink, .orange],
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )
            
            VStack(spacing: 18) {
                TimelineEvent(
                    name: "raghav",
                    period: "2020-2021",
                    vibe: "first love energy • noah from the notebook",
                    color: .pink,
                    position: .left
                )
                
                TimelineEvent(
                    name: "matt burdulis",
                    period: "2021-2022",
                    vibe: "adventure chapter • bunny from yjhd",
                    color: .purple,
                    position: .right
                )
                
                TimelineEvent(
                    name: "aditya mehra",
                    period: "2022",
                    vibe: "learning experience • jacob from twilight",
                    color: .orange,
                    position: .left
                )
                
                TimelineEvent(
                    name: "teg singh",
                    period: "2023",
                    vibe: "brief connection • sebastian from la la land",
                    color: .pink,
                    position: .right
                )
                
                TimelineEvent(
                    name: "aditya mehra (again)",
                    period: "early 2024",
                    vibe: "second chances don't work • mr. big energy",
                    color: .purple,
                    position: .left
                )
                
                CurrentSingleStage()
            }
        }
        .padding(25)
        .background(
            RoundedRectangle(cornerRadius: 25)
                .fill(
                    LinearGradient(
                        colors: [Color.white.opacity(0.95), Color.orange.opacity(0.08)],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .shadow(color: .orange.opacity(0.15), radius: 12, x: 0, y: 6)
        )
    }
}

struct TimelineEvent: View {
    let name: String
    let period: String
    let vibe: String
    let color: Color
    let position: TimelinePosition
    
    enum TimelinePosition {
        case left, right
    }
    
    var body: some View {
        HStack {
            if position == .right {
                Spacer()
            }
            
            VStack(spacing: 0) {
                Circle()
                    .fill(
                        LinearGradient(
                            colors: [color, color.opacity(0.7)],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .frame(width: 16, height: 16)
                
                Rectangle()
                    .fill(color.opacity(0.3))
                    .frame(width: 2, height: 40)
            }
            
            VStack(alignment: position == .left ? .leading : .trailing, spacing: 6) {
                Text(name)
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(color)
                
                Text(period)
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(.purple.opacity(0.8))
                
                Text(vibe)
                    .font(.system(size: 12, weight: .medium))
                    .foregroundColor(.purple.opacity(0.6))
            }
            .padding(.horizontal, 15)
            .padding(.vertical, 12)
            .background(
                RoundedRectangle(cornerRadius: 15)
                    .fill(color.opacity(0.1))
                    .stroke(color.opacity(0.3), lineWidth: 1)
            )
            
            if position == .left {
                Spacer()
            }
        }
    }
}

struct CurrentSingleStage: View {
    @State private var glowAnimation = false
    
    var body: some View {
        VStack(spacing: 15) {
            HStack {
                VStack(spacing: 0) {
                    Circle()
                        .fill(
                            LinearGradient(
                                colors: [.pink, .purple, .orange],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .frame(width: 20, height: 20)
                        .scaleEffect(glowAnimation ? 1.2 : 1.0)
                        .animation(
                            .easeInOut(duration: 2.0)
                            .repeatForever(autoreverses: true),
                            value: glowAnimation
                        )
                }
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("ur single era 👑")
                        .font(.system(size: 18, weight: .bold))
                        .foregroundStyle(
                            LinearGradient(
                                colors: [.pink, .purple],
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                    
                    Text("feb 2024 - july 2025 (and counting)")
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(.purple.opacity(0.8))
                    
                    Text("main character energy unlocked ✨")
                        .font(.system(size: 12, weight: .medium))
                        .foregroundColor(.purple.opacity(0.6))
                }
                
                Spacer()
            }
        }
        .padding(20)
        .background(
            RoundedRectangle(cornerRadius: 18)
                .fill(
                    LinearGradient(
                        colors: [Color.white.opacity(0.9), Color.pink.opacity(0.1)],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .stroke(
                    LinearGradient(
                        colors: [.pink.opacity(0.4), .purple.opacity(0.3)],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    ),
                    lineWidth: 2
                )
                .shadow(color: .pink.opacity(0.2), radius: 10, x: 0, y: 5)
        )
        .onAppear {
            glowAnimation = true
        }
    }
}



// Healing Era Card
struct HealingEraCard: View {
    @State private var sparkleAnimation = false
    
    var body: some View {
        VStack(spacing: 20) {
            HStack {
                Text("healing era activated 🌸")
                    .font(.system(size: 20, weight: .bold))
                    .foregroundStyle(
                        LinearGradient(
                            colors: [.pink, .purple],
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                
                Spacer()
                
                Text("✨")
                    .font(.system(size: 18))
                    .scaleEffect(sparkleAnimation ? 1.3 : 1.0)
                    .animation(
                        .easeInOut(duration: 1.5)
                        .repeatForever(autoreverses: true),
                        value: sparkleAnimation
                    )
            }
            
            VStack(spacing: 15) {
                HealingActivity(
                    activity: "daily affirmations",
                    description: "reminding urself ur a queen",
                    emoji: "👑",
                    color: .pink
                )
                
                HealingActivity(
                    activity: "self care sundays",
                    description: "face masks and good vibes only",
                    emoji: "🧴",
                    color: .purple
                )
                
                HealingActivity(
                    activity: "journaling ur growth",
                    description: "tracking ur main character moments",
                    emoji: "📖",
                    color: .orange
                )
            }
        }
        .onAppear {
            sparkleAnimation = true
        }
    }
}

struct HealingActivity: View {
    let activity: String
    let description: String
    let emoji: String
    let color: Color
    
    var body: some View {
        HStack(spacing: 15) {
            Text(emoji)
                .font(.system(size: 24))
            
            VStack(alignment: .leading, spacing: 4) {
                Text(activity)
                    .font(.system(size: 15, weight: .bold))
                    .foregroundColor(color)
                
                Text(description)
                    .font(.system(size: 13, weight: .medium))
                    .foregroundColor(.purple.opacity(0.7))
            }
            
            Spacer()
        }
        .padding(15)
        .background(
            RoundedRectangle(cornerRadius: 15)
                .fill(color.opacity(0.1))
                .stroke(color.opacity(0.2), lineWidth: 1)
        )
    }
}

// Iconic Character Card
struct IconicCharacterCard: View {
    var body: some View {
        VStack(spacing: 20) {
            Text("ur life is giving... 🎬")
                .font(.system(size: 20, weight: .bold))
                .foregroundStyle(
                    LinearGradient(
                        colors: [.purple, .orange],
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )
            
            VStack(spacing: 15) {
                Text("naina talwar from yeh jawaani hai deewani")
                    .font(.system(size: 18, weight: .bold))
                    .foregroundColor(.purple)
                    .multilineTextAlignment(.center)
                
                Text("the quiet girl who found her confidence and started living life on her own terms 🦋")
                    .font(.system(size: 15, weight: .medium))
                    .foregroundColor(.purple.opacity(0.8))
                    .multilineTextAlignment(.center)
                    .lineSpacing(4)
                
                VStack(spacing: 8) {
                    CharacterTrait(trait: "transformed from shy to confident", emoji: "🌟")
                    CharacterTrait(trait: "learned to prioritize herself", emoji: "💝")
                    CharacterTrait(trait: "glowed up inside and out", emoji: "✨")
                }
            }
        }
        .padding(25)
        .background(
            RoundedRectangle(cornerRadius: 25)
                .fill(
                    LinearGradient(
                        colors: [Color.white.opacity(0.95), Color.purple.opacity(0.08)],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .shadow(color: .purple.opacity(0.15), radius: 12, x: 0, y: 6)
        )
    }
}

struct CharacterTrait: View {
    let trait: String
    let emoji: String
    
    var body: some View {
        HStack(spacing: 12) {
            Text(emoji)
                .font(.system(size: 16))
            
            Text(trait)
                .font(.system(size: 14, weight: .medium))
                .foregroundColor(.purple.opacity(0.8))
            
            Spacer()
        }
        .padding(.horizontal, 15)
        .padding(.vertical, 10)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.purple.opacity(0.05))
                .stroke(Color.purple.opacity(0.15), lineWidth: 1)
        )
    }
}

// Enhanced Indian Rashi Card
struct EnhancedIndianRashiCard: View {
    @State private var glowAnimation = false
    
    var body: some View {
        VStack(spacing: 20) {
            HStack {
                VStack(alignment: .leading, spacing: 8) {
                    Text("अश्विनी (ashwini)")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(.orange)
                    
                    Text("horse energy - fast, free, unstoppable")
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(.orange.opacity(0.8))
                }
                
                Spacer()
                
                Text("🐎")
                    .font(.system(size: 32))
                    .scaleEffect(glowAnimation ? 1.1 : 1.0)
                    .animation(
                        .easeInOut(duration: 2.0)
                        .repeatForever(autoreverses: true),
                        value: glowAnimation
                    )
            }
        }
    }
}
#Preview {
    AnalysisView()
        .environmentObject(GlowGirlViewModel())
}
