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
