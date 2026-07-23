# Agent Operating Instructions

## When creating a new project
1. Ask which area it belongs to (10/20/30/40).
2. Create the folder with kebab-case naming.
3. Copy `templates/PROJECT_CLAUDE.md` into it and fill it in with me.
4. Add the project to the parent area's CLAUDE.md list.

## When updating tasks
- Add tasks to the closest relevant TASKS.md, never only to the dashboard.
- Always timestamp additions and completions.

## Learning workflow
The full lifecycle lives in four skills under `.claude/skills/` — they are the
single source of truth for the procedures; invoke the matching one instead of
improvising:
1. `/learn` — capture a new topic: standalone note vs. track folder (track
   CLAUDE.md from `templates/LEARNING_TRACK_CLAUDE.md`), goal + milestones,
   register in 30_Learning.
2. `/log-session` — when I share learning material (YouTube URL, article,
   notes): transcript via `scripts/yt_transcript.sh`, dated Summary +
   Connections entry, milestone tick, quick recall check.
3. `/practice` — active-recall quiz or hands-on exercise from a track's notes.
4. `/learning-review` — progress/staleness scan, continue/pause/drop
   decisions, weekly focus.

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
