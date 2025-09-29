# dots.ocr

A powerful multilingual OCR model from HiLab

- Single end-to-end parser for text, tables (HTML), formulas (LaTeX), and layouts (Markdown).
- Support 100 languages with robust performance on low-resources docs
- Compact 1.7B VLM, but achieves SOTA results on OmniDocBench & dots.ocr-bench
- Free for commercial use.


Build locally

```bash
docker build -t phungpx/dotsocr-gpu-cuda-12-dot-4:latest .
```

Push to registry

```bash
docker push phungpx/dotsocr-gpu-cuda-12-dot-4:latest
```
