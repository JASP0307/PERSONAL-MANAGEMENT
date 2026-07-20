# Python FastAPI

## 2026-07-20 — Python FastAPI Tutorial: Build a REST API in 15 Minutes
**Source:** https://youtu.be/iWS9ogMPOI0

**Summary:**
Beginner walkthrough of FastAPI fundamentals:
- **Setup** — install `fastapi` + `uvicorn`; run with `uvicorn main:app --reload`.
- **Routes** — `@app.get`/`@app.post` decorators define paths; path params
  (`/items/{item_id}`) and query params (with type hints, e.g. `limit: int`)
  are auto-parsed and type-converted.
- **Error handling** — raise `HTTPException(status_code=404, detail=...)`
  instead of letting unhandled errors surface as generic 500s.
- **Pydantic models** — define request/response shapes via `BaseModel`
  subclasses; FastAPI validates incoming JSON against them automatically
  (required vs. optional fields, type coercion) and can also validate/shape
  the response body (`response_model=`).
- **Auto docs** — `/docs` (Swagger UI) and `/redoc` are generated for free
  from the route + model definitions, plus a raw OpenAPI JSON schema export.
- **vs. Flask/Django** — async by default (better concurrency out of the
  box), less boilerplate for validation/docs; Flask has wider adoption/more
  resources, Django is heavier-weight than needed for a lightweight API.
- Suggested next steps from the video: DB integration (SQL), auth (JWT),
  deployment (AWS).

**Connections:**
- [[agentic-rag-tool]] — possible fit: that tool is "built and functional,
  but not yet rolled out" for querying BMS docs at Transfertec. If rollout
  means exposing it over HTTP (e.g. for a front-end or other internal tools
  to call), FastAPI's auto-validation and auto-docs would fit a lightweight
  internal API well. Worth checking what interface that tool currently uses
  before assuming this applies.
- No clear connection to [[ebo-xml-replicator]] (HTML/JS tool, no backend API)
  or [[rag-fundamentals]] (retrieval concepts, not web framework mechanics).
