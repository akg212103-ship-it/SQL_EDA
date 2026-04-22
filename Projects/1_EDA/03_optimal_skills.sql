/*
Question: What are the most optimal skills for data engineers—balancing both demand and salary?
- Create a ranking column that combines demand count and median salary to identify the most valuable skills.
- Focus only on remote Data Engineer positions with specified annual salaries.
- Why?
    - This approach highlights skills that balance market demand and financial reward. It weights core skills appropriately instead of letting rare, outlier skills distort the results.
    - The natural log transformation ensures that both high-salary and widely in-demand skills surface as the most practical and valuable to learn for data engineering careers.
*/


select 
    sd.skills,
    count(jpf.*) as skill_count,
    round(LN(count(jpf.*)),1) as optimal_demand,
    median(salary_year_avg) as avg_salary,
    round((median(salary_year_avg) * round(LN(count(jpf.*)),1))/1_000_000,2) as optimal_score
    
from job_postings_fact jpf 
inner join skills_job_dim sjd on jpf.job_id = sjd.job_id 
inner join skills_dim sd on sd.skill_id = sjd.skill_id
where 
    jpf.job_title_short ='Data Engineer' 
    and job_work_from_home = True
    and jpf.salary_year_avg is not null
group by 
    sd.skills
having skill_count >=100
order by 
    optimal_score desc
limit 20;


/*
Overview of High-Value Skills for Data Engineers

When evaluating skills based on a combination of strong demand and attractive salaries, several technologies stand out as particularly valuable in today’s market.

Top Performers by Overall Value
Terraform ranks at the top due to its impressive median salary of $184K, even with a relatively smaller number of postings. Meanwhile, Python and SQL continue to dominate in terms of demand, each appearing in over 1,100 job listings, while still offering solid median salaries of $135K and $130K.

Cloud and big data tools such as AWS, Spark, and Airflow are also key players, combining healthy demand with competitive pay. Airflow, in particular, stands out with one of the highest median salaries at $150K. Kafka also deserves mention for pairing strong compensation with steady demand. Tools like Snowflake, Azure, and Databricks further reinforce the importance of cloud-based data platforms, each offering a good mix of opportunities and pay.

DevOps and Engineering Ecosystem
Technologies that support data infrastructure—such as Airflow, Kubernetes, and Docker—offer a compelling mix of salary and relevance in modern workflows. Version control tools like Git and GitHub remain widely applicable and continue to provide competitive compensation across roles.

Programming Languages in Demand
Java and Scala remain reliable options for data engineering roles, offering both steady demand and strong salaries. Go is another language gaining attention, particularly for its high earning potential despite a smaller number of job postings.

Data Platforms and Cloud Technologies
A well-rounded skill set often includes familiarity with platforms like Redshift, GCP, Hadoop, and MongoDB, all of which show consistent demand and solid pay levels. Knowledge of NoSQL systems, along with tools like PySpark and BigQuery, can further strengthen a data engineer’s profile.

Final Takeaway
The most strategic skills are those that strike a balance between job availability and 
compensation. Core technologies such as Python, SQL, AWS, Spark, Airflow, and Terraform 
consistently deliver on both fronts, making them excellent choices for anyone looking to grow in the data engineering field over the long term.

┌────────────┬─────────────┬────────────────┬───────────────┬───────────────┐
│   skills   │ skill_count │ optimal_demand │  avg_salary   │ optimal_score │
│  varchar   │    int64    │     double     │    double     │    double     │
├────────────┼─────────────┼────────────────┼───────────────┼───────────────┤
│ terraform  │         193 │            5.3 │      184000.0 │          0.98 │
│ python     │        1133 │            7.0 │      135000.0 │          0.95 │
│ aws        │         783 │            6.7 │   137320.3125 │          0.92 │
│ sql        │        1128 │            7.0 │      130000.0 │          0.91 │
│ airflow    │         386 │            6.0 │      150000.0 │           0.9 │
│ spark      │         503 │            6.2 │      140000.0 │          0.87 │
│ kafka      │         292 │            5.7 │      145000.0 │          0.83 │
│ snowflake  │         438 │            6.1 │      135500.0 │          0.83 │
│ azure      │         475 │            6.2 │      128000.0 │          0.79 │
│ java       │         303 │            5.7 │      135000.0 │          0.77 │
│ scala      │         247 │            5.5 │ 137290.484375 │          0.76 │
│ kubernetes │         147 │            5.0 │      150500.0 │          0.75 │
│ git        │         208 │            5.3 │      140000.0 │          0.74 │
│ databricks │         266 │            5.6 │      132750.0 │          0.74 │
│ redshift   │         274 │            5.6 │      130000.0 │          0.73 │
│ hadoop     │         198 │            5.3 │      135000.0 │          0.72 │
│ gcp        │         196 │            5.3 │      136000.0 │          0.72 │
│ nosql      │         193 │            5.3 │      134415.0 │          0.71 │
│ pyspark    │         152 │            5.0 │      140000.0 │           0.7 │
│ docker     │         144 │            5.0 │      135000.0 │          0.68 │
└────────────┴─────────────┴────────────────┴───────────────┴───────────────┘

*/