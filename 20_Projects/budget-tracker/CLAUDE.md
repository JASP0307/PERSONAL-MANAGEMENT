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
**Deployed and running as of 2026-07-19.** Gmail OAuth (read-only, Production),
Google Sheets, and the Telegram bot are live; July was backfilled (20 txns) and
the app repo is pushed to GitHub. A cron job runs every 15 min on an old Lenovo
laptop (`scripts/run.sh`, flock-guarded; cron.service active). `config.toml`
holds the real credentials (git-ignored).
Remaining: stop the laptop from suspending (sudo — see app/README.md) so cron
keeps firing; eventually migrate to a Raspberry Pi.

## Key files
- `TASKS.md` — open items
- `NOTES.md` — decisions, email formats, category model, budget amounts
- `app/` — Python application; **its own git repo** (pushed to personal GitHub),
  git-ignored by the vault. See `app/README.md` for setup.
