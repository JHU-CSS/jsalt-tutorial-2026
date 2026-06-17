# JSALT — Responsible AI and Evaluation (Part 1)

Notebooks: `lab1_predictive_compas.ipynb`, `lab2_fighting_words.ipynb`, `lab3_representations.ipynb`.

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
