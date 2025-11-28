#!/bin/bash

echo "🚀 Starting PDF Q&A System with ngrok..."
echo ""

# Check if ngrok is installed
if ! command -v ngrok &> /dev/null; then
    echo "❌ ngrok is not installed!"
    echo "📥 Install ngrok:"
    echo "   macOS: brew install ngrok/ngrok/ngrok"
    echo "   Or download from: https://ngrok.com/download"
    exit 1
fi

# Check if .env exists
if [ ! -f .env ]; then
    echo "⚠️  .env file not found!"
    echo "📝 Creating .env from env_example.txt..."
    cp env_example.txt .env
    echo "⚠️  Please edit .env and add your OPENAI_API_KEY"
    exit 1
fi

# Start Streamlit in background
echo "📚 Starting Streamlit app..."
streamlit run app.py --server.port=8501 --server.address=localhost &
STREAMLIT_PID=$!

# Wait for Streamlit to start
sleep 5

# Start ngrok
echo "🌐 Starting ngrok tunnel..."
ngrok http 8501

# Cleanup on exit
trap "kill $STREAMLIT_PID 2>/dev/null" EXIT

