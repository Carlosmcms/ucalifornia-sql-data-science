# Module 2 - Practice Quiz

For all the questions in this practice set, you will be using the _Salary by Job Range_ table. This is a single table titled: ```salary_range_by_job_classification```. This table contains the following columns:

```
SetID
Job_Code
Eff_Date
Sal_end_Date
Salary_setID
Sal_Plan
Grade
Step
Biweekly_High_Rate
Biweekly_Low_Rate
Union_Code
Extended_Step
Pay_Type
```

## Questions

1. Find the distinct values for the extended step.

```SQL
SELECT DISTINCT Extended_Step
FROM salary_range_by_job_classification
```

2. Excluding $0.00, what is the minimum biweekly high rate of pay?

```SQL
SELECT MIN(Biweekly_High_Rate)
FROM salary_range_by_job_classification
WHERE biweekly_high_rate <> '$0.00'
```

3. What is the maximum biweekly high rate of pay?

```SQL
SELECT MAX(Biweekly_High_Rate)
FROM salary_range_by_job_classification
```


4. What is the pay type for all the job codes that start with '03'?

```SQL
SELECT Job_Code, Pay_Tyoe
FROM salary_range_by_job_classification
WHERE Job_Code LIKE '03%'
```

5. Run a query to find the Effective Date or Salary End Date for grade Q90H0.

```SQL
SELECT Grade, Eff_Date, Sal_End_Date
FROM salary_range_by_job_classification
WHERE Grade = 'Q90H0'
```

6. Sort the Biweekly low rate in ascending order. _Note: This doesn't look like properly sorted because this is a varchar field.

```SQL
SELECT Biweekly_Low_Rate
FROM salary_range_by_job_classification
ORDER BY Biweekly_Low_Rate ASC
```

7. What step are Job Codes 0110-0400?
```SQL
SELECT Step, Job_Code
FROM salary_range_by_job_classification
WHERE Job_Code BETWEEN '0110' AND '0400'
```

8. What is the Biweekly High Rate minus the Biweekly Low Rate for Job Code 0170?

```SQL
SELECT Job_Code, Biweekly_Low_Rate, Biweekly_High_Rate, Biweekly_High_Rate - Biweekly_Low_Rate AS Biweekly_Rate
FROM salary_range_by_job_classification
WHERE Job_Code = '0170'
```

9. What is the Extended Step for Pay Types M, H and D?

```SQL
SELECT Pay_Type, Extended_Step
FROM salary_range_by_job_classification
WHERE Pay_Type IN('M', 'H', 'D')
GROUP BY Pay_Type
```

10. What is the step for Union Code 990 and a Set ID of 'SFMTA' or 'COMMN'?

```SQL
SELECT Union_Code, SetID, Step
FROM salary_range_by_job_classification
WHERE SetID IN ('SFMTA', 'COMMN')
  AND Union_Code = '990'
```

or

```SQL
SELECT Union_Code, SetID, Step
FROM salary_range_by_job_classification
WHERE (SetID = 'SFMTA' OR SetID = 'COMMN')
  AND Union_Code = '990'
```

