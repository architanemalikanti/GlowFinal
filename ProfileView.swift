//
//  ProfileView.swift
//  GlowGirl
//
//  Created by Archita Nemalikanti on 7/8/25.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var authManager: AuthManager
    @EnvironmentObject var glowViewModel: GlowGirlViewModel
    @State private var showingVentButton = true
    
    var body: some View {
        ZStack {
            // Background gradient
            LinearGradient(
                colors: [Color.pink.opacity(0.1), Color.purple.opacity(0.1)],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            VStack(spacing: 30) {
                // Header
                VStack(spacing: 15) {
                    Image(systemName: "person.circle.fill")
                        .font(.system(size: 80))
                        .foregroundStyle(
                            LinearGradient(
                                colors: [.pink, .purple],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                    
                    Text("Your Glow Profile ✨")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.pink)
                    
                    Text("Keep shining, queen! 👑")
                        .font(.subheadline)
                        .foregroundColor(.purple)
                }
                
                // Profile Stats
                VStack(spacing: 20) {
                    HStack(spacing: 30) {
                        VStack {
                            Text("5")
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundColor(.pink)
                            Text("Vent Sessions")
                                .font(.caption)
                                .foregroundColor(.purple)
                        }
                        
                        VStack {
                            Text("12")
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundColor(.pink)
                            Text("Glow Up Plans")
                                .font(.caption)
                                .foregroundColor(.purple)
                        }
                        
                        VStack {
                            Text("3")
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundColor(.pink)
                            Text("Fave Looks")
                                .font(.caption)
                                .foregroundColor(.purple)
                        }
                    }
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 15)
                            .fill(.white.opacity(0.3))
                            .shadow(color: .pink.opacity(0.2), radius: 10, x: 0, y: 5)
                    )
                }
                
                // Recent Activity
                VStack(alignment: .leading, spacing: 15) {
                    Text("Recent Tea Sessions 🍵")
                        .font(.headline)
                        .foregroundColor(.pink)
                    
                    VStack(spacing: 10) {
                        HStack {
                            Image(systemName: "heart.fill")
                                .foregroundColor(.pink)
                            Text("Breakup glow-up session")
                                .foregroundColor(.purple)
                            Spacer()
                            Text("2 days ago")
                                .font(.caption)
                                .foregroundColor(.purple.opacity(0.7))
                        }
                        
                        HStack {
                            Image(systemName: "star.fill")
                                .foregroundColor(.pink)
                            Text("Friendship drama vent")
                                .foregroundColor(.purple)
                            Spacer()
                            Text("1 week ago")
                                .font(.caption)
                                .foregroundColor(.purple.opacity(0.7))
                        }
                        
                        HStack {
                            Image(systemName: "sparkles")
                                .foregroundColor(.pink)
                            Text("Career challenge tea")
                                .foregroundColor(.purple)
                            Spacer()
                            Text("2 weeks ago")
                                .font(.caption)
                                .foregroundColor(.purple.opacity(0.7))
                        }
                    }
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 15)
                            .fill(.white.opacity(0.3))
                            .shadow(color: .pink.opacity(0.2), radius: 10, x: 0, y: 5)
                    )
                }
                
                Spacer()
                
                // Vent Again Button
                NavigationLink(destination: DashboardHomeView()) {
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
                
                // Logout Button
                Button(action: {
                    authManager.logout()
                }) {
                    Text("Logout")
                        .foregroundColor(.purple.opacity(0.7))
                        .underline()
                }
                .padding(.bottom)
            }
            .padding()
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading:
            Button(action: {
                // Go back to voice recording
                glowViewModel.currentState = .dashboard
            }) {
                HStack {
                    Image(systemName: "chevron.left")
                    Text("Back")
                }
                .foregroundColor(.pink)
            }
        )
    }
}

#Preview {
    ProfileView()
        .environmentObject(AuthManager())
        .environmentObject(GlowGirlViewModel())
}
