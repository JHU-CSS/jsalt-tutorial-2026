# Lab Summaries — Responsible AI and Evaluation (Part 1)

Three hands-on labs, each measuring the *same* gender/group stereotype a different way: as prediction harm, as surface language, and as representation geometry.

## Lab 1 — Auditing a Predictive System (COMPAS)

**File:** `lab1_predictive_compas.ipynb` · **Tools:** pandas, scikit-learn, fairlearn

Audits COMPAS, the recidivism risk tool, on ProPublica's public Broward County dataset. You:

- Reproduce ProPublica's finding that **error rates differ by race** (Black defendants get far higher false-positive rates).
- Show COMPAS is nonetheless **calibrated** — a score means the same thing across groups.
- Hit the **impossibility result** (Chouldechova; Kleinberg et al.): when base rates differ, you can't have calibration *and* equal error rates at once.
- See **"fairness through unawareness" fail** — a model never given race still discriminates via proxy features.
- Trace the **accuracy–fairness tradeoff** using fairlearn's `ThresholdOptimizer`.

**Takeaway:** Both sides of the COMPAS debate were "right" — they measured different fairness criteria that can't be satisfied simultaneously.

## Lab 2 — Fighting Words

**File:** `lab2_fighting_words.ipynb` · **Tools:** nltk, datasets, groq

Implements **Fighting Words** (Monroe, Colaresi & Quinn 2008) — a log-odds-ratio method with an informative Dirichlet prior and z-score significance test that finds the words most distinctive of two corpora, with no hand-picked wordlist.

- **Phase 1:** Run it on the *Bias in Bios* corpus (falls back to NLTK movie reviews) and rediscover the agentic-vs-communal split in how men's and women's biographies are written. Also separates **description bias** (trait words) from **occupational segregation** (field words).
- **Phase 2:** Generate your own corpus from an LLM (via Groq) — references that differ *only* by a gendered first name — and test whether the model reproduces the same stereotype.

**Takeaway:** The method discovers which words matter on its own; with the job held fixed in Phase 2, any gendered gap is the model describing identical people differently.

## Lab 3 — Representations

**File:** `lab3_representations.ipynb` · **Tools:** gensim, nltk

Opens up word-embedding geometry (GloVe, with a Word2Vec fallback) and measures bias three ways:

- **Analogies** — *king − man + woman ≈ queen* works, but so do the stereotyped ones (Bolukbasi et al.).
- **Gender subspace** (Bolukbasi et al. 2016) — extract a single female→male direction and project professions onto it; care roles land female, technical/authority roles land male.
- **WEAT** (Caliskan et al. 2017) — the Implicit Association Test ported to embeddings, with a Cohen's *d* effect size (~1.8) and permutation-test p-value.

**Takeaway:** Embeddings inherit human stereotypes at scale — the same associations human IATs find, reproduced by a model that only ever saw text.

---

**The thread:** All three labs triangulate one stereotype — prediction harm (Lab 1), surface language (Lab 2), and representation geometry (Lab 3) — showing it is inherited from human data, not invented by the algorithm.
