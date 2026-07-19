# NOTES — RAG Fundamentals

## 2026-07-18 — Top 3 RAG Retrieval Strategies: Sparse, Dense, & Hybrid Explained
**Source:** https://youtu.be/r0Dciuq0knU

**Raw:**
Transcript (auto-captions, cleaned): ranks three retrieval strategies for RAG.
Sparse retrieval (~50 years old) relies on keyword search — methods like TF and
BM25 that count query-term frequency in documents. Simple, fast, scalable, no
embeddings needed; doesn't handle synonyms/context well, but can outperform deep
learning models on domain-specific terms. Best for exact wording: short queries,
code search, logs, legal clauses. Examples: Elasticsearch, Apache Lucene, Milvus
(BM25 support).

Dense retrieval (~5-10 years old) maps queries and documents into high-dimensional
vector space via an embedding model (e.g. sentence transformers); results are
ranked by semantic similarity (ANN/kNN) rather than exact match. Shines for
natural-language queries — chatbots, customer service, unstructured knowledge
search where phrasing varies. Weak on rare/jargon-heavy terms and short queries.
Examples: FAISS (Meta), JVector.

Hybrid retrieval (~2-3 years old, current state of the art) runs dense and sparse
in parallel and merges results with a fusion algorithm — either a weighted sum
(e.g. 70% dense / 30% sparse) or Reciprocal Rank Fusion (RRF, which merges by rank
position rather than raw score). Benchmarks show it consistently beats dense-only
on precision and recall, especially in domains with specialized jargon (legal,
medical, technical). Supported by Elasticsearch, Weaviate, DataStax Astra. Called
the default choice for serious RAG deployments today.

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
