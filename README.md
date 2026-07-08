# NSCLC Clinical Trials Analysis

A due-diligence-style investment and risk assessment of the Non-Small Cell Lung Cancer (NSCLC) drug development pipeline, built using SQL, Excel, and Power BI.

## Project Overview

This project analyzes the competitive and risk landscape of NSCLC clinical trials to answer a core business question: **where is development activity concentrated, how does risk change across trial phases, and who are the leading sponsors driving this space?**

It's modeled after the kind of due-diligence analysis used in life sciences consulting and venture capital — combining data extraction, business modeling, and visualization into a single investment-memo-style deliverable.

## Tools & Skills Used

- **SQL** (PostgreSQL, via the AACT clinical trials database): SELECT, WHERE, JOIN, GROUP BY, aggregation, subqueries, CTEs, window functions
- **Excel**: XLOOKUP/VLOOKUP, pivot tables, TAM/SAM/SOM market sizing, Probability-of-Success modeling
- **Power BI**: pipeline visualization, risk heatmap dashboard
- **Business frameworks**: Porter's Five Forces, SWOT analysis

## Data Source

[AACT (Aggregate Analysis of ClinicalTrials.gov)](https://aact.ctti-clinicaltrials.org/) — a free, public PostgreSQL database maintained by the Clinical Trials Transformation Initiative, updated daily from ClinicalTrials.gov.

## Repository Structure
├── sql/
│   └── nsclc_sql_analysis.sql       # All SQL queries, commented
├── data/
│   ├── query3_phase_summary.csv     # Trial count & enrollment by phase
│   ├── query4_termination_rate.csv  # Termination rate by phase
│   ├── query5_rank_sponsors.csv     # Full sponsor ranking by phase
│   └── query5b_top_sponsor.csv      # Top sponsor per phase
├── notes/
│   └── sql_findings_summary.md      # Question → method → finding write-up
└── README.md
## Key Findings So Far (SQL Phase)

1. **Development activity concentrates in Phase 2** — highest trial count and average enrollment of any phase.
2. **Trial risk declines predictably by phase** — termination rate drops from ~21.5% in Phase 1 to ~2% in Phase 4.
3. **Sponsorship shifts from academic to industry** — early phases led by institutions like the National Cancer Institute; late-stage trials led by major pharma (Hoffmann-La Roche).

See [`notes/sql_findings_summary.md`](./notes/sql_findings_summary.md) for the full write-up.

## Project Status

- [x] SQL analysis (AACT database)
- [ ] Excel market sizing & risk modeling
- [ ] Power BI dashboard
- [ ] Final investment memo (Five Forces, SWOT, recommendation)

## About

Built as a portfolio project ahead of an MSc in Biotechnology & Business at UCD, targeting roles in life sciences strategy, consulting, and analytics.
