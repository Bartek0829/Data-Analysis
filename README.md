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
Na podstawie analizy danych, najbardziej poszukiwanymi umiejętnościami okazały się **Python** i **SQL**, z liczbą ofert przekraczającą **40 000** dla każdej z tych technologii.

Kluczowe technologie w zestawieniu to:

- **Python** – 40 524 oferty  
- **SQL** – 40 254 oferty  
- **AWS** – 18 264 oferty  
- **Azure** – 13 913 ofert  
- **Spark** – 13 066 ofert  

![Top 5 najpopularniejszych umiejętności w IT](/top_skills.png)

W czołówce znalazły się również umiejętności związane z chmurą obliczeniową (**AWS**, **Azure**) oraz przetwarzaniem dużych zbiorów danych (**Spark**), które stanowią obecnie podstawę wielu projektów IT.

## Jakie umiejętności są najlepiej płatne?

Aby zidentyfikować najbardziej lukratywne umiejętności, przeanalizowałem średnie roczne wynagrodzenia dla stanowisk zdalnych wymagających konkretnych technologii:

```sql
SELECT
    skills,
    ROUND(AVG(salary_year_avg), 2) AS avg_salary
FROM
    job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_work_from_home = TRUE AND
    salary_year_avg IS NOT NULL
GROUP BY
    skills
ORDER BY
    avg_salary DESC
LIMIT
    25;
```
Analiza ujawniła zaskakujących liderów wśród technologii z najwyższymi średnimi wynagrodzeniami:

🏆 TOP 5 Najlepiej opłacanych umiejętności:
1. **Chef** - $204,125 (🚀 absolutny lider!)  
2. **Neo4j** - $171,716 (bazy grafowe w cenie)  
3. **CouchDB** - $170,000 (niskopoziomowe bazy danych)  
4. **Watson** - $168,276 (AI IBM na podium)  
5. **Tidyverse** - $165,513 (R w czołówce)  

💰 Top 25 Najlepiej Płatnych Umiejętności IT (praca zdalna)
| #   | Umiejętność       | Średnie Rocznie Wynagrodzenie (USD) | Kategoria          |
|-----|-------------------|------------------------------------:|--------------------|
| 1   | Chef              | 204,125.00                         | DevOps             |
| 2   | Neo4j             | 171,715.55                         | Bazy Danych        |
| 3   | CouchDB           | 170,000.00                         | Bazy Danych        |
| 4   | Watson            | 168,276.33                         | AI/ML              |
| 5   | Tidyverse         | 165,512.50                         | Analiza Danych     |
| 6   | Mongo             | 163,868.38                         | Bazy Danych        |
| 7   | GDPR              | 162,353.70                         | Bezpieczeństwo     |
| 8   | Splunk            | 160,983.08                         | Big Data           |
| 9   | OpenCV            | 160,000.00                         | Computer Vision    |
| 10  | Assembly          | 159,796.00                         | Języki Niskopoziomowe |
| 11  | Cassandra         | 158,493.29                         | Bazy Danych        |
| 12  | Rust              | 157,496.89                         | Języki Programowania |
| 13  | Golang            | 155,740.74                         | Języki Programowania |
| 14  | Solidity          | 155,625.00                         | Blockchain         |
| 15  | ASP.NET Core      | 155,000.00                         | Web Development    |
| 16  | dplyr             | 155,000.00                         | Analiza Danych     |
| 17  | Atlassian         | 154,990.45                         | Narzędzia          |
| 18  | Hugging Face      | 154,322.31                         | AI/ML              |
| 19  | NumPy             | 154,132.30                         | Analiza Danych     |
| 20  | TensorFlow        | 153,485.25                         | AI/ML              |
| 21  | C                 | 153,427.08                         | Języki Programowania |
| 22  | Kubernetes        | 153,034.55                         | DevOps             |
| 23  | PyTorch           | 152,626.57                         | AI/ML              |
| 24  | Couchbase         | 152,478.90                         | Bazy Danych        |
| 25  | Unify             | 152,218.75                         | Narzędzia          |

🔍 Kluczowe Wnioski:
- **DevOps i niszowe technologie** (Chef, Neo4j) oferują najwyższe wynagrodzenia
- **AI/ML i analiza danych** dominują w top 25
- **Języki systemowe** (Rust, Go, C) wciąż wysoko w rankingach
- **Specjalistyczne bazy danych** to pewna inwestycja w karierę
