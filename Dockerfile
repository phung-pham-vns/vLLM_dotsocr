FROM vllm/vllm-openai:nightly

# Install huggingface-hub for downloading models
RUN pip install huggingface-hub

# Set default environment variables
ENV VLLM_HOST=0.0.0.0 \
    VLLM_PORT=8000

# Create download script
RUN echo 'from huggingface_hub import snapshot_download\n\
import os\n\
print("Downloading rednote-hilab/dots.ocr from Hugging Face...")\n\
snapshot_download(\n\
    repo_id="rednote-hilab/dots.ocr",\n\
    cache_dir="/root/.cache/huggingface",\n\
    token=os.environ.get("HUGGING_FACE_HUB_TOKEN")\n\
)\n\
print("Model download completed!")' > /tmp/download_model.py

# Download the model (will use HF_TOKEN from build args if provided)
ARG HUGGING_FACE_HUB_TOKEN
ENV HUGGING_FACE_HUB_TOKEN=${HUGGING_FACE_HUB_TOKEN}
RUN python3 /tmp/download_model.py && rm /tmp/download_model.py

EXPOSE 8000

# Use the working approach from README - OpenAI API server
CMD python3 -m vllm.entrypoints.openai.api_server \
    --model rednote-hilab/dots.ocr \
    --trust-remote-code \
    --host ${VLLM_HOST} \
    --port ${VLLM_PORT}