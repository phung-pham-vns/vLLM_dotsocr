#!/bin/bash
set -e

echo "Starting MinerU vLLM server setup..."

# Download the model if needed (no re-download if already cached)
python3 - <<PY
import os
from huggingface_hub import snapshot_download

repo = os.environ.get("VLLM_MODEL", "opendatalab/MinerU2.5-2509-1.2B")
cache_dir = os.environ.get("CACHE_DIR", "/root/.cache/huggingface")
token = os.environ.get("HUGGING_FACE_HUB_TOKEN")  # optional/private repos

print(f"Downloading MinerU model: {repo}")
print(f"Cache directory: {cache_dir}")
print(f"Token provided: {'Yes' if token else 'No'}")

snapshot_download(repo_id=repo, cache_dir=cache_dir, token=token)
print(f"MinerU model ready in cache: {repo}")
PY

echo "MinerU model download completed. Starting vLLM API server..."

# Launch vLLM API server using the official vllm serve command
exec vllm serve "$VLLM_MODEL" \
  --host "$VLLM_HOST" \
  --port "$VLLM_PORT"