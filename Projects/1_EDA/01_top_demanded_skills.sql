/*
Question: What are the most in-demand skills for data engineers?
- Join job postings to inner join table similar to query 2
- Identify the top 10 in-demand skills for data engineers
- Focus on remote job postings
- Why? Retrieves the top 10 skills with the highest demand in the remote job market,
    providing insights into the most valuable skills for data engineers seeking remote work
*/

select 
    sd.skills,
    count(*) as demand_count
from job_postings_fact jpf 
inner join skills_job_dim sjd on jpf.job_id = sjd.job_id 
inner join skills_dim sd on sd.skill_id = sjd.skill_id
where 
    jpf.job_title_short ='Data Engineer' and job_work_from_home = True
group by 
    sd.skills
order by 
    demand_count desc
limit 10;

/*
An analysis of current hiring trends shows that SQL and Python dominate the data engineering 
landscape, each appearing in roughly 29,000 job listings—significantly ahead of other skills.

Cloud technologies also play a major role, with AWS leading demand at around 18,000 postings, 
while Azure follows with approximately 14,000. 
Apache Spark ranks among the top skills as well, 
with close to 13,000 mentions, underscoring the continued need for expertise in large-scale 
data processing.

Key insights:

SQL and Python form the core skill set expected of data engineers
Proficiency in cloud platforms like AWS and Azure is increasingly essential
Big data frameworks such as Spark remain highly relevant
Tools for building and managing data pipelines (e.g., Airflow, Snowflake, Databricks) are 
gaining traction.Additional skills like Java and Google Cloud Platform also feature among the 
top requirements.


┌────────────┬──────────────┐
│   skills   │ demand_count │
│  varchar   │    int64     │
├────────────┼──────────────┤
│ sql        │        29221 │
│ python     │        28776 │
│ aws        │        17823 │
│ azure      │        14143 │
│ spark      │        12799 │
│ airflow    │         9996 │
│ snowflake  │         8639 │
│ databricks │         8183 │
│ java       │         7267 │
│ gcp        │         6446 │
├────────────┴──────────────┤
│ 10 rows         2 columns │
└───────────────────────────┘
*/