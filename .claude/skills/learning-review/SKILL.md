---
name: learning-review
description: Review all 30_Learning tracks and notes — progress, staleness, close-outs, next-week focus. Use when the user asks for a learning review, learning status, or wants to decide what to continue or drop.
---

# /learning-review — periodic review & close-out

Give the user a clear picture of their learning pipeline and force the
continue/pause/drop decisions that keep it honest.

## Scan

For every track folder and standalone `.md` in `30_Learning/`:

- Last dated entry (from NOTES.md or the file itself) and days since.
- Track milestones: done vs. open (from the CLAUDE.md Plan section).
- Practice lines: when the topic was last practiced, what was shaky.
- Open tasks in `30_Learning/TASKS.md` touching the topic.

Present it as a short plain-markdown table (topic, last session, progress,
status). Flag anything **stale: untouched > 2 weeks** — same threshold as the
dashboard.

## Decide

For each stale or apparently finished item, ask (AskUserQuestion — the user
prefers question windows):

- **Continue** — agree on the next concrete session and add it to
  `30_Learning/TASKS.md` with `(added: date)`.
- **Done / paused** — move it to `90_Archive/`, note the date and final status
  in its CLAUDE.md (or file header), and remove it from `30_Learning/CLAUDE.md`'s
  active lists. Never delete files; archiving only, per `00_System/AGENT.md`.
- **Drop** — same as paused but say so honestly in the archive note.

## Recommend

End with at most **1–2 focus topics for the coming week**, with a one-line
reason each (momentum, work relevance, staleness risk). Don't list everything —
recommend.

Commit per the git convention in `00_System/AGENT.md` if files changed.
