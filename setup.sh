#!/bin/bash

echo "✨ Welcome to GlowGirl Setup! ✨"
echo ""

# Check if Python is installed
if ! command -v python3 &> /dev/null; then
    echo "❌ Python 3 is not installed. Please install Python 3.8+ first."
    exit 1
fi

echo "✅ Python 3 found"

# Navigate to backend directory
cd GlowGirl/Backend

# Create virtual environment if it doesn't exist
if [ ! -d "venv" ]; then
    echo "📦 Creating virtual environment..."
    python3 -m venv venv
fi

# Activate virtual environment
echo "🔧 Activating virtual environment..."
source venv/bin/activate

# Install dependencies
echo "📚 Installing dependencies..."
pip install -r requirements.txt

# Check if .env file exists
if [ ! -f ".env" ]; then
    echo "⚠️  No .env file found. Creating template..."
    cat > .env << EOF
# Add your API keys here
OPENAI_API_KEY=your_openai_api_key_here
FLASK_SECRET_KEY=your_secret_key_here
JWT_SECRET_KEY=your_jwt_secret_here
EOF
    echo "📝 Please edit the .env file with your actual API keys"
fi

echo ""
echo "🎉 Setup complete! To start the backend server:"
echo "1. cd GlowGirl/Backend"
echo "2. source venv/bin/activate"
echo "3. python app.py"
echo ""
echo "The server will start on http://localhost:5001"
echo ""
echo "💕 Happy glowing! ✨" 