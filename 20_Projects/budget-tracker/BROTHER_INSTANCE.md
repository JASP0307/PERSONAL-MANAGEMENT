# Second Instance — Brother's Budget Tracker

Working notes for adapting the tracker to my brother's bank/email formats and
running his instance alongside mine on the same Lenovo. He has zero technical
background, so he won't touch config files or code — I (Jabner) handle Google
Cloud, the Sheet, and Telegram; Claude adapts the parsing/config once the info
below is gathered.

## Split of responsibilities
- **Jabner:** Google Cloud project + OAuth consent + `credentials.json` +
  first-run `token.json` for his Gmail; his Google Sheet; his Telegram bot via
  BotFather; getting those values into his `config.toml`.
- **Claude:** adapt `parsers.py`/`categorize.py` for his bank's email format
  (current code only understands Banco Popular + Qik), build his
  `config.toml` from the info below, set up the second cron entry safely
  alongside the existing one.

## Info needed before adaptation can start
1. **Bank(s)/card issuer(s)** that send him transaction emails — Popular/Qik
   parsers won't match anything else.
2. **Sample notification emails** — at least one of each type he gets
   (purchase/consumo, declined, withdrawal, reversal if applicable). Forward
   as raw `.eml` or paste the HTML source, same idea as the existing fixtures
   at `app/tests/fixtures/popular_*.html` and `qik_*.html`. These become his
   test fixtures and the reference for writing his parser.
3. **Cards tracked** — issuer, credit/debit, last 4 digits (for display in the
   Sheet, same as `Popular VISA ISI *4417` etc. in the current README).
4. **Budget model** — his monthly income and category → amount table
   (mirrors `config.example.toml`'s `[budget]`; total should equal income).
5. **Merchant → category rules** — his frequent merchants mapped to
   categories (mirrors `[categorize.rules]`); can start thin and grow as
   unmatched merchants get flagged under "Otros / sin categoría".
6. **Currency** — confirm he's still DOP-based (Dominican Republic); if not,
   the USD→DOP manual-rate conversion in `[general]` may not apply as-is.

## Running two instances on the same Lenovo
- Clone the repo into a **sibling folder** (e.g.
  `20_Projects/budget-tracker-brother/app`), not nested inside the existing
  one — separate venv, separate everything.
- Each instance keeps its own `config.toml`, `credentials.json`, `token.json`,
  `tracker.log` — never copy these between the two.
- Separate Google Sheet, separate Telegram bot — no sharing.
- **Watch the flock lock file name.** The current crontab line hardcodes
  `/tmp/budget-tracker.lock`. If the second cron entry reuses that exact path,
  his runs will silently get skipped whenever they overlap mine. Give his
  entry a distinct lock file, e.g. `/tmp/budget-tracker-brother.lock`.
- Both can run on the same 15-min cadence otherwise — they're independent
  processes against different Gmail/Sheets/Telegram accounts.
- Laptop-stays-awake settings (`HandleLidSwitch=ignore`, masked sleep
  targets) are already system-wide on this Lenovo — nothing extra needed for
  the second instance.

## Still to collect from my brother
- [ ] Which bank(s)/card(s) email him transaction notifications?
- [ ] 2-3 sample notification emails (forwarded or pasted)
- [ ] Rough monthly income + budget categories/amounts
- [ ] Any merchants he wants pre-categorized

Once these are in hand, Claude can write his parser/categorize additions and
`config.toml`, and I plug in the Google Cloud/Sheet/Telegram values.
