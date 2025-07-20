import Foundation
import Speech
import AVFoundation

// MARK: - Glow Up Models
struct GlowUpResponse: Codable {
    let message: String
    let makeupRecommendations: [ProductRecommendation]
    let outfitRecommendations: [ProductRecommendation]
    let quickWins: [String]
    let transformationPlan: String
    
    enum CodingKeys: String, CodingKey {
        case message
        case makeupRecommendations = "makeup_recommendations"
        case outfitRecommendations = "outfit_recommendations"
        case quickWins = "quick_wins"
        case transformationPlan = "transformation_plan"
    }
}

struct ProductRecommendation: Codable, Identifiable {
    let id = UUID()
    let product: String
    let price: String
    let link: String
    let whyPerfect: String
    let confidenceBoost: String
    let stylingTip: String
    
    enum CodingKeys: String, CodingKey {
        case product, price, link
        case whyPerfect = "why_perfect"
        case confidenceBoost = "confidence_boost"
        case stylingTip = "styling_tip"
    }
}

// MARK: - Speech to Text Service
class SpeechToTextService: ObservableObject {
    private let speechRecognizer = SFSpeechRecognizer(locale: Locale(identifier: "en-US"))
    private var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
    private var recognitionTask: SFSpeechRecognitionTask?
    private let audioEngine = AVAudioEngine()
    
    @Published var transcribedText = ""
    @Published var isRecording = false
    
    init() {
        requestSpeechAuthorization()
    }
    
    private func requestSpeechAuthorization() {
        SFSpeechRecognizer.requestAuthorization { authStatus in
            DispatchQueue.main.async {
                switch authStatus {
                case .authorized:
                    print("Speech recognition authorized")
                case .denied:
                    print("Speech recognition authorization denied")
                case .restricted:
                    print("Speech recognition restricted")
                case .notDetermined:
                    print("Speech recognition not yet authorized")
                @unknown default:
                    print("Unknown speech recognition authorization status")
                }
            }
        }
    }
    
    func startRecording() throws {
        // Cancel any previous task
        recognitionTask?.cancel()
        recognitionTask = nil
        
        // Configure audio session
        let audioSession = AVAudioSession.sharedInstance()
        try audioSession.setCategory(.record, mode: .measurement, options: .duckOthers)
        try audioSession.setActive(true, options: .notifyOthersOnDeactivation)
        
        // Create recognition request
        recognitionRequest = SFSpeechAudioBufferRecognitionRequest()
        guard let recognitionRequest = recognitionRequest else {
            throw SpeechError.recognitionRequestFailed
        }
        
        recognitionRequest.shouldReportPartialResults = true
        
        // Configure audio input
        let inputNode = audioEngine.inputNode
        let recordingFormat = inputNode.outputFormat(forBus: 0)
        
        inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { buffer, _ in
            recognitionRequest.append(buffer)
        }
        
        // Start audio engine
        audioEngine.prepare()
        try audioEngine.start()
        
        // Start recognition
        recognitionTask = speechRecognizer?.recognitionTask(with: recognitionRequest) { [weak self] result, error in
            DispatchQueue.main.async {
                if let result = result {
                    self?.transcribedText = result.bestTranscription.formattedString
                    
                }
                
                if error != nil || result?.isFinal == true {
                    self?.stopRecording()
                }
            }
        }
        
        isRecording = true
    }
    
    func stopRecording() {
        audioEngine.stop()
        audioEngine.inputNode.removeTap(onBus: 0)
        recognitionRequest?.endAudio()
        recognitionRequest = nil
        recognitionTask?.cancel()
        recognitionTask = nil
        isRecording = false
    }
}

enum SpeechError: Error {
    case recognitionRequestFailed
    case audioEngineFailed
}

// MARK: - Backend API Service
class GlowUpAPIService {
    static let shared = GlowUpAPIService()
    private let baseURL = "https://glow-up-backend.onrender.com/" // Your Flask backend URL
    
    private init() {}
    
    func getGlowUpAdvice(ventText: String) async throws -> GlowUpResponse {
        guard let url = URL(string: "\(baseURL)/api/glow-up-advice") else {
            throw APIError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // Add auth token if you have authentication
        if let token = UserDefaults.standard.string(forKey: "authToken") {
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
        
        let requestBody = ["vent_text": ventText]
        request.httpBody = try JSONSerialization.data(withJSONObject: requestBody)
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw APIError.invalidResponse
        }
        
        guard httpResponse.statusCode == 200 else {
            throw APIError.serverError("HTTP \(httpResponse.statusCode)")

        }
        
        let decoder = JSONDecoder()
        return try decoder.decode(GlowUpResponse.self, from: data)
    }
    
    // Test connection to backend
    func testConnection() async throws -> String {
        guard let url = URL(string: "\(baseURL)/api/test") else {
            throw APIError.invalidURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
            throw APIError.serverError("Connection failed")
        }
        
        if let json = try JSONSerialization.jsonObject(with: data) as? [String: Any],
           let message = json["message"] as? String {
            return message
        }
        
        throw APIError.decodingError
    }
}

// MARK: - API Errors
enum APIError: Error, LocalizedError {
    case invalidURL
    case invalidResponse
    case serverError(String)  // Change from Int to String
    case decodingError
    case networkError
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Invalid URL"
        case .invalidResponse:
            return "Invalid response from server"
        case .serverError(let message):  // Change from code to message
            return "Server error: \(message)"
        case .decodingError:
            return "Failed to process server response"
        case .networkError:
            return "Network error"
        }
    }
}
