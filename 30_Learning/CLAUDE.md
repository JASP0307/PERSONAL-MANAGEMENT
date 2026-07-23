 # 30_Learning — Skill-Building

Courses, books, and skills in progress.

## Workflow
- `/learn <topic>` — start a new topic (decides standalone vs. track, sets goal + milestones).
- `/log-session [url]` — log a study session (dated Summary + Connections entry).
- `/practice [topic]` — active-recall quiz or hands-on exercise from the notes.
- `/learning-review` — progress + staleness review, continue/pause/drop, weekly focus.

Two formats, depending on scope:
- **Track folder** — ongoing, multi-session topics (a course, a book).
- **Standalone .md file** — a single topic/video that doesn't need its own
  folder yet.

## Track structure
Each multi-session track follows the standard project pattern:
- `CLAUDE.md` — purpose, status, source (course/book/topic)
- `NOTES.md` — one dated entry per session: Summary, Connections to other
  projects (see `00_System/AGENT.md`, "When I share learning notes")

## Standalone note structure
A single `<topic-name>.md` file with one dated entry per session: source URL,
Summary, Connections (same structure as track NOTES.md). If it grows into an
ongoing topic, it gets promoted to a track folder.

## Active tracks
- `rag-fundamentals/` — RAG concepts and techniques (retrieval strategies, embeddings, chunking, evaluation)

## Active standalone notes
- `python-fastapi.md` — FastAPI basics (routes, Pydantic models, auto docs)
