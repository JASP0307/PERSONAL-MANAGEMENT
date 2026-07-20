# Budget Tracker — Tasks

## Open
- [ ] Install cron job on the home server/Pi (every 15 min; see app/README.md) (added: 2026-07-19)
- [ ] Publish the Google OAuth app to Production so the token doesn't expire every 7 days (added: 2026-07-19)

## Done
- [x] Push app repo to personal GitHub (done: 2026-07-19)
- [x] Backfill current month (July): 20 transactions logged, duplicate guard added (skips same-content bank notifications) (done: 2026-07-19)
- [x] First live end-to-end run: 3 real transactions logged to the sheet, Telegram alerts sent, dedupe verified (done: 2026-07-19)
- [x] Set up Google Cloud OAuth (Gmail read-only + Sheets), Telegram bot, and the Google Sheet (auto-created with live budget formulas) (done: 2026-07-19)
- [x] Add gas-station merchant rules (TOTAL, TEXACO, SHELL → Combustible) (done: 2026-07-19)
- [x] Scaffold Python app in app/ (own git repo): parsers + categorization tested against real emails, Gmail/Sheets/Telegram pipeline implemented (done: 2026-07-19)
- [x] Set RD$ amounts for Fondo de Emergencia (10k) + Ahorros (16.74k); budget = 100% of income (done: 2026-07-19)
- [x] Set monthly RD$ budget per category; income RD$61k, budgeted ~RD$34.3k, ~RD$26.7k unallocated (done: 2026-07-19)
- [x] Define budget categories → GASTOS FIJOS (6) + GASTOS VARIABLES (5, incl. Retiro Efectivo), documented in NOTES.md (done: 2026-07-19)
- [x] Define scope: 3 cards identified (Popular VISA ISI *4417, Popular débito *9710, Qik *4494), email formats incl. Notificación de Retiro documented in NOTES.md (done: 2026-07-19)
- [x] Decide Gmail access method → Gmail API, read-only OAuth (done: 2026-07-19)
- [x] Decide budget worksheet format and location → Google Sheets (done: 2026-07-19)
- [x] Decide where the automation runs → cron on home server/Pi (done: 2026-07-19)
