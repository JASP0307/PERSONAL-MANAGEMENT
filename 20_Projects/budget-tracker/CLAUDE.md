# Budget Tracker

**Status:** active
**Started:** 2026-07-19
**Area:** 20_Projects

## Purpose
Automated personal budget tracking. Extracts consumption transactions from Gmail
notifications sent by 3 credit/debit cards (all on one email account), logs them
into the monthly budget worksheet, and compares actual spend against budgeted
values per category. Based on that comparison, sends a Telegram message with the
money left in the budget — or a warning when a budget limit is exceeded.

## Current state
Idea stage — captured from inbox on 2026-07-19. No architecture or stack decided
yet. Open questions: how to access Gmail (API vs. forwarding), worksheet format
(Google Sheets vs. local file), where the automation runs (cron on a home
server/VPS?), and Telegram bot setup.

## Key files
- `TASKS.md` — open items
- `NOTES.md` — decisions, findings, links
