FROM vllm/vllm-openai:nightly

# Install dependencies for pulling models from Hugging Face
RUN pip install --no-cache-dir huggingface-hub

# Ensure the app directory exists
RUN mkdir -p /app

# Startup script:
# 1) Ensure the model is present in the cache (snapshot_download is idempotent)
# 2) Start the vLLM OpenAI-compatible server
COPY <<'EOF' /app/start.sh
#!/usr/bin/env bash
set -euo pipefail

# Allow overrides via environment variables
VLLM_MODEL="${VLLM_MODEL:-rednote-hilab/dots.ocr}"
VLLM_HOST="${VLLM_HOST:-0.0.0.0}"
VLLM_PORT="${VLLM_PORT:-8000}"
CACHE_DIR="${CACHE_DIR:-/root/.cache/huggingface}"

# Download the model if needed (no re-download if already cached)
python3 - <<PY
import os
from huggingface_hub import snapshot_download

repo = os.environ.get("VLLM_MODEL", "rednote-hilab/dots.ocr")
cache_dir = os.environ.get("CACHE_DIR", "/root/.cache/huggingface")
token = os.environ.get("HUGGING_FACE_HUB_TOKEN")  # optional/private repos

snapshot_download(repo_id=repo, cache_dir=cache_dir, token=token)
print(f"Model ready in cache: {repo}")
PY

# Launch vLLM API server
exec python3 -m vllm.entrypoints.openai.api_server \
  --model "$VLLM_MODEL" \
  --trust-remote-code \
  --host "$VLLM_HOST" \
  --port "$VLLM_PORT"
EOF

RUN chmod +x /app/start.sh

EXPOSE 8000
CMD ["/app/start.sh"]
