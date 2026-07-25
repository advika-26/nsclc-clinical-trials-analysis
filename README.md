# NSCLC Clinical Trials Analysis

A due-diligence-style investment and risk assessment of the Non-Small Cell Lung Cancer (NSCLC) drug development pipeline, built using SQL, Excel, and Power BI.

## Project Overview

This project analyzes the competitive and risk landscape of NSCLC clinical trials to answer a core business question: **where is development activity concentrated, how does risk change across trial phases, and who are the leading sponsors driving this space?**

It's modeled after the kind of due-diligence analysis used in life sciences consulting and venture capital — combining data extraction, business modeling, visualization, and written analysis into a single investment-memo-style deliverable.

## Tools & Skills Used

- **SQL** (PostgreSQL, via the AACT clinical trials database): SELECT, WHERE, JOIN, GROUP BY, aggregation, subqueries, CTEs, window functions
- **Excel**: XLOOKUP/VLOOKUP, pivot tables, TAM/SAM/SOM market sizing, Probability-of-Success modeling
- **Power BI**: multi-page interactive dashboard — pipeline visualization, sponsor activity, risk curve, market sizing funnel, PoS comparison
- **Business frameworks**: Porter's Five Forces, SWOT analysis
- **Deliverable**: Full written investment memo (PDF)

## Data Source

[AACT (Aggregate Analysis of ClinicalTrials.gov)](https://aact.ctti-clinicaltrials.org/) — a free, public PostgreSQL database maintained by the Clinical Trials Transformation Initiative, updated daily from ClinicalTrials.gov.

## Repository Structure

- [`Docs/`](./Docs)
  - [`NSCLC .xlsx`](./Docs/NSCLC%20.xlsx) — Excel workbook (pivot tables, TAM/SAM/SOM model, Probability-of-Success model)
  - [`NSCLC power bi.pbix`](./Docs/NSCLC%20power%20bi.pbix) — Power BI dashboard file (open in Power BI Desktop to explore interactively)
  - [`NSCLC_Investment_Memo.pdf`](./Docs/NSCLC_Investment_Memo.pdf) — Full written investment memo
- [`data/`](./data)
  - `nsclc_sql_analysis.sql` — All SQL queries, commented
  - `query1.csv` , `query2.csv` — Base query exports
  - `query3_phase_summary.csv` — Trial count & enrollment by phase
  - `query4_termination_rate.csv` — Termination rate by phase
  - `query5_Rank_sponsors.csv` — Full sponsor ranking by phase
  - `query5b_Top_sponsor.csv` — Top sponsor per phase
- [`notes/`](./notes)
  - [`sql_findings_summary.md`](./notes/sql_findings_summary.md) — Question → method → finding write-up
  - [`business_frameworks.md`](./notes/business_frameworks.md) — Porter's Five Forces and SWOT analysis
  - [`prompts`](./notes/prompts) — Prompt used to generate the final investment memo via AI
- `README.md`

## Key Findings

1. **Development activity concentrates in Phase 2** — highest trial count and average enrollment of any phase.
2. **Trial risk declines predictably by phase** — termination rate drops from ~21.5% in Phase 1 to ~2% in Phase 4.
3. **Sponsorship shifts from academic to industry** — early phases led by institutions like the National Cancer Institute; late-stage trials led by major pharma (AstraZeneca, Hoffmann-La Roche — the only two full-pipeline sponsors).
4. **Tagrisso (AstraZeneca) market sizing**: ~$54.5B theoretical total market, narrowing to a realistic ~$3.7B obtainable market given competition and treatment rates.
5. **True oncology approval odds are far lower than simple termination rates suggest** — ~5% industry-reported likelihood of approval from Phase 1, vs. a naive ~72% estimate based on termination rate alone.

See [`notes/sql_findings_summary.md`](./notes/sql_findings_summary.md) and [`Docs/NSCLC_Investment_Memo.pdf`](./Docs/NSCLC_Investment_Memo.pdf) for full detail.

## AI-Assisted Workflow

The final investment memo was generated using a structured prompt (see [`notes/prompts`](./notes/prompts)) that pulls data directly from this project's SQL and Excel outputs rather than relying on the model's own assumptions.

## Project Status

- [x] SQL analysis (AACT database)
- [x] Excel market sizing & risk modeling
- [x] Power BI dashboard
- [x] Business frameworks (Five Forces, SWOT)
- [x] Final investment memo

## About

Built as a portfolio project ahead of an MSc in Biotechnology & Business at UCD, targeting roles in life sciences strategy, consulting, and analytics.
