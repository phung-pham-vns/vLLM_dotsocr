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

Run on Kaggle

```
!pip install vllm --extra-index-url https://wheels.vllm.ai/nightly
!vllm serve rednote-hilab/dots.ocr --trust-remote-code --port 8000 --host 0.0.0.0
!pip install pyngrok

from pyngrok import ngrok

# Start tunnel to expose port 8000
public_url = ngrok.connect(8000)
print("Public endpoint:", public_url)
```

```
import requests

url = "https://xxxx-xx-xx-xx-8000.ngrok-free.app/v1/completions"
headers = {"Content-Type": "application/json"}
data = {
    "model": "rednote-hilab/dots.ocr",
    "prompt": "Recognize text from this image:",
    "image": "https://your-image-url.jpg"
}

resp = requests.post(url, headers=headers, json=data)
print(resp.json())
```