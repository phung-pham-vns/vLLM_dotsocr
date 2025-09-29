# Use a lightweight base image with Python and CUDA support
FROM nvidia/cuda:12.4.0-base-ubuntu22.04

# Install system dependencies
USER root
RUN apt-get update && \
    apt-get install -y curl python3-pip python3-dev git poppler-utils && \
    rm -rf /var/lib/apt/lists/*

# Set Python 3 as default
RUN ln -sf /usr/bin/python3 /usr/bin/python

# Install uv
RUN curl -LsSf https://astral.sh/uv/install.sh | sh

# Set PATH for uv
ENV PATH="/root/.local/bin:$PATH"

# Install vllm (with fallback to source build for ARM64 compatibility)
RUN uv pip install --system --extra-index-url https://wheels.vllm.ai/nightly vllm || \
    uv pip install --system --no-binary vllm vllm

# Set working directory
WORKDIR /app

# Copy pre-downloaded model weights
COPY weights /app/dots_ocr

# Expose vLLM port
EXPOSE 8000

# Run vLLM server with DotsOCR
CMD ["vllm", "serve", "/app/dots_ocr", "--trust-remote-code", "--port", "8000", "--host", "0.0.0.0"]
