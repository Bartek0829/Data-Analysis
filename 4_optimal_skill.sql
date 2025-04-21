/*
Jakich umiejętności warto się uczyć?
- Wskaż umiejętności, które są najbardziej pożądane i najlepiej płatne.
- Skup się na stanowiskach, na których można pracować zdalnie.
*/

WITH skills_demand AS (
    SELECT
        skills_dim.skill_id,
        skills_dim.skills,
        COUNT(job_postings_fact.job_id) AS number_of_jobs
    FROM
        job_postings_fact
    INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
    WHERE
        job_work_from_home = TRUE AND
        salary_year_avg IS NOT NULL
    GROUP BY
        skills_dim.skill_id
),
average_salary AS (
    SELECT
        skills_dim.skill_id,
        skills_dim.skills,
        ROUND(AVG(salary_year_avg), 2) AS avg_salary
    FROM
        job_postings_fact
    INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
    WHERE
        job_work_from_home = TRUE AND
        salary_year_avg IS NOT NULL
    GROUP BY
        skills_dim.skill_id
)

SELECT
    skills_demand.skills,
    number_of_jobs,
    avg_salary
FROM
    skills_demand
INNER JOIN average_salary ON skills_demand.skill_id = average_salary.skill_id
WHERE
    number_of_jobs > 150
ORDER BY
    average_salary DESC,
    number_of_jobs DESC
    