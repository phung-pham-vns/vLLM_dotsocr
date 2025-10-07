FROM vllm/vllm-openai:nightly

# Install dependencies for pulling models from Hugging Face
RUN pip install --no-cache-dir huggingface-hub

# Set environment variable defaults
ENV VLLM_MODEL="rednote-hilab/dots.ocr"
ENV VLLM_HOST="0.0.0.0"
ENV VLLM_PORT=8000
ENV CACHE_DIR="/root/.cache/huggingface"

# Download models
RUN python3 -c "from huggingface_hub import snapshot_download; import os; snapshot_download(repo_id=os.environ.get('VLLM_MODEL', 'rednote-hilab/dots.ocr'), cache_dir=os.environ.get('CACHE_DIR', '/root/.cache/huggingface'))"

EXPOSE 8000

# Launch vLLM API server
# CMD ["python3", "-m", "vllm.entrypoints.openai.api_server", "--model", "$VLLM_MODEL", "--trust-remote-code", "--host", "$VLLM_HOST", "--port", "$VLLM_PORT"]
ENTRYPOINT []

CMD python3 -m vllm.entrypoints.openai.api_server \
  --model "$VLLM_MODEL" \
  --trust-remote-code \
  --host "$VLLM_HOST" \
  --port "$VLLM_PORT"