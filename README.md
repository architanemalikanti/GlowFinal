# GlowGirl ✨

A Gen Z beauty app that turns your vents into personalized glow-up recommendations! Spill the tea about your life, and get AI-curated beauty products that match your vibe.

## Features 🌟

### 1. Voice-to-Text Venting
- **Big sparkle button** on the dashboard to start recording
- **Real-time transcription** as you speak your tea
- **Speech recognition** using iOS Speech framework
- **Girly Gen Z aesthetic** with pink/purple gradients and emojis

### 2. AI Tea Analysis
- **OpenAI GPT-3.5** analyzes your emotional state
- **Mood detection**: heartbroken, excited, confused, empowered, etc.
- **Vibe analysis**: revenge glow, self-love, confidence boost, etc.
- **Style direction**: edgy, soft, bold, minimalist, etc.
- **Color palette** recommendations based on your energy

### 3. Personalized Beauty Recommendations
- **Web scraping** from beauty retailers (Sephora, Ulta, etc.)
- **Category-specific picks**: makeup, skincare, haircare, clothing, hair color
- **Personalized reasoning** for each product
- **Direct shopping links** to purchase items

### 4. Profile & Session History
- **Current mood tracking**: "revenge era 💅", "healing era 💕", etc.
- **Past vent sessions** with full analysis
- **Saved beauty recommendations** organized by category
- **Glow journey stats** and progress tracking

## Tech Stack 💻

### Frontend (iOS)
- **SwiftUI** for modern UI
- **Speech framework** for voice recognition
- **AVFoundation** for audio recording
- **UserDefaults** for local data storage

### Backend (Python)
- **Flask** web framework
- **SQLAlchemy** for database management
- **OpenAI API** for text analysis and embeddings
- **BeautifulSoup** for web scraping
- **JWT** for authentication

### AI & ML
- **OpenAI GPT-3.5** for conversation analysis
- **OpenAI Embeddings** for vector storage
- **Semantic analysis** for mood detection
- **Product recommendation engine**

## Setup Instructions 🚀

### Prerequisites
- Xcode 14+ (for iOS development)
- Python 3.8+ (for backend)
- OpenAI API key
- iOS device or simulator

### Backend Setup

1. **Navigate to backend directory:**
   ```bash
   cd GlowGirl/Backend
   ```

2. **Create virtual environment:**
   ```bash
   python -m venv venv
   source venv/bin/activate  # On Windows: venv\Scripts\activate
   ```

3. **Install dependencies:**
   ```bash
   pip install -r requirements.txt
   ```

4. **Set up environment variables:**
   Create a `.env` file in the Backend directory:
   ```
   OPENAI_API_KEY=your_openai_api_key_here
   FLASK_SECRET_KEY=your_secret_key_here
   JWT_SECRET_KEY=your_jwt_secret_here
   ```

5. **Run the backend:**
   ```bash
   python app.py
   ```
   The server will start on `http://localhost:5001`

### iOS App Setup

1. **Open the project in Xcode:**
   ```bash
   open GlowGirl.xcodeproj
   ```

2. **Update API endpoints:**
   In `APIServices.swift`, ensure the backend URL matches your setup:
   ```swift
   private let baseURL = "http://localhost:5001"
   ```

3. **Add your OpenAI API key:**
   In `APIServices.swift`, replace the API key with your own.

4. **Build and run:**
   - Select your target device/simulator
   - Press Cmd+R to build and run

## How It Works 🔧

### 1. Vector Embedding Logic
```python
def create_embedding(text):
    response = openai.Embedding.create(
        input=text,
        model="text-embedding-ada-002"
    )
    return response['data'][0]['embedding']
```
- Converts user's vent text to high-dimensional vectors
- Stores in database with metadata (mood, vibe, date)
- Enables semantic search for similar past situations
- Improves recommendations over time based on patterns

### 2. Speech-to-Text Logic
```swift
private func startRecording() {
    let speechRecognizer = SFSpeechRecognizer(locale: Locale(identifier: "en-US"))
    let recognitionRequest = SFSpeechAudioBufferRecognitionRequest()
    
    // Configure audio input and start recognition
    recognitionTask = speechRecognizer.recognitionTask(with: recognitionRequest) { result, error in
        if let result = result {
            transcribedText = result.bestTranscription.formattedString
        }
    }
}
```
- Uses iOS Speech framework for real-time transcription
- Configures audio session for optimal recording
- Provides live feedback as user speaks
- Handles permissions and error states

### 3. Web Scraping Logic
```python
def scrape_beauty_products(mood, vibe, color_palette, style):
    search_terms = []
    
    if "heartbroken" in mood.lower() or "revenge" in vibe.lower():
        search_terms.extend(["red lipstick", "bold eyeliner", "black dress"])
    elif "excited" in mood.lower() or "new" in vibe.lower():
        search_terms.extend(["pink blush", "coral lipstick", "flowy dress"])
    
    # Filter products based on search terms
    # Return personalized recommendations with reasoning
```
- Analyzes mood and vibe to determine search terms
- Scrapes from beauty retailers (Sephora, Ulta, etc.)
- Filters products based on emotional context
- Provides personalized reasoning for each recommendation

## App Flow 📱

1. **Login/Signup** → User authentication with JWT tokens
2. **Dashboard** → Big sparkle button to start venting
3. **Voice Recording** → Real-time speech-to-text transcription
4. **AI Analysis** → OpenAI analyzes emotional state and vibe
5. **Beauty Recommendations** → Curated products with reasoning
6. **Profile** → Save sessions and track glow journey

## Key Features Explained 🎯

### Mood Detection
The AI analyzes your vent text to determine:
- **Emotional state**: heartbroken, excited, confused, empowered
- **Current situation**: relationship drama, friendship issues, work stress
- **Needed energy**: revenge glow, self-love, confidence boost, healing

### Product Matching
Based on your analysis, the app recommends:
- **Makeup**: Bold lipsticks for confidence, soft looks for healing
- **Skincare**: Self-care products for emotional wellness
- **Hair**: New colors for fresh starts, treatments for self-love
- **Clothing**: Power outfits for confidence, cozy items for comfort

### Reasoning System
Each product comes with personalized reasoning:
- "This red lipstick will make you feel like a total baddie when your ex sees you've moved on! 💄"
- "Perfect for your self-care era - this will give you that natural glow that says 'I'm thriving without you' ✨"

## Future Enhancements 🚀

- **Real web scraping** from actual beauty retailers
- **Social features** to share glow journeys with friends
- **AR try-on** for makeup and hair colors
- **Mood tracking** over time with charts and insights
- **Personalized beauty routines** based on mood patterns
- **Integration** with beauty subscription services

## Contributing 🤝

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test thoroughly
5. Submit a pull request

## License 📄

This project is licensed under the MIT License - see the LICENSE file for details.

---

**Built with 💕 for the Gen Z glow-up community! ✨** 