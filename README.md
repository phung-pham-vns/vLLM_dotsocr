### dots.ocr

A powerful multilingual OCR model from HiLab

- Single end-to-end parser for text, tables (HTML), formulas (LaTeX), and layouts (Markdown).
- Support 100 languages with robust performance on low-resources docs
- Compact 1.7B VLM, but achieves SOTA results on OmniDocBench & dots.ocr-bench
- Free for commercial use.

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

(Alternative way) Docker Run

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

Test APIs

- Other options: https://docs.vllm.ai/en/stable/serving/openai_compatible_server.html

`--dtype "bfloat16"`: https://huggingface.co/rednote-hilab/dots.ocr/blob/main/config.json
`--max-model-len 32768`: https://huggingface.co/rednote-hilab/dots.ocr/blob/main/generation_config.json
`--block-size`: https://docs.vllm.ai/en/stable/configuration/engine_args.html#-block-size
`--gpu-memory-utilization`: https://docs.vllm.ai/en/stable/configuration/engine_args.html#-gpu-memory-utilization
`--kv-cache-dtype`: https://docs.vllm.ai/en/stable/configuration/engine_args.html#-kv-cache-dtype
`--limit-mm-per-prompt`: ...
...
