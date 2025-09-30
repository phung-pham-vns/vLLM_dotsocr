from openai import OpenAI
from dotenv import load_dotenv
import os

load_dotenv()

prompt = """Please output the layout information from the PDF image, including each layout element's bbox, its category, and the corresponding text content within the bbox.

1. Bbox format: [x1, y1, x2, y2]

2. Layout Categories: The possible categories are ['Caption', 'Footnote', 'Formula', 'List-item', 'Page-footer', 'Page-header', 'Picture', 'Section-header', 'Table', 'Text', 'Title'].

3. Text Extraction & Formatting Rules:
    - Picture: For the 'Picture' category, the text field should be omitted.
    - Formula: Format its text as LaTeX.
    - Table: Format its text as HTML.
    - All Others (Text, Title, etc.): Format their text as Markdown.

4. Constraints:
    - The output text must be the original text from the image, with no translation.
    - All layout elements must be sorted according to human reading order.

5. Final Output: The entire output must be a single JSON object."""


# Connect OpenAI client to your vLLM server
lvlm_url = os.getenv("LVLM_URL")
client = OpenAI(base_url=lvlm_url, api_key="empty")

response = client.chat.completions.create(
    model=None,
    messages=[
        {
            "role": "user",
            "content": [
                {"type": "text", "text": prompt},
                {
                    "type": "image_url",
                    "image_url": {
                        "url": "https://incodocs.com/blog/wp-content/uploads/2022/07/Bill-of-Lading-Template-Format-Document.png"
                    },
                },
            ],
        }
    ],
)

print(eval(response.choices[0].message.content))
