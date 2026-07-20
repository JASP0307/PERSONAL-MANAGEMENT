# 40_Life_Admin / finances

My personal budget and savings, from the *life* side. The numbers are produced
automatically by the [[budget-tracker]] project (in 20_Projects) and live in a
Google Sheet — this folder is where I set goals, review, and decide what to do
about the data. The tool is the engine; this is the dashboard.

## Sources of truth (don't duplicate the numbers here)
- **Live spend vs. budget:** Google Sheet —
  https://docs.google.com/spreadsheets/d/1KJt1mH_RY1RIaHaja0V_Ag3aoOjpS9uqH4qGqTMvURc/edit
- **The tool:** [[budget-tracker]] — parses card-notification emails → Sheet →
  Telegram alert after each charge.
- **Enforced budget & category rules:** budget-tracker `config.toml` (git-ignored).

## Files
- `BUDGET.md` — income and high-level allocation, with dashboard links.
- `REVIEWS.md` — monthly budget review log.

## Monthly review procedure (last day of each month)
1. Open the Sheet's **Presupuesto** tab; read Gastado vs Presupuesto per category.
2. Log the month in `REVIEWS.md`: total spent, over/under categories, and savings
   actually set aside (Fondo de Emergencia, Ahorros).
3. Update savings-goal progress in [[GOALS]].
4. If a merchant keeps landing in "Otros / sin categoría", add a rule to the
   tracker's `config.toml` (that's a [[budget-tracker]] task, not a life task).
