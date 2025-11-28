# Local + ngrok Deployment Guide

## Quick Start (Fastest Method)

### Step 1: Install ngrok

**macOS:**
```bash
brew install ngrok/ngrok/ngrok
```

**Or download:**
- Visit https://ngrok.com/download
- Sign up for free account
- Download and install

**After installation, authenticate:**
```bash
ngrok config add-authtoken YOUR_AUTH_TOKEN
```
(Get your auth token from https://dashboard.ngrok.com/get-started/your-authtoken)

### Step 2: Configure Environment

```bash
# Copy environment file
cp env_example.txt .env

# Edit .env and add your OpenAI API key
# OPENAI_API_KEY=your_key_here
```

### Step 3: Install Dependencies

```bash
pip install -r requirements.txt
```

### Step 4: Run Application

**Option A: Using the script (Recommended)**
```bash
chmod +x start_ngrok.sh
./start_ngrok.sh
```

**Option B: Manual (Two terminals)**

Terminal 1 - Start Streamlit:
```bash
streamlit run app.py --server.port=8501 --server.address=localhost
```

Terminal 2 - Start ngrok:
```bash
ngrok http 8501
```

### Step 5: Get Public URL

After running ngrok, you'll see output like:
```
Forwarding  https://abc123.ngrok-free.app -> http://localhost:8501
```

Copy the `https://` URL and share it with your teacher!

## Advantages

✅ **Fastest setup** - 5 minutes
✅ **No deployment wait** - Instant
✅ **Full control** - Local environment
✅ **Free** - ngrok free tier sufficient
✅ **No size limits** - All PDFs work

## Disadvantages

⚠️ **Requires local machine** - Must keep computer running
⚠️ **Temporary URL** - Changes each time (unless paid)
⚠️ **Free tier limits** - Connection timeouts, limited connections
⚠️ **Not permanent** - Only works while running

## Troubleshooting

### ngrok not found
```bash
# Install via Homebrew (macOS)
brew install ngrok/ngrok/ngrok

# Or download from ngrok.com
```

### Port already in use
```bash
# Use different port
streamlit run app.py --server.port=8502
ngrok http 8502
```

### ngrok connection timeout
- Free tier has connection limits
- Restart ngrok if needed
- Consider upgrading for stable connection

### Streamlit not starting
- Check if port 8501 is available
- Ensure all dependencies installed
- Check .env file exists

## For Demo Presentation

1. **Before demo:**
   - Start application locally
   - Start ngrok
   - Test the public URL works
   - Keep both terminals running

2. **During demo:**
   - Share the ngrok URL
   - If connection drops, restart ngrok
   - Have backup: screenshots or video

3. **After demo:**
   - Stop ngrok (Ctrl+C)
   - Stop Streamlit (Ctrl+C)

## Alternative: Keep ngrok Running

If you need a stable URL for longer:

1. **ngrok paid plan** ($8/month) - Static domain
2. **Use ngrok config file** - More stable connections
3. **Schedule restart** - Auto-restart if connection drops

## Quick Commands Reference

```bash
# Start Streamlit
streamlit run app.py

# Start ngrok (in another terminal)
ngrok http 8501

# Check ngrok status
ngrok api tunnels list

# View ngrok web interface
# Open http://localhost:4040 in browser
```

