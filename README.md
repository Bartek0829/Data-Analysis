# 📊 Wstęp

Ten projekt opiera się na fikcyjnych danych znalezionych w internecie. Jego celem jest analiza rynku pracy w branży IT przy użyciu zapytań SQL. 🔍

Znajdziesz tutaj odpowiedzi na pytania takie jak:  
💼 *Jakie zawody w IT są najlepiej płatne?*  
🛠️ *Jakie umiejętności są obecnie najbardziej pożądane?*

Wszystkie zapytania SQL dostępne są w folderze: [📁 Data Analysis](/)

## 🛠️ Technologie użyte w projekcie

- **SQL** – Podstawa mojej analizy, umożliwiająca zapytania do bazy danych i odkrywanie kluczowych informacji.  
- **PostgreSQL** – Wybrany system zarządzania bazą danych, idealny do obsługi danych o ofertach pracy.  
- **Visual Studio Code** – Moje główne narzędzie do zarządzania bazą danych i wykonywania zapytań SQL.  
- **Git & GitHub** – Niezbędne do kontroli wersji i udostępniania skryptów SQL oraz analiz, co umożliwia współpracę i śledzenie postępów w projekcie.

## 💰 Jakie są najlepiej płatne zawody w IT?

Aby wskazać najlepiej opłacane zawody, przefiltrowałem wszystkie oferty pracy, wykluczając wiersze bez podanej wartości wynagrodzenia. Następnie posortowałem dane względem wysokości płacy – od najwyższej do najniższej.

```sql
SELECT
    job_id,
    job_title,
    job_location,
    job_schedule_type,
    salary_year_avg,
    job_posted_date,
    name AS company_name
FROM   
    job_postings_fact
LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
WHERE
    salary_year_avg IS NOT NULL AND
    job_location = 'Anywhere'
ORDER BY
    salary_year_avg DESC
LIMIT
    10
;
```

Na podstawie danych, najwyżej opłacanym stanowiskiem okazała się rola **Data Analyst w firmie Mantys**, oferująca średnie roczne wynagrodzenie w wysokości **650 000 USD**.  

Tuż za nią uplasowały się specjalistyczne stanowiska związane z analizą danych i data science, takie jak:

- **Staff Data Scientist/Quant Researcher** – 550 000 USD (Selby Jennings)  
- **Staff Data Scientist – Business Analytics** – 525 000 USD (Selby Jennings)  
- **Senior Data Scientist** – do 475 000 USD

![Top 10 najlepiej płatnych zawodów w IT](/top_jobs.png)

W zestawieniu pojawiają się również stanowiska kierownicze, jak **Head of Data Science**, **Director of Analytics** czy **Principal Machine Learning Engineer**, które również oferują bardzo konkurencyjne wynagrodzenia.

👀 **Wniosek**: Rynek IT premiuje nie tylko doświadczenie techniczne, ale także zdolność do zarządzania danymi i zespołami.

## 📊 Jakie umiejętności są najbardziej pożądane?

Aby stworzyć ranking najbardziej pożądanych umiejętności, połączyłem dwie powiązane tabele 🔗. Dzięki temu mogłem sprawdzić, które umiejętności są najczęściej wymagane w ofertach pracy zdalnej 🧑‍💻.

```sql
SELECT
    skills,
    COUNT(job_postings_fact.job_id) AS number_of_jobs
FROM
    job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_work_from_home = TRUE
GROUP BY
    skills
ORDER BY
    number_of_jobs DESC
LIMIT
    5;
```
