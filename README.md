# JSALT — Responsible AI and Evaluation (Part 1)

Hands-on labs covering predictive fairness, fighting-words analysis, and text representations.

Notebooks (in each folder below): `lab1_predictive_compas.ipynb`, `lab2_fighting_words.ipynb`, `lab3_representations.ipynb`.

## Pick a variant

Both folders have the **same three labs**. The only difference is *where the language model (LLM) runs* when a lab calls one.

| | [`colab/`](colab/) | [`local/`](local/) |
|---|---|---|
| **Runs on** | Google Colab (browser) | Your computer (e.g. VS Code) |
| **LLM runs on** | Groq's servers (over the internet) | Your machine (Ollama or vLLM) |
| **You need** | A free [Groq API key](https://console.groq.com/keys) | Setup + a decent computer |
| **Best for** | Getting started fast | Working offline / Groq backup |

- **`colab/`** — you send LLM calls to **Groq** via API; they run the model and send the answer back. Easiest: no install, just a free API key.
- **`local/`** — the model runs **on your own machine**, so it works offline. More setup; Groq is still tried first and the local model takes over if it's unavailable.

**New here? Start with [`colab/`](colab/).** Each folder has its own `README.md` with full setup instructions.

Open a notebook directly in Google Colab:

- **How to use the Groq API** — [![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/JHU-CSS/jsalt-tutorial-2026/blob/main/colab/how_to_use_groq_api.ipynb)
- **Lab 1 — Predictive fairness (COMPAS)** — [![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/JHU-CSS/jsalt-tutorial-2026/blob/main/colab/lab1_predictive_compas.ipynb)
- **Lab 2 — Fighting words** — [![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/JHU-CSS/jsalt-tutorial-2026/blob/main/colab/lab2_fighting_words.ipynb)
- **Lab 3 — Text representations** — [![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/JHU-CSS/jsalt-tutorial-2026/blob/main/colab/lab3_representations.ipynb)
