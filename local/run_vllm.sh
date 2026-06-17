#!/usr/bin/env bash
# Start a local OpenAI-compatible LLM server with vLLM — the backup the labs
# fall back to when Groq is unavailable.
#
# Requires:  pip install vllm   (best on Linux + an NVIDIA GPU; Apple Silicon
#            support is experimental/CPU-only and slow — see README).
#
# Override the model or port with env vars, e.g.:
#   LLM_MODEL="Qwen/Qwen2.5-7B-Instruct" VLLM_PORT=8001 ./run_vllm.sh
set -euo pipefail

MODEL="${LLM_MODEL:-Qwen/Qwen2.5-3B-Instruct}"
PORT="${VLLM_PORT:-8000}"

echo "Starting vLLM:  model=$MODEL  port=$PORT"
echo "OpenAI-compatible endpoint -> http://localhost:$PORT/v1"
echo "Point the notebooks at it with:  export LLM_BASE_URL=http://localhost:$PORT/v1"
echo

exec python -m vllm.entrypoints.openai.api_server \
    --model "$MODEL" \
    --port "$PORT"
