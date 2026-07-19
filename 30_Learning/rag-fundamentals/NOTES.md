# NOTES — RAG Fundamentals

## 2026-07-18 — Top 3 RAG Retrieval Strategies: Sparse, Dense, & Hybrid Explained
**Source:** https://youtu.be/r0Dciuq0knU

**Summary:**
Three retrieval strategies for RAG, oldest to newest:
1. **Sparse (BM25/TF-IDF)** — keyword match, fast/cheap, no embeddings; best for
   exact terms (code, logs, legal). Weak on synonyms/context.
2. **Dense (embeddings + ANN)** — semantic similarity; best for natural-language
   queries over unstructured text. Weak on rare/jargon terms and short queries.
3. **Hybrid (dense + sparse + fusion)** — current SOTA; runs both in parallel,
   merges via weighted sum or RRF. Wins especially in jargon-heavy technical/legal/
   medical domains — best overall precision and recall.

**Connections:**
- [[agentic-rag-tool]] — directly relevant: that tool queries BMS project
  documentation, which is exactly the jargon-heavy technical domain the video
  says hybrid retrieval wins on (device tags, point names, error codes are exact
  terms a pure embedding search could miss). Worth checking whether its current
  retrieval is sparse/dense/hybrid, and whether adding a BM25 keyword layer
  alongside embeddings would improve recall on exact BMS terminology.
- No clear connection to [[ebo-xml-replicator]] or [[pigeon-invaders]].
