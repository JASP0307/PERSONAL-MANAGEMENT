# Dashboard
_Last generated: 2026-07-20_

## Active tasks by area

### 10_Work
- No open tasks logged in TASKS.md.

### 20_Projects
- [ ] pigeon-invaders: new 3D CAD design for the 300mW green laser mount and MG996R pan-tilt gimbal (added: 2026-07-19)
- [ ] pigeon-invaders: design a PCB for the main circuit (smaller, more robust device) (added: 2026-07-19)
- [ ] pigeon-invaders: receive and test the 300mW green dot laser (added: 2026-07-19)

**budget-tracker** (project TASKS.md):
- [ ] Prevent the Lenovo laptop from suspending (lid switch + idle sleep) so cron keeps firing — needs sudo, see app/README.md (added: 2026-07-19)
- [ ] Eventually migrate the service from the Lenovo laptop to a Raspberry Pi (added: 2026-07-19)

### 30_Learning
- No open tasks logged in TASKS.md.

### 40_Life_Admin
- [ ] Monthly budget review — last day of each month; see [[finances]] CLAUDE.md; next: 2026-07-31 (added: 2026-07-19)
- [ ] Confirm Fondo de Emergencia target (months of expenses to cover) and define the purpose/target for Ahorros (added: 2026-07-19)

## Projects tracked (for context)
- **10_Work**
  - `agentic-rag-tool` — built and functional, not yet rolled out for real use.
  - `ebo-xml-replicator` — working, in active use at TFC, now in maintenance mode.
- **20_Projects**
  - `pigeon-invaders` — prototype 1 (red laser) tested; v2 in progress: green 300mW laser on order, CAD redesign, MG996R servos, custom PCB.
  - `budget-tracker` — **deployed and running** (2026-07-19); Gmail parser → Google Sheet → Telegram alerts, cron every 15 min on Lenovo laptop. July backfilled (20 txns).
- **30_Learning**
  - `rag-fundamentals` — active; 1 session logged (2026-07-18): sparse/dense/hybrid retrieval, connected to `agentic-rag-tool`.
  - `python-fastapi.md` — standalone note (new format, 2026-07-20): FastAPI basics (routes, Pydantic, auto docs); possible fit for `agentic-rag-tool` if it's ever exposed over HTTP.
- **40_Life_Admin**
  - `finances` — budget dashboard for `budget-tracker`; income RD$61k, ~RD$34.3k budgeted; monthly review due 2026-07-31.

## Workflow changes
- Single-video/topic learning notes no longer get a full track folder — they're
  now a standalone `30_Learning/<topic>.md` file, promotable to a track folder
  later if the topic grows into an ongoing series. Multi-session tracks (e.g.
  `rag-fundamentals/`) keep the folder + CLAUDE.md + NOTES.md pattern.
  (`00_System/AGENT.md`, `30_Learning/CLAUDE.md`)

## Stale items
Nothing stale — all open tasks were added 2026-07-19 (1 day ago). Tasks untouched
for more than 2 weeks will be flagged here.

## Outstanding (not a project task)
- `git push` to `origin` (GitHub) is failing — no cached credentials and no SSH
  key configured. Needs a PAT or SSH key set up before commits can be pushed.
