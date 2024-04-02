USE [Bank Loan DB]
select * from bank_loan_data

select count (*) total_Null_values from bank_loan_data
where emp_title is Null

--Total Loan Application:

select Count(id) Total_Loal_Applications 
from bank_loan_data
  
--Total Loan Application of latest month:

select count(id) as Total_Loan_Application_latest_Month 
from bank_loan_data 
where Month(issue_date) = Month((select MAX (issue_date)  from bank_loan_data))
  AND YEAR (issue_date) = Year((select MAX (issue_date) from bank_loan_data))


-- Total Funded Amont:

select SUM (loan_amount) AS Total_Funded_Amount
from bank_loan_data

--Total Funded Amount in Latest Month:
SELECT SUM(loan_amount) "Total funded amount in latest month"
from bank_loan_data
where MONTH(issue_date)=MONTH((Select MAX (issue_date) from bank_loan_data))
AND YEAR(issue_date)=YEAR((select MAX(issue_date) from bank_loan_data))

--Total Amount Recieved 
select SUM(total_payment) "Total Amount Recieved" 
from bank_loan_data

--Total Amount Recieved in latest Month:
SELECT SUM(total_payment) "Total Amount Recieved in Latest Months" 
from bank_loan_data
where MONTH(issue_date) = MONTH((select MAX (issue_date) from bank_loan_data))
and year (issue_date) = YEAR((SELECT MAX (issue_date) from bank_loan_data))


--Average Intrest Rate:
SELECT  AVG(int_rate)  "Average Intrest rate"
from bank_loan_data

-- Average Intrest Rate in %:
SELECT CAST(AVG(int_rate) * 100 as decimal(10,2)) from bank_loan_data

-- Average Intrest rate in latest Year:
SELECT CAST (AVG(int_rate) * 100 as decimal(10,2))
from bank_loan_data
where MONTH(issue_date)= MONTH((select MAX (issue_date) from bank_loan_data ))
AND YEAR(issue_date)=YEAR((SELECT MAX(issue_date) from bank_loan_data))

-- Average Debt-to-Income Ratio :
select ROUND(AVG (dti),4) *100 
from bank_loan_data

--Average Debt-to-Income Ratio in latest Month:
select ROUND(AVG(dti) ,4)*100 
from bank_loan_data
where MONTH(issue_date)=MONTH((SELECT MAX(issue_date) from bank_loan_data))
AND YEAR(issue_date)=(SELECT YEAR(MAX (issue_date)) from bank_loan_data)

select distinct loan_status from bank_loan_data
select  DISTINCT (loan_status) , Count(id) from bank_loan_data
groupby DISTINCT(loan_status)

--Good Loan Percentage
select 
COUNT (case when loan_status='fully Paid' OR loan_status = 'Current' THEN id END) *100
/
COUNT(id) as Good_Loan_Percentage
from bank_loan_data

--Bad Loan Percentage
select distinct (loan_status) from bank_loan_data

SELECT 
count(case when  loan_status='Charged Off' then id END ) *100
/
Count (id)  "Bad Loan %"
FROM bank_loan_data


--Good Loan Funded Amount

SELECT
sum(loan_amount) from bank_loan_data
where loan_status = 'Fully Paid' or  loan_status= 'Current'

--Bad Loan Funded Amount 

SELECT 
SUM(loan_amount) from bank_loan_data
where loan_status='Charged Off'


--Good Loan Total Recieved Payment

SELECT SUM(total_payment) 
from bank_loan_data
where loan_status = 'Fully Paid' or loan_status= 'Current'

--Bad Loan Total Recieved Payment

SELECT SUM(total_payment)
from bank_loan_data
where loan_status = 'Charged Off'

--Loan status Grid View

select 
   loan_status,
   count (id) as Total_Applications,
   sum(total_payment) as Total_Amount_Recieved,
   sum(loan_amount) as Total_funded_amount,
   CAST(AVG(int_rate ) *100 as decimal (10,2)) as Intrest_Rate,
   CAST(AVG(dti) *100 as decimal (10,2)) as DTI

from bank_loan_data
Group by loan_status


--Monthly Trend by "Total Loan Application" , "Total Funded Amount" , "Total Amount Recieved"

select
MONTH (issue_date) as Month,
DATENAME(Month,issue_date) as Month_Name,
Count(id) as Total_Loan_Applications,
SUM(loan_amount) as Total_funded_Amount,
SUM(total_payment) as Total_received_Amount 
FROM bank_loan_data
GROUP BY MONTH (issue_date), DATENAME(Month,issue_date)
Order BY MONTH (issue_date)

--Regional State Analysis by "Total Loan Application" , "Total Funded Amount" , "Total Amount Recieved"

SELECT address_state,
COUNT(id) as Total_loan_applications,
SUM(loan_amount) as Total_Funded_Amount,
SUM(total_payment) as Total_reveived_Amount
from bank_loan_data
Group by address_state

--Loan Term Analysis by "Total Loan Application" , "Total Funded Amount" , "Total Amount Recieved"

SELECT 
term,
COUNT(id) as Total_loan_applications,
SUM(loan_amount) as Total_Funded_Amount,
SUM(total_payment) as Total_received_Amount
from bank_loan_data
Group by term


--Employee Length Analysis by "Total Loan Application" , "Total Funded Amount" , "Total Amount Recieved"


select 
emp_length,
COUNT(id) as Total_Loan_Application,
SUM(loan_amount) as Total_funded_Amount,
SUM(total_payment) as Total_received_Amount
from bank_loan_data
Group by emp_length

--Loan Purpose Breakdown by "Total Loan Application" , "Total Funded Amount" , "Total Amount Recieved"

SELECT 
purpose,
Count(id) as Total_Loan_Application,
SUM(loan_amount) as Total_Funded_Amount,
SUM(total_payment) as Total_recieved_amount

from bank_loan_data
Group by purpose

--Home Ownership Analysis by "Total Loan Application" , "Total Funded Amount" , "Total Amount Recieved"

Select 
home_ownership,
Count(id) as Total_Loan_Application,
SUM(loan_amount) as Total_Funded_Amount,
SUM(total_payment) as Total_recieved_amount
from bank_loan_data
Group BY home_ownership













 