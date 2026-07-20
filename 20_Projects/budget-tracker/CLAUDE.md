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
Architecture decided 2026-07-19: Gmail API (read-only OAuth) → parser →
Google Sheets worksheet → Telegram bot, run by cron on the home server/Pi.
Next: grab sample notification emails from the 3 cards to design the parser,
define budget categories, set up Google Cloud OAuth and the Telegram bot.
See NOTES.md for decisions and the proposed pipeline.

## Key files
- `TASKS.md` — open items
- `NOTES.md` — decisions, findings, links
