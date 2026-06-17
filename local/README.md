# JSALT — Responsible AI and Evaluation (Part 1) — local LLM backup variant

Notebooks: `how_to_use_groq_api.ipynb` (intro to the Groq API), `lab1_predictive_compas.ipynb`,
`lab2_fighting_words.ipynb`, `lab3_representations.ipynb`.

> This copy of the labs uses **Groq as the primary LLM and a self-hosted local LLM as a backup**:
> if a Groq call fails (or no key is set), the notebooks automatically fall back to a local server
> (Ollama or vLLM). See [Local backup server](#local-backup-server) below.

## Create the environment

**Use Python 3.11.** This stack pins `numpy<2` / `gensim` / `scipy<1.14`, which have no
prebuilt wheels for Python 3.13 — on 3.13 pip tries to compile scipy from source and fails.
Pick one option:

**Option 1 — conda** (pins Python 3.11 for you):

```bash
conda env create -f environment.yml -p ./.venv
conda activate ./.venv
```

**Option 2 — uv** (downloads Python 3.11 for you, no conda needed):

```bash
uv venv .venv --python 3.11
source .venv/bin/activate
uv pip install -r requirements.txt
```

## Choose the kernel

Register it once:

```bash
python -m ipykernel install --user --name jsalt-responsible-ai --display-name "Python (JSALT)"
```

Then in the notebook select the **Python (JSALT)** kernel (VS Code: kernel picker top-right → Select Another Kernel → Jupyter Kernel; JupyterLab: Kernel → Change Kernel).

> VS Code not showing it? Reload the window (`Cmd+Shift+P` → Developer: Reload Window) so it rescans kernels.

## Groq API key

`lab2` (and the optional LLM exercise in `lab3`) call the Groq API. Two steps: **(1)** get a key,
then **(2)** make it available to the notebook.

### Step 1 — Get a key

1. Go to [console.groq.com/keys](https://console.groq.com/keys) and sign in.
2. Click **Create API Key**, give it a name, and copy the value (starts with `gsk_`).
3. Copy it now — Groq only shows the key once.

### Step 2 — Give it to the notebook

**Local — `.env` file:** copy the example and paste your key into it:

```bash
cp .env.example .env
# open .env and replace gsk_your_key_here with your real key
```

The lab2 notebook calls `load_dotenv()`, so it reads `.env` automatically (VS Code,
JupyterLab, or terminal) — just run the cell after saving the file.

**Google Colab — Secrets:**

1. Click the 🔑 **key icon** in the left sidebar.
2. **Add new secret** → Name = `GROQ_API_KEY`, Value = your key.
3. Toggle **Notebook access** on.

The notebook reads it automatically — no `.env` needed on Colab.

> Never commit your real `.env` — only `.env.example`. If a key ever lands in a notebook or
> git history, rotate it at the link in Step 1.

## Local backup server

The labs call `chat()`, which tries **Groq first** and falls back to a **local LLM server** if
Groq errors out or no key is set. Two options below — both expose an OpenAI-compatible API, so the
notebooks talk to either one with the `openai` client (already in the env) and the same env vars:

- **Ollama** (`run_ollama.sh`) — works on **macOS / Linux / Windows**, no GPU required. Easiest, and the only option on a Mac.
- **vLLM** (`run_vllm.sh`) — high-throughput, but realistically **Linux + NVIDIA GPU** only.

### Option A — Ollama (recommended; cross-platform, no GPU)

**1. Install Ollama:**

```bash
# macOS
brew install ollama            # or the app at https://ollama.com/download
# Linux
curl -fsSL https://ollama.com/install.sh | sh
# Windows: installer at https://ollama.com/download
```

**2. Start it** (downloads the model on first run, then serves):

```bash
./run_ollama.sh
# or pick a model:  LLM_MODEL="qwen2.5:7b" ./run_ollama.sh
```

It serves an OpenAI-compatible endpoint at `http://localhost:11434/v1`.

**3. Point the notebooks at it** — set these in `.env` (note port 11434 and the `:` in the model name):

```bash
LLM_BASE_URL=http://localhost:11434/v1
LLM_MODEL=qwen2.5:3b
```

### Option B — vLLM (Linux + GPU)

vLLM exposes an OpenAI-compatible API, so the notebooks talk to it with the `openai` client (already in the env).

**1. Install vLLM** on the machine that will host the model (separate from the lab env — it's
heavy and platform-specific). A **Linux box with an NVIDIA GPU is strongly recommended**; macOS /
Apple Silicon support is experimental and CPU-only (slow):

```bash
pip install vllm
```

**2. Start the server:**

```bash
./run_vllm.sh
# or pick a model/port:
#   LLM_MODEL="Qwen/Qwen2.5-7B-Instruct" VLLM_PORT=8001 ./run_vllm.sh
```

It serves an OpenAI-compatible endpoint at `http://localhost:8000/v1`.

**3. Point the notebooks at it.** Defaults already match `run_vllm.sh`
(`http://localhost:8000/v1`, model `Qwen/Qwen2.5-3B-Instruct`). To override, set them in `.env`:

```bash
LLM_BASE_URL=http://localhost:8000/v1
LLM_MODEL=Qwen/Qwen2.5-3B-Instruct
```

With either server running, the labs use Groq when it works and silently switch to the local
backup when it doesn't — and if you leave `GROQ_API_KEY` blank, they use the local server only.
