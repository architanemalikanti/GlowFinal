//
//  DatingRecommendation.swift
//  GlowGirl
//
//  Created by Archita Nemalikanti on 7/29/25.
//

import SwiftUI

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
    DatingRecommendation(name: "alex", age: "26", vibe: "emotionally available", match: "89%", color: .pink)
}
