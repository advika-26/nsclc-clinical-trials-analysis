-- ============================================================
-- NSCLC Clinical Trials Analysis
-- Data source: AACT (Aggregate Analysis of ClinicalTrials.gov)
-- ============================================================


-- Query 1: Base NSCLC trial pull
-- Business question: What NSCLC trials exist, with basic characteristics?
select nct_id, phase, overall_status, enrollment, start_date
from studies
where nct_id in (
    select nct_id from conditions 
    where downcase_name like '%non-small cell lung cancer%'
       or downcase_name like '%nsclc%'
);


-- Query 2: Add sponsor info via JOIN
-- Business question: Who is running each of these trials?
select s.nct_id, s.phase, s.overall_status, s.enrollment, sp.name as sponsor_name
from studies s
join sponsors sp on s.nct_id = sp.nct_id
where s.nct_id in (
    select nct_id from conditions 
    where downcase_name like '%non-small cell lung cancer%'
)
and sp.lead_or_collaborator = 'lead';


-- Query 3: Trial count and average enrollment by phase (GROUP BY + aggregation)
-- Business question: Where is development activity concentrated, and how big are these trials?
select s.phase, count(*) as trial_count, avg(s.enrollment) as avg_enrollment
from studies s
where s.nct_id in (
    select nct_id from conditions 
    where downcase_name like '%non-small cell lung cancer%'
)
group by s.phase
order by trial_count desc;


-- Query 4: Termination rate by phase, using a CTE
-- Business question: How does trial risk change as a drug moves through development?
with phase_totals as (
    select phase, count(*) as total_trials
    from studies
    where nct_id in (
        select nct_id from conditions 
        where downcase_name like '%non-small cell lung cancer%'
    )
    group by phase
),
phase_terminated as (
    select phase, count(*) as terminated_trials
    from studies
    where nct_id in (
        select nct_id from conditions 
        where downcase_name like '%non-small cell lung cancer%'
    )
    and overall_status = 'TERMINATED'
    group by phase
)
select 
    t.phase, 
    t.total_trials, 
    coalesce(term.terminated_trials, 0) as terminated_trials,
    round(coalesce(term.terminated_trials, 0)::numeric / t.total_trials * 100, 1) as termination_rate_pct
from phase_totals t
left join phase_terminated term on t.phase = term.phase
order by termination_rate_pct desc;


-- Query 5: Rank sponsors by trial count within each phase, using a window function
-- Business question: Who leads NSCLC development, and does leadership change by phase?
select 
    sp.name as sponsor_name,
    s.phase,
    count(*) as trial_count,
    rank() over (partition by s.phase order by count(*) desc) as rank_within_phase
from studies s
join sponsors sp on s.nct_id = sp.nct_id
where s.nct_id in (
    select nct_id from conditions 
    where downcase_name like '%non-small cell lung cancer%'
)
and sp.lead_or_collaborator = 'lead'
group by sp.name, s.phase
order by s.phase, rank_within_phase;


-- Query 5b: Top-ranked sponsor only, per phase (subquery wrapping a window function)
-- Business question: Clean comparison — who is the #1 sponsor in each phase?
select sponsor_name, phase, trial_count, rank_within_phase
from (
    select 
        sp.name as sponsor_name,
        s.phase,
        count(*) as trial_count,
        rank() over (partition by s.phase order by count(*) desc) as rank_within_phase
    from studies s
    join sponsors sp on s.nct_id = sp.nct_id
    where s.nct_id in (
        select nct_id from conditions 
        where downcase_name like '%non-small cell lung cancer%'
    )
    and sp.lead_or_collaborator = 'lead'
    group by sp.name, s.phase
) ranked
where rank_within_phase = 1
order by phase;
