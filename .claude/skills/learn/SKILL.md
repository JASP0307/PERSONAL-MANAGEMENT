---
name: learn
description: Capture a new learning interest and set it up in 30_Learning. Use when the user says they want to learn a topic, start studying something, or are interested in a new subject (e.g. "I want to learn Rust", "/learn docker").
---

# /learn — capture a new learning topic

Set up a new topic in `30_Learning/` so every interest follows the same path.
The topic comes from the arguments; if none given, ask what the topic is.

## Steps

1. **Check for an existing home.** Scan `30_Learning/` (tracks and standalone
   `.md` files). If the topic overlaps an existing track or note, propose adding
   to it instead of creating something new, and stop here if the user agrees.

2. **Decide scope** — ask via AskUserQuestion (the user prefers question
   windows over plain text):
   - **Standalone note** — a one-off video/article, no ongoing plan. Create
     `30_Learning/<topic-name>.md` (kebab-case). Structure: `# Title` heading
     only; dated entries get appended later by `/log-session`.
   - **Track folder** — a multi-session topic (course, book, deep subject).
     Create `30_Learning/<topic-name>/` with `CLAUDE.md` copied from
     `00_System/templates/LEARNING_TRACK_CLAUDE.md` and an empty
     `NOTES.md` (`# Notes — <Topic>` heading).

3. **For a track, fill in the Plan with the user.** Ask for (or propose, then
   confirm):
   - **Goal** — one sentence: "done means …" (concrete, checkable).
   - **Milestones** — 3–6 checkboxes covering the arc from basics to the goal.
     Prefer milestones that end in something applied (a small build, a
     practice run), not just "watch X".
   - **Sources** — course/book/playlist URLs if known.
   - **Next session** — the first concrete sitting (e.g. "watch intro video,
     log it with /log-session").

4. **Register it:**
   - Add the track/note to the appropriate list in `30_Learning/CLAUDE.md`
     (Active tracks / Active standalone notes) with a one-line description.
   - Add a kickoff task to `30_Learning/TASKS.md` Open section:
     `- [ ] <Topic>: <first session> (added: YYYY-MM-DD)`.

5. **Connections preview.** Briefly scan active projects in `10_Work/` and
   `20_Projects/` for genuine overlap with the topic; if any, mention them to
   the user as motivation/anchor (don't write into those projects' files).

6. Commit per the git convention in `00_System/AGENT.md`.
