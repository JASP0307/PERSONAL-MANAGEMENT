---
name: practice
description: Run an active-recall practice session (quiz or hands-on exercise) from a 30_Learning track's notes. Use when the user wants to practice, review, quiz themselves, or apply something they've been learning.
---

# /practice — active recall & application

Turn accumulated notes into retrieval practice. The argument names a track or
standalone note; if omitted, list the active items in `30_Learning/` and ask
which one (AskUserQuestion).

## Choose the mode

Offer both when the topic allows:

- **Quiz (default)** — active recall from notes.
- **Hands-on exercise** — for applicable topics (e.g. FastAPI, coding subjects),
  a small concrete exercise, ideally anchored to a real project in the vault
  (check `10_Work/` and `20_Projects/` for a natural fit). Scope it to one
  sitting; build it in the user's chosen location or the scratchpad.

## Quiz rules

1. Read the topic's notes (track `NOTES.md` or the standalone file).
2. Ask 3–6 questions, **one at a time, question first — never show the answer
   until the user has attempted it**. Recall beats re-reading; make them
   generate the answer.
3. Weight selection toward **older entries** and anything previously marked
   shaky (see the recall notes `/log-session` leaves) — lightweight spaced
   repetition, plain markdown only.
4. Mix question types: definitions, "when would you use X over Y",
   trace-through/apply questions. Avoid trivia that doesn't matter.
5. After each attempt, give the correct answer with a one-line pointer to the
   note entry it came from.

## Close out

Append one dated line to the notes file:
`**Practice (YYYY-MM-DD):** <what was solid> / shaky: <topics missed>` —
this feeds the next `/practice` and `/log-session`.

If something was very shaky, suggest a follow-up session on it (offer to add a
task to `30_Learning/TASKS.md`). Commit per `00_System/AGENT.md` if files changed.
