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

### Banco Popular — ATM withdrawal (feeds "Retiro Efectivo")
- From: `notificaciones@popularenlinea.com`, subject: `Notificación de Retiro`
- Same table layout as Consumo, but the 4th column is **`Cajero Automatico`**
  (ATM name) instead of `Comercio`: Monto | Moneda | Fecha | Cajero Automatico | Estatus
- Sample row: `RD$600.00 | Peso dominicano | 16/05/2026 | BANCO POPULAR OF. AV LOS | Aprobada`
- Same DD/MM/YYYY date format; card in greeting ("Visa Débito Clásica, terminada en 9710")
- Every withdrawal → category **Retiro Efectivo** (the cash covers flowers,
  car wash, etc. that can't be itemized further)
- **Inbox confirmed (2026-07-19):** retiro notifications reach jabner0703@gmail.com
  like the other debit-card emails, so the poller sees them natively (the earlier
  sample just happened to be forwarded from juanab0307).

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
- Popular consumo: `from:notificaciones@popularenlinea.com subject:"Notificación de Consumo"`
- Popular retiro: `from:notificaciones@popularenlinea.com subject:"Notificación de Retiro"`
- Qik: `from:notificaciones@qik.do subject:(Usaste OR reversó)`

## Categories

### GASTOS FIJOS (fixed monthly, confirmed 2026-07-19)
| Category                | Auto-tracked from card emails?                        |
| ----------------------- | ----------------------------------------------------- |
| 🏠 Renta                | Unlikely (transfer/cash, not a card swipe)            |
| 🛵 Combustible          | Yes if paid by card (gas station merchant)            |
| 📺 Suscripciones        | Yes (GOOGLE *Google One, ANTHROPIC* CLAUDE SUB, etc.) |
| 📱 Teléfono             | Yes if auto-charged to card                           |
| 🙏 Diezmo               | Unlikely (cash/transfer)                              |
| ❤️ Dinerito de la Dooña | Unlikely (cash/transfer)                              |

**Key implication:** the tracker only sees card-consumption emails. Fixed
expenses paid by transfer or cash (Renta, Diezmo, Dinerito) won't be captured
automatically — they should be entered as fixed budget lines and either assumed
paid or manually checked off. Only card-charged fixed expenses (Suscripciones,
maybe Combustible/Teléfono) will auto-populate.

### GASTOS VARIABLES (confirmed 2026-07-19)
| Category | Fed by | Notes |
|---|---|---|
| 🎉 Salidas | card | Restaurants + girlfriend (Chantal) outings on card. Merchants: TACO BELL, MOCHIZUKI, CHANCHO GUSTO, GRIEGGO YOGART, HELADERIA BON, POLLOS VICTORINA |
| 🚗 Delivery | card | UBER EATS, etc. |
| 🛠️ Mantenimiento | card | INVERSIONES TAKATA (auto parts) |
| 💵 Retiro Efectivo | ATM withdrawal email | Cash withdrawals; covers flowers for Chantal, car wash, and other cash spend that can't be itemized |
| 🗂️ Otros / sin categoría | card | JUMBO (supermarket) + online shopping (AMAZON, Alibaba, PayPal) + any unmatched merchant. Telegram alert flags these so rules can grow |

Decisions folded in (2026-07-19):
- **Chantalita → merged into Salidas** (mostly outings). Cash flower purchases
  surface as Retiro Efectivo, not a separate category.
- **Lavado vehículo → dropped** (paid in cash → shows up as Retiro Efectivo).
- **Supermarket + online shopping → Otros / sin categoría** (this month was an
  exception, not worth their own categories).

Mapping = editable rules (merchant substring → category); unmatched merchants
go to Otros / sin categoría and the Telegram alert mentions them.

### AHORRO (not card-tracked — set-and-assume budget lines, added 2026-07-19)
| Category | Notes |
|---|---|
| 🚨 Fondo de Emergencia | Monthly transfer to emergency fund; not a card swipe |
| 💰 Ahorros | General savings/investment; not a card swipe |

These absorb the previously-unallocated income. Like Renta/Diezmo/Dinerito they
won't generate card emails — enter as fixed monthly lines and treat as paid.

## Monthly budget amounts (RD$) — to fill in
_Reference = partial spend seen in last month's email sample (not a full total)._

### GASTOS FIJOS
| Category                | Monthly budget (RD$)                                                | Reference                                             |
| ----------------------- | ------------------------------------------------------------------- | ----------------------------------------------------- |
| 🏠 Renta                | 5000                                                                | —                                                     |
| 🛵 Combustible          | 10000                                                               | —                                                     |
| 📺 Suscripciones        | ≈ 2150 (US$ @ RD$60: GoogleOne 1.99 + Google 8.99 + Spotify 4.50 = ~928; Claude RD$1,217) | ~US$1.99 + US$8.99 Google/others; Claude sub RD$1,217 |
| 📱 Teléfono             | 810                                                                 | —                                                     |
| 🙏 Diezmo               | 2000                                                                | —                                                     |
| ❤️ Dinerito de la Dooña | 5000                                                                | —                                                     |

### GASTOS VARIABLES
| Category                  | Monthly budget (RD$) | Reference (partial, last month)                                                                 |
| ------------------------- | -------------------- | ----------------------------------------------------------------------------------------------- |
| 🎉 Salidas                | 4000                 | ~RD$4,030 (Taco Bell, Pollos Victorina, Mochizuki, Chancho Gusto, Griego Yogart, Heladería Bon) |
| 🚗 Delivery               | 600                  | ~RD$512 (Uber Eats)                                                                             |
| 🛠️ Mantenimiento         | 1500                 | ~RD$835 (Inversiones Takata)                                                                    |
| 💵 Retiro Efectivo        | 1200                 | RD$600 (one ATM withdrawal seen)                                                                |
| 🗂️ Otros / sin categoría | 2000                 | ~RD$5,300 (Jumbo, Amazon ×2, Small Road, Funeraria)                                             |

### AHORRO
| Category | Monthly budget (RD$) | Reference |
|---|---|---|
| 🚨 Fondo de Emergencia | _to fill_ | — |
| 💰 Ahorros | _to fill_ | — |

_~RD$26,740 was previously unallocated; these two lines should absorb it._

## Budget summary vs. income (2026-07-19)
- **Monthly income: RD$61,000**
- GASTOS FIJOS: Renta 5,000 + Combustible 10,000 + Suscripciones ~2,150 +
  Teléfono 810 + Diezmo 2,000 + Dinerito 5,000 = **~RD$24,960**
- GASTOS VARIABLES: Salidas 4,000 + Delivery 600 + Mantenimiento 1,500 +
  Retiro Efectivo 1,200 + Otros 2,000 = **RD$9,300**
- AHORRO: Fondo de Emergencia + Ahorros = **_to fill_** (should absorb the
  ~RD$26,740 that was previously unallocated)
- **Total budgeted so far: ~RD$34,260**; target = full RD$61,000 once AHORRO
  amounts are set.
- FX assumption: RD$60 / US$1 (manual config value, revisit periodically).

## Open questions
- **Set amounts for Fondo de Emergencia + Ahorros** so the budget totals the
  full RD$61,000.
- How to handle non-card fixed expenses (Renta, Diezmo, Dinerito, Fondo de
  Emergencia, Ahorros): manual sheet entry vs. assume-paid budget lines.
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
