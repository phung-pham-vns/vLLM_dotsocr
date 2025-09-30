### dots.ocr

A powerful multilingual OCR model from HiLab

- Single end-to-end parser for text, tables (HTML), formulas (LaTeX), and layouts (Markdown).
- Support 100 languages with robust performance on low-resources docs
- Compact 1.7B VLM, but achieves SOTA results on OmniDocBench & dots.ocr-bench
- Free for commercial use.

## Usage

### 1. Run with docker compose

VLLM Image: `vllm/vllm-openai:nightly`

Docker Compose Run

```bash
HF_TOKEN=<hugging-face-token> docker compose up -d
```

Logs

```bash
docker compose logs -f
```

Docker Compose Shutdown

```bash
docker compose down
```

### 2. Docker

```
docker run -d \
  --gpus all \
  --ipc=host \
  --name dots-ocr-vllm \
  -p 8000:8000 \
  -v ~/.cache/huggingface:/root/.cache/huggingface \
  -e HUGGING_FACE_HUB_TOKEN=<hugging-face-token> \
  vllm/vllm-openai:nightly \
  --model rednote-hilab/dots.ocr \
  --trust-remote-code
```

### 3. Run on GreenNode

Script

```
HUGGING_FACE_HUB_TOKEN=<your-hugging-face-token> \
python3 -m vllm.entrypoints.openai.api_server \
  --model rednote-hilab/dots.ocr \
  --trust-remote-code \
  --host 0.0.0.0 \
  --port 8000
```

Port mapping

```bash
ssh -L 8000:127.0.0.1:8000 -p 56891 root@103.73.232.228
```


## Test APIs

- Other options: https://docs.vllm.ai/en/stable/serving/openai_compatible_server.html

  - `--dtype "bfloat16"`: https://huggingface.co/rednote-hilab/dots.ocr/blob/main/config.json
  - `--max-model-len 32768`: https://huggingface.co/rednote-hilab/dots.ocr/blob/main/generation_config.json
  - `--block-size`: https://docs.vllm.ai/en/stable/configuration/engine_args.html#-block-size
  - `--gpu-memory-utilization`: https://docs.vllm.ai/en/stable/configuration/engine_args.html#-gpu-memory-utilization
  - `--kv-cache-dtype`: https://docs.vllm.ai/en/stable/configuration/engine_args.html#-kv-cache-dtype
  - `--limit-mm-per-prompt`: ...
...
