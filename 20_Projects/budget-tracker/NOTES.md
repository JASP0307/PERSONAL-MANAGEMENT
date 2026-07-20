# Budget Tracker — Notes

## Decisions

### 2026-07-19 — Architecture
- **Gmail access: Gmail API** — OAuth with read-only scope
  (`gmail.readonly`), polling for new card notification emails. Most robust
  option; no changes to the mail flow.
- **Worksheet: Google Sheets** — editable/reviewable from the phone; API
  pairs naturally with the same Google Cloud project used for Gmail OAuth.
- **Hosting: home server / Pi** — cron job on owned hardware. Free and
  private; accepted trade-off: depends on home power/internet uptime.

## Open questions
- Which 3 cards/banks, and what do their notification emails look like?
  Need real samples to design the parser (waiting on Gmail re-auth or
  pasted samples).
- Budget categories and monthly amounts per category.
- Telegram: single chat with a bot; polling vs. webhook (webhook needs a
  reachable endpoint — polling is simpler on a home server).

## Proposed pipeline (draft)
1. Cron (home server) runs the script every N minutes.
2. Script queries Gmail API for unprocessed card notification emails
   (tracked via a Gmail label, e.g. `budget/processed`).
3. Parser extracts: card, date, merchant, amount, currency.
4. Category mapping (merchant → budget category, editable rules).
5. Append transaction row to the Google Sheets monthly worksheet.
6. Compare month-to-date spend vs. budgeted amount per category.
7. Telegram bot message: remaining budget, or warning when exceeded.
