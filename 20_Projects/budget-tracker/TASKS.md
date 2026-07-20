# Budget Tracker — Tasks

## Open
- [ ] Set up Google Cloud project: OAuth credentials for Gmail (read-only) + Sheets APIs; download credentials.json (added: 2026-07-19)
- [ ] Set up Telegram bot via @BotFather; get token + chat id (added: 2026-07-19)
- [ ] Create the Google Sheet (Transacciones + Presupuesto tabs) and put its ID in config.toml (added: 2026-07-19)
- [ ] First live end-to-end run once credentials are in place (added: 2026-07-19)
- [ ] Push app repo to personal GitHub (added: 2026-07-19)

## Done
- [x] Scaffold Python app in app/ (own git repo): parsers + categorization tested against real emails, Gmail/Sheets/Telegram pipeline implemented (done: 2026-07-19)
- [x] Set RD$ amounts for Fondo de Emergencia (10k) + Ahorros (16.74k); budget = 100% of income (done: 2026-07-19)
- [x] Set monthly RD$ budget per category; income RD$61k, budgeted ~RD$34.3k, ~RD$26.7k unallocated (done: 2026-07-19)
- [x] Define budget categories → GASTOS FIJOS (6) + GASTOS VARIABLES (5, incl. Retiro Efectivo), documented in NOTES.md (done: 2026-07-19)
- [x] Define scope: 3 cards identified (Popular VISA ISI *4417, Popular débito *9710, Qik *4494), email formats incl. Notificación de Retiro documented in NOTES.md (done: 2026-07-19)
- [x] Decide Gmail access method → Gmail API, read-only OAuth (done: 2026-07-19)
- [x] Decide budget worksheet format and location → Google Sheets (done: 2026-07-19)
- [x] Decide where the automation runs → cron on home server/Pi (done: 2026-07-19)
