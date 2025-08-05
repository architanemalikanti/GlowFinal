import SwiftUI

struct AnalysisView: View {
    @EnvironmentObject var viewModel: GlowGirlViewModel
    
    var body: some View {
        DeepikaGlamView()
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
