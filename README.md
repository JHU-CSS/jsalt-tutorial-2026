# JSALT — Responsible AI and Evaluation (Part 1)

Three hands-on labs:

- **Lab 1** — Predictive fairness (COMPAS recidivism dataset)
- **Lab 2** — Fighting words analysis
- **Lab 3** — Text representations and embedding bias

## Quick start — open in Colab

Click a badge to open the notebook directly in Google Colab. Start with the Groq API intro if it's your first time.

| | |
|---|---|
| **Groq API intro** | [![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/JHU-CSS/jsalt-tutorial-2026/blob/main/colab/how_to_use_groq_api.ipynb) |
| **Lab 1 — Predictive fairness (COMPAS)** | [![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/JHU-CSS/jsalt-tutorial-2026/blob/main/colab/lab1_predictive_compas.ipynb) |
| **Lab 2 — Fighting words** | [![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/JHU-CSS/jsalt-tutorial-2026/blob/main/colab/lab2_fighting_words.ipynb) |
| **Lab 3 — Text representations** | [![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/JHU-CSS/jsalt-tutorial-2026/blob/main/colab/lab3_representations.ipynb) |

You'll need a free [Groq API key](https://console.groq.com/keys) — see [`colab/README.md`](colab/README.md) for setup.

## Running locally (VS Code + self-hosted model)

If you prefer to run the notebooks locally with Ollama or vLLM as a model backend, see [`local/README.md`](local/README.md) for full setup instructions.

## About the two variants

Both folders contain the same three labs. The only difference is *where the language model (LLM) runs*.

| | [`colab/`](colab/) | [`local/`](local/) |
|---|---|---|
| **Runs on** | Google Colab (browser) | Your computer (e.g. VS Code) |
| **LLM runs on** | Groq's servers (over the internet) | Your machine (Ollama or vLLM) |
| **You need** | A free [Groq API key](https://console.groq.com/keys) | Setup + a decent computer |
| **Best for** | Getting started fast | Working offline / Groq backup |

- **`colab/`** — you send LLM calls to **Groq** via API; they run the model and send the answer back. Easiest: no install, just a free API key.
- **`local/`** — the model runs **on your own machine**, so it works offline. More setup; Groq is still tried first and the local model takes over if it's unavailable.
