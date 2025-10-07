#!/bin/bash
set -e

echo "Starting vLLM server setup..."

# Download the model if needed (no re-download if already cached)
python3 - <<PY
import os
from huggingface_hub import snapshot_download

repo = os.environ.get("VLLM_MODEL", "rednote-hilab/dots.ocr")
cache_dir = os.environ.get("CACHE_DIR", "/root/.cache/huggingface")
token = os.environ.get("HUGGING_FACE_HUB_TOKEN")  # optional/private repos

print(f"Downloading model: {repo}")
print(f"Cache directory: {cache_dir}")
print(f"Token provided: {'Yes' if token else 'No'}")

snapshot_download(repo_id=repo, cache_dir=cache_dir, token=token)
print(f"Model ready in cache: {repo}")
PY

echo "Model download completed. Starting vLLM API server..."

# Launch vLLM API server
exec python3 -m vllm.entrypoints.openai.api_server \
  --model "$VLLM_MODEL" \
  --trust-remote-code \
  --host "$VLLM_HOST" \
  --port "$VLLM_PORT"