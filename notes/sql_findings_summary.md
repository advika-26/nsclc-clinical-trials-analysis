# SQL Analysis — Findings Summary
## NSCLC Clinical Trials Analysis | Data source: AACT (ClinicalTrials.gov)

---

### Query 1 & 2: Base Dataset + Sponsor Info
**Question**: What NSCLC trials exist, and who runs them?
**Method**: Filtered the AACT database to trials linked to NSCLC via the `conditions` table, then joined to `sponsors` to attribute each trial to its lead organization.
**Result**: Established a working dataset of NSCLC trials with phase, status, enrollment, and sponsor for all downstream analysis.

---

### Query 3: Trial Count & Average Enrollment by Phase
**Question**: Where is NSCLC drug development activity concentrated?
**Method**: Grouped trials by phase, calculated count and average enrollment per group.
**Finding**: Phase 2 leads on both trial count (1,130 trials) and average enrollment (~83), followed by Phase 1 (590 trials).
**So what**: Development activity concentrates in Phase 2, where most Phase 1 survivors are tested for efficacy before facing the more selective Phase 3 stage.
**Data quality note**: 517 trials had no phase recorded — this group shows an unusually high average enrollment (~1,203), suggesting these may be observational rather than interventional studies. Excluded from phase-based conclusions.

---

### Query 4: Termination Rate by Phase
**Question**: How does trial risk change as a drug moves through development?
**Method**: Built two CTEs (total trials per phase, terminated trials per phase), then joined them to calculate a termination rate.
**Finding**: Termination rate declines steadily by phase — 21.5% (Phase 1) → 18.8% (Early Phase 1) → 16.8% (Phase 1/2) → 12.1% (Phase 2/3) → 11.5% (Phase 2) → 8.1% (Phase 3) → 2% (Phase 4).
**So what**: This is the clearest risk signal in the dataset — surviving each phase acts as a filter, so later-phase trials represent lower-risk, more validated drug candidates. This curve directly informs the Probability-of-Success model built in Excel.

---

### Query 5 & 5b: Sponsor Ranking by Phase
**Question**: Who leads NSCLC development, and does leadership shift across phases?
**Method**: Used a window function (`RANK() OVER PARTITION BY phase`) to rank sponsors by trial count within each phase, then isolated the #1 sponsor per phase using a subquery.
**Finding**: Academic and research institutions dominate early phases — the National Cancer Institute leads Phase 1 (26 trials), Phase 1/2 (11 trials), and Phase 2 (44 trials). Industry sponsors take over in later phases — Hoffmann-La Roche leads both Phase 3 (34 trials) and Phase 4 (7 trials).
**So what**: NSCLC development follows a clear academic-to-industry handoff — publicly/academically funded research drives early discovery, while capital-intensive, large-scale confirmatory trials are run by major pharmaceutical companies. This is a key input for the competitive landscape (Five Forces) section of the final memo.

---

## Summary of Key Findings
1. Development activity concentrates in Phase 2.
2. Trial risk (termination rate) declines steadily and predictably by phase.
3. Sponsorship shifts from academic institutions (early phases) to major pharma (late phases).

## SQL Skills Demonstrated
SELECT, WHERE, subqueries, JOIN, GROUP BY, aggregation (COUNT/AVG), CTEs, window functions (RANK, PARTITION BY).

