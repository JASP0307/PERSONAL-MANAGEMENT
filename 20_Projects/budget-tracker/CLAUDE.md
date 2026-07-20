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
Build started 2026-07-19. Design locked: Gmail API (read-only) → parser →
Google Sheets → Telegram, cron on the home server/Pi. Categories + monthly
amounts set (budget = 100% of RD$61k income). Python app scaffolded in `app/`
with parsers + categorization tested against real emails and the full
Gmail/Sheets/Telegram pipeline implemented. Remaining: user-side Google Cloud
OAuth, Telegram bot, and the Sheet, then a first live run.

## Key files
- `TASKS.md` — open items
- `NOTES.md` — decisions, email formats, category model, budget amounts
- `app/` — Python application; **its own git repo** (pushed to personal GitHub),
  git-ignored by the vault. See `app/README.md` for setup.
