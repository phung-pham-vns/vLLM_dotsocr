### dots.ocr

A powerful multilingual OCR model from HiLab

- Single end-to-end parser for text, tables (HTML), formulas (LaTeX), and layouts (Markdown).
- Support 100 languages with robust performance on low-resources docs
- Compact 1.7B VLM, but achieves SOTA results on OmniDocBench & dots.ocr-bench
- Free for commercial use.

VLLM Image: `vllm/vllm-openai:nightly`

Docker Compose Run

```bash
docker compose up
```

Docker Run

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

