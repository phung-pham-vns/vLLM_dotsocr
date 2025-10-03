FROM vllm/vllm-openai:nightly

# Install huggingface-hub for model downloading
RUN pip install huggingface-hub

# Create a startup script that downloads model only if not cached
RUN echo '#!/bin/bash\n\
VLLM_MODEL="rednote-hilab/dots.ocr"\n\
CACHE_DIR="/root/.cache/huggingface"\n\
MODEL_PATH="$CACHE_DIR/models--$VLLM_MODEL"\n\
\n\
# Check if model is already cached\n\
if [ ! -d "$MODEL_PATH" ]; then\n\
    echo "Model not found in cache. Downloading..."\n\
    python3 -c "from huggingface_hub import snapshot_download; import os; snapshot_download(\"$MODEL_NAME\", cache_dir=\"$CACHE_DIR\", token=os.getenv(\"HUGGING_FACE_HUB_TOKEN\"))"\n\
    echo "Model download completed."\n\
else\n\
    echo "Model found in cache. Skipping download."\n\
fi\n\
\n\
# Start vLLM server on port 8000 (matches EXPOSE)\n\
exec python3 -m vllm.entrypoints.openai.api_server --model "$VLLM_MODEL" --trust-remote-code --host "0.0.0.0" --port "8000"\n\
' > /app/start.sh && chmod +x /app/start.sh

EXPOSE 8000

CMD ["/app/start.sh"]