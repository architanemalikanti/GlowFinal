import Foundation
import SwiftUI
import Combine

// MARK: - App State Management
enum AppState {
    case dashboard
    case analyzing
    case recommendations
}

enum RecommendationType: String, CaseIterable, Codable {
    case makeup = "Makeup"
    case skincare = "Skincare"
    case haircare = "Hair Care"
    case hairdye = "Hair Dye"
    case clothing = "Clothing"
}

// MARK: - Beauty Recommendation Model (for backwards compatibility)
struct BeautyRecommendation: Identifiable, Codable {
    let id: UUID
    let title: String
    let description: String
    let price: String?
    let reasoning: String
    let category: RecommendationType
    let brand: String?
    let imageURL: String?
    
    init(
        title: String,
        description: String,
        price: String? = nil,
        reasoning: String,
        category: RecommendationType,
        brand: String? = nil,
        imageURL: String? = nil
    ) {
        self.id = UUID()
        self.title = title
        self.description = description
        self.price = price
        self.reasoning = reasoning
        self.category = category
        self.brand = brand
        self.imageURL = imageURL
    }
}

class GlowGirlViewModel: ObservableObject {
    // MARK: - State Management
    @Published var currentState: AppState = .dashboard
    
    // MARK: - API Response (Primary)
    @Published var glowUpResponse: GlowUpResponse?
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var showAnalysisView = false
    
    // MARK: - Legacy Support
    @Published var recommendations: [BeautyRecommendation] = []
    @Published var teaAnalysis: TeaAnalysis?
    
    // MARK: - Voice recording properties
    @Published var recordingURL: URL?
    @Published var recordingDuration: TimeInterval = 0
    @Published var ventText: String = ""
    
    private let apiService = GlowUpAPIService.shared
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        // No speech service initialization needed
    }

    // MARK: - Tea Session Management
    func startTeaSession() {
        // Reset any previous state
        resetAnalysis()
        print("resent analysis called in start tea sesh")
        
        
        // Navigate to the voice recording/analysis state
        currentState = .analyzing
    }
    
    // MARK: - Voice Analysis (Speech recording is now handled in the View)
    func startVoiceAnalysis() {
        print("🔍 startVoiceAnalysis called with ventText: '\(ventText)'")
        print("🔍 ventText.isEmpty: \(ventText.isEmpty)")
        print("🔍 ventText.count: \(ventText.count)")
        
        guard !ventText.isEmpty else {
            errorMessage = "No text to analyze. Please record something first."
            print("❌ ventText is empty, showing error")
            return
        }
        
        print("✅ ventText has content, starting analysis...")
        currentState = .analyzing
        Task {
            await analyzeVentText()
        }
    }
    
    @MainActor
    private func analyzeVentText() async {
        isLoading = true
        errorMessage = nil
        
        do {
            let response = try await apiService.getGlowUpAdvice(ventText: ventText)
            glowUpResponse = response
            currentState = .recommendations
            showAnalysisView = true
            print("Successfully received glow up advice!")
        } catch {
            errorMessage = "Failed to get glow up advice: \(error.localizedDescription)"
            currentState = .dashboard
            print("Error: \(error)")
        }
        
        isLoading = false
    }
    
    // MARK: - Manual Text Analysis (for testing)
    func analyzeText(_ text: String) {
        ventText = text
        startVoiceAnalysis()
    }
    
    // MARK: - Test Backend Connection
    func testBackendConnection() async {
        do {
            let message = try await apiService.testConnection()
            print("Backend connection successful: \(message)")
        } catch {
            print("Backend connection failed: \(error)")
            errorMessage = "Cannot connect to backend server"
        }
    }
    
    // MARK: - Reset Functions
    func resetAnalysis() {
        glowUpResponse = nil
        ventText = ""
        errorMessage = nil
        showAnalysisView = false
        recordingURL = nil
        recordingDuration = 0
        currentState = .dashboard
    }
    
    func resetSession() {
        resetAnalysis()
        print("reset analysis called in reset sesh")
        recommendations = []
        teaAnalysis = nil
    }
}

// MARK: - Legacy Data Models (for backwards compatibility)
struct TeaAnalysis: Codable {
    let mood: String
    let situation: String
    let vibe: String
    let colorPalette: [String]
    let style: String
}
