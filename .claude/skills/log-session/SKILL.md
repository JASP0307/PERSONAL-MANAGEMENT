---
name: log-session
description: Log a study session into 30_Learning as a dated Summary + Connections entry. Use when the user shares learning material — a YouTube URL, article, course session, or pasted notes — or says they watched/read/studied something.
---

# /log-session — record a study session

Append a dated entry for material the user just studied. The argument is a URL
or a topic/track name; raw notes may also be pasted in chat.

## Gather the raw material

1. If given a YouTube URL, run `00_System/scripts/yt_transcript.sh <url>` and
   use the transcript as raw material. If it reports no captions, tell the user
   and ask whether to paste notes manually instead (don't attempt audio
   transcription — that's not set up).
2. If raw notes were already jotted by hand into a track's NOTES.md, work from
   those; otherwise use what the user pastes/describes in chat.

## Decide where it lives

- If the material belongs to an existing track (folder in `30_Learning/`),
  append to that track's `NOTES.md`.
- If it's a standalone topic (typically a single video), create/append
  `30_Learning/<topic-name>.md` — no folder, no CLAUDE.md. If unclear which
  existing track it belongs to, ask before defaulting to a standalone file.
- If nothing exists for the topic yet and it sounds multi-session, suggest
  running `/learn` first (or do its setup inline with the user's OK).

## Write the entry

Append a dated entry (`## YYYY-MM-DD — <Session title>`) with:

- **Source:** the URL (when there is one).
- **Summary:** condensed key points — never the raw transcript/notes.
- **Connections:** scan active projects in `10_Work/`, `20_Projects/`, and
  other `30_Learning/` tracks/files for genuine overlap with this session's
  material. Link each with `[[project-name]]` and a one-line reason. If nothing
  clearly connects, write "no clear connections yet" — don't force a link.
  Never write into the connected project's own files — connections live only
  in the learning note itself.

## After the entry

1. **Milestones:** if the track's CLAUDE.md Plan has a milestone this session
   completes, tick it and update **Next session**.
2. **Active recall:** ask the user 1–3 short recall questions about the
   material (one AskUserQuestion round or plain questions, answers hidden until
   they try). Note in one line at the end of the entry anything they found
   shaky, so `/practice` can target it.
3. **Promotion:** if a standalone file just got its 3rd dated entry, propose
   converting it into a track folder (per `/learn`'s track setup) before doing so.
4. Update `30_Learning/TASKS.md` if this session completes an open task
   (move to Done with date).
5. Commit per the git convention in `00_System/AGENT.md`.
