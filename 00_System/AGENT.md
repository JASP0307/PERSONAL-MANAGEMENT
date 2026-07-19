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
3. If the track folder doesn't exist yet, ask which existing track it belongs to,
   or offer to create a new one (see "When creating a new project").
4. Append a dated entry to the track's NOTES.md with three parts: Raw, Summary,
   and Connections.
5. For Connections: scan active projects in 10_Work/, 20_Projects/, and other
   30_Learning tracks for genuine overlap with this session's material. Link each
   with `[[project-name]]` and a one-line reason. If nothing clearly connects, say
   "no clear connections yet" — don't force a link.
6. Never write into the connected project's own files — connections live only in
   the learning track's notes.

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
