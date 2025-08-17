SELECT 
    job_title_short AS title, 
    job_location AS location,
    job_posted_date::DATE AS date         /* Adding '::' allows for format change, here we made it a 'DATE' to remove the timezone */
FROM
    job_postings_fact

SELECT 
    job_title_short AS title, 
    job_location AS location,
    job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'EST' AS date_time  /* AT TIME ZONE 'UTC' AT TIME ZONE 'ETC' first specified the time zone of the current time (since this data doesn't have it) and then added the time zone we want it */
FROM
    job_postings_fact
LIMIT
    5;

SELECT 
    job_title_short AS title, 
    job_location AS location,
    job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'EST' AS date_time,
    EXTRACT(MONTH FROM job_posted_date) AS date_month,
    EXTRACT(YEAR FROM job_posted_date) AS date_year /* these two extracts month and year from the date_time coloumn, makes them separate columns */
FROM
    job_postings_fact
LIMIT
    5;

SELECT 
    COUNT(job_id) AS job_posted_count,
    EXTRACT(MONTH FROM job_posted_date) AS month    /* Here we are counting the number of jobs per month (aggregated function) to see the trend in job postings per month */
FROM
    job_postings_fact
WHERE
    job_title_short = 'Data Analyst'
GROUP BY
    month
ORDER BY
    job_posted_count DESC;

SELECT
    EXTRACT(MONTH FROM job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'America/New_York') AS month,
    COUNT(*) AS postings_count
FROM
    job_postings_fact
GROUP BY
    month
ORDER BY
    month;