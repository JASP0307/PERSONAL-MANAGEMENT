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
**Live as of 2026-07-19.** First end-to-end run logged 3 real transactions to
the Google Sheet and sent Telegram alerts. Gmail OAuth (read-only), Sheets, and
the Telegram bot are all configured; `config.toml` holds the real credentials
(git-ignored). Two bugs found and fixed during the first run (Popular's nested
HTML tables; date stored as serials breaking the month filter). Remaining:
push the app repo to GitHub, install the cron job on the Pi, and publish the
OAuth app to Production (else the token expires every 7 days).

## Key files
- `TASKS.md` — open items
- `NOTES.md` — decisions, email formats, category model, budget amounts
- `app/` — Python application; **its own git repo** (pushed to personal GitHub),
  git-ignored by the vault. See `app/README.md` for setup.
