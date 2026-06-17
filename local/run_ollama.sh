#!/usr/bin/env bash
# Start a local Ollama server — the cross-platform backup (macOS / Linux / Windows,
# CPU is fine) the labs fall back to when Groq is unavailable. Ollama speaks the
# OpenAI API, so the notebooks use it exactly like vLLM; just point them at it
# by adding these lines to your .env file (note the : in the model name):
#   LLM_BASE_URL=http://localhost:11434/v1
#   LLM_MODEL=qwen2.5:3b
#
# Install:
#   macOS    brew install ollama        (or app at https://ollama.com/download)
#   Linux    curl -fsSL https://ollama.com/install.sh | sh
#   Windows  installer at https://ollama.com/download
#
# Override the model with:  LLM_MODEL="qwen2.5:7b" ./run_ollama.sh
set -euo pipefail

MODEL="${LLM_MODEL:-qwen2.5:3b}"
URL="http://localhost:11434"

if ! command -v ollama >/dev/null 2>&1; then
  echo "ollama not found — install it from https://ollama.com/download" >&2
  exit 1
fi

print_ready() {
  echo
  echo "Ollama ready -> $URL"
  echo "OpenAI-compatible endpoint -> $URL/v1   (model: $MODEL)"
  echo "Point the notebooks at it — copy the example and add these to your .env:"
  echo "  cp .env.example .env"
  echo "  LLM_BASE_URL=$URL/v1"
  echo "  LLM_MODEL=$MODEL"
}

# If a server is already running (macOS/Windows app, or Linux systemd service),
# just make sure the model is present and we're done.
if curl -sf "$URL/api/tags" >/dev/null 2>&1; then
  echo "Ollama server already running; pulling model: $MODEL"
  ollama pull "$MODEL"
  print_ready
  exit 0
fi

# Otherwise start the server ourselves, wait for it, pull the model, and keep it up.
echo "Starting Ollama server..."
ollama serve &
SERVER_PID=$!
for _ in $(seq 1 30); do
  curl -sf "$URL/api/tags" >/dev/null 2>&1 && break
  sleep 1
done

echo "Pulling model: $MODEL"
ollama pull "$MODEL"
print_ready
echo "(Ctrl-C to stop the server.)"
wait "$SERVER_PID"
