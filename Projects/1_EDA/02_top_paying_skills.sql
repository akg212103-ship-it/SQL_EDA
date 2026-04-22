/*
Question: What are the highest-paying skills for data engineers?
- Calculate the median salary for each skill required in data engineer positions
- Focus on remote positions with specified salaries
- Include skill frequency to identify both salary and demand
- Why? Helps identify which skills command the highest compensation while also showing 
    how common those skills are, providing a more complete picture for skill development priorities
*/


select 
    sd.skills,
    count(*) as skill_count,
    median(salary_year_avg) as avg_salary
    
from job_postings_fact jpf 
inner join skills_job_dim sjd on jpf.job_id = sjd.job_id 
inner join skills_dim sd on sd.skill_id = sjd.skill_id
where 
    jpf.job_title_short ='Data Engineer' and job_work_from_home = True
group by 
    sd.skills
having skill_count >=100
order by 
    avg_salary desc
limit 20;

/*
Key Insights:

Rust stands out as the highest-paying skill, with a median salary of about $210K. However, its presence in job listings is still fairly limited, with only 232 postings.
Terraform and Golang also offer strong earning potential, each with median salaries around $184K, while maintaining solid demand (Terraform: 3,248 postings; Golang: 912 postings).
Several other skills strike a balance between high pay and reasonable demand, including:
Spring ($175.5K median, 364 postings)
Neo4j ($170K median, 277 postings)
GDPR ($169.6K median, 582 postings)
GraphQL ($167.5K median, 445 postings)
Kubernetes ($150.5K median, 4,202 postings)
Airflow ($150K median, 9,996 postings)
Technologies like Bitbucket, Ruby, Redis, Ansible, and Jupyter also rank among the 
top-paying skills, each appearing in several hundred job listings.
Unlike earlier trends where top-paying skills were tied to very niche demand, many of these 
technologies now show consistent hiring activity.

Overall Takeaway:
Although Rust leads in compensation, its demand is comparatively niche. In contrast, 
skills such as Terraform, Golang, Spring, Neo4j, and widely used data engineering tools 
like Airflow and Kubernetes offer a more balanced combination of strong salaries and broader 
job opportunities, making them practical choices for career growth






*/