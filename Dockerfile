FROM vllm/vllm-openai:nightly

# Install dependencies for pulling models from Hugging Face
RUN pip install --no-cache-dir huggingface-hub

# Ensure the app directory exists
RUN mkdir -p /app

# Copy the startup script from the host
COPY startup.sh /app/start.sh

# Set environment variable defaults
ENV VLLM_MODEL="rednote-hilab/dots.ocr"
ENV VLLM_HOST="0.0.0.0"
ENV VLLM_PORT="8000"
ENV CACHE_DIR="/root/.cache/huggingface"

# Make the startup script executable
RUN chmod +x /app/start.sh

EXPOSE 8000
CMD ["/app/start.sh"]
