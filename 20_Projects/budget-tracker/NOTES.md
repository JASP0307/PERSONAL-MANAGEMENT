# Budget Tracker — Notes

## Decisions

### 2026-07-19 — Scope
- **US$ transactions are converted to RD$** and logged in a single RD$ budget.
  Conversion rate kept as a config value in the sheet (updated manually now and
  then) — simpler than a live FX API and accurate enough for budgeting.
- **Only card consumption emails count** — "Comprobante Transacción Recurrente"
  receipts and statements are excluded from the budget.

### 2026-07-19 — Architecture
- **Gmail access: Gmail API** — OAuth with read-only scope
  (`gmail.readonly`), polling for new card notification emails. Most robust
  option; no changes to the mail flow.
- **Worksheet: Google Sheets** — editable/reviewable from the phone; API
  pairs naturally with the same Google Cloud project used for Gmail OAuth.
- **Hosting: home server / Pi** — cron job on owned hardware. Free and
  private; accepted trade-off: depends on home power/internet uptime.

## The 3 cards (confirmed from Gmail 2026-07-19)
1. **VISA ISI** (Banco Popular, credit) — ends 4417
2. **Visa Débito Clásica** (Banco Popular, debit) — ends 9710
3. **Qik credit** (Qik Banco Digital) — ends 4494

## Email formats (from real samples, 2026-07-19)

### Banco Popular — both cards
- From: `notificaciones@popularenlinea.com`, subject: `Notificación de Consumo`
- Body has an HTML table with columns: Monto | Moneda | Fecha | Comercio | Estatus
- Sample row: `RD$1,089.90 | Peso dominicano | 19/07/2026 | JUMBO PATIO EMBAJADA | Aprobada`
- Amounts use thousands separators (`RD$1,089.90`, `US$1.99`); currencies seen:
  RD$ (Peso dominicano) and US$ (Dólar estadounidense)
- **Date format: DD/MM/YYYY**
- Card identified in greeting text: "su VISA ISI, terminada en 4417" /
  "su Tarjeta Visa Débito Clásica, terminada en 9710"
- Declined variant exists (same subject, body says "declinada", card blocked) —
  parser must check Estatus/body and only log `Aprobada`

### Qik — purchases
- From: `notificaciones@qik.do`, subject: `Usaste tu tarjeta de crédito Qik`
- Key sentence: "Se hizo una transacción de **RD$ 2,031.75** en **AMAZON 1**…"
- Detail table: Localidad | Fecha y hora | Monto | Balance Disponible
- Amount format `RD$ 2,031.75` (note the space after RD$)
- **Date format: MM-DD-YYYY hh:mm AM/PM (AST)** — US-style order, unlike Popular!
- Bonus: `Balance Disponible` is included — could be tracked as a sanity check

### Qik — reversals
- Same sender, subject: `Se reversó una transacción en tu tarjeta de crédito Qik`
- Table: Estatus (Reversada) | Fecha y hora | Monto | Lugar
- Should be logged as a negative amount (credit back) so the budget self-corrects

### Emails to exclude (same senders/keywords, not consumptions)
- `popularteinforma@popularenlinea.com` — marketing
- `notificacionespopular@bpd.com.do` — "Comprobante Transacción Recurrente"
  (recurring payment receipts; decide whether to include — see open questions)
- `no-reply-qik@qik.com.do` — monthly statement
- Personal emails from bank staff (e.g. `U*@bpd.com.do` card upsell)

### Gmail queries for the poller
- Popular: `from:notificaciones@popularenlinea.com subject:"Notificación de Consumo"`
- Qik: `from:notificaciones@qik.do subject:(Usaste OR reversó)`

## Proposed categories (draft 2026-07-19, from last month's real merchants)
| Category | Observed merchants |
|---|---|
| Supermercado | JUMBO PATIO EMBAJADA |
| Comida fuera / delivery | UBER EATS, TACO BELL, POLLOS VICTORINA, MOCHIZUKI, CHANCHO GUSTO, GRIEGGO YOGART, HELADERIA BON |
| Compras online | AMAZON, Alibaba.com, PAYPAL * |
| Suscripciones | GOOGLE *Google One, ANTHROPIC* CLAUDE SUB |
| Otros | INVERSIONES TAKATA, SMALL ROAD COMPANY, FUNERARIA BLANDINO, unmatched merchants |

Mapping = editable rules (merchant substring → category); unmatched goes to
Otros and the Telegram alert can mention it so the rule table grows over time.

## Open questions
- Confirm category set + monthly budget amount per category (RD$).
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
