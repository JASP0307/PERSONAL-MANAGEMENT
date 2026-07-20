# Agent Operating Instructions

## When creating a new project
1. Ask which area it belongs to (10/20/30/40).
2. Create the folder with kebab-case naming.
3. Copy `templates/PROJECT_CLAUDE.md` into it and fill it in with me.
4. Add the project to the parent area's CLAUDE.md list.

## When updating tasks
- Add tasks to the closest relevant TASKS.md, never only to the dashboard.
- Always timestamp additions and completions.

## When I share learning notes
1. If I share a YouTube URL, run `00_System/scripts/yt_transcript.sh <url>` to fetch
   its transcript and use that as the raw material. If the script reports no
   captions are available, tell me and ask whether to paste notes manually instead
   (don't attempt audio transcription — that's not set up).
2. If raw notes already exist in a track's NOTES.md (jotted by hand), work from
   those; otherwise take what I paste/describe in chat as the raw material.
3. Decide where it lives:
   - If the material belongs to an existing multi-session track (e.g.
     `rag-fundamentals/`), append to that track's NOTES.md.
   - If it's a standalone topic (typically a single video), create it as a
     single `30_Learning/<topic-name>.md` file — no folder, no CLAUDE.md. Ask
     which existing track it belongs to if unclear before defaulting to a
     standalone file.
4. Append a dated entry (standalone file or track NOTES.md) with two parts:
   Summary and Connections. Include the source URL. Don't include the raw
   transcript/notes — condense straight to the summary.
5. For Connections: scan active projects in 10_Work/, 20_Projects/, and other
   30_Learning tracks/files for genuine overlap with this session's material.
   Link each with `[[project-name]]` and a one-line reason. If nothing clearly
   connects, say "no clear connections yet" — don't force a link.
6. Never write into the connected project's own files — connections live only
   in the learning note itself.
7. If a standalone file grows into an ongoing multi-session topic, propose
   converting it into a full track folder (per "When creating a new project")
   before doing so.

## When I ask for a weekly review
1. Regenerate DASHBOARD.md.
2. Summarize: what moved, what's stale, what's next.
3. Suggest at most 3 priorities for the coming week.

## Git
This tree is a git repository. After a session's meaningful changes (new or
updated files, structural changes, workflow changes), create a commit so changes
are diffable and reviewable — don't wait to be asked. Skip commits for turns that
only answered a question or explored read-only. Write clear, specific commit
messages describing what changed and why, not generic ones like "update files".

## Boundaries
- Never delete files without explicit confirmation.
- Never restructure folders without proposing the change first.
