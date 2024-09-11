SELECT * FROM churn.customer_churn_data;
describe customer_churn_data;    

-- Data Exploration – Check Distinct Values

select Gender, count(Gender) as Total_count,
round((count(Gender)/(select count(*) from customer_churn_data))*100,2) as Percentage
from customer_churn_data
group by Gender;

select Contract, count( Contract) as Total_count,
round((count( Contract)/(select count(*) from customer_churn_data))*100,2) as Percentage
from customer_churn_data
group by  Contract;  

select State, count(State) as Total_count,
round((count(State)/(select count(*) from customer_churn_data))*100,2) as Percentage
from customer_churn_data
group by  State
order by Percentage desc;

select Customer_Status, count(Customer_Status) as Total_count,
round((count(Customer_Status)/(select count(*) from customer_churn_data))*100,2) as Percentage
from customer_churn_data
group by  Customer_Status
order by Percentage desc;

select distinct Internet_Type from customer_churn_data;

-- Data Exploration – Check Nulls   

select
sum(case when Customer_ID is null or Customer_ID = '' then 1 else 0 end) as Cust_ID_Null_count,
sum(case when Gender is null or Gender='' then 1 else 0 end) as Gender_Null_count,
sum(case when Age is null or Age='' then 1 else 0 end) as Age_Null_count,
sum(case when Married is null or Married='' then 1 else 0 end) as Married_Null_count,
sum(case when State is null or State='' then 1 else 0 end) as State_Null_count,
sum(case when Number_of_Referrals is null or Number_of_Referrals='' then 1 else 0 end) as Number_of_Referrals_Null_count,
sum(case when Tenure_in_Months is null or Tenure_in_Months='' then 1 else 0 end) as Tenure_in_Months_Null_count,
sum(case when Value_Deal is null or Value_Deal='' then 1 else 0 end) as Value_Deal_Null_count,
sum(case when Phone_Service is null or Phone_Service='' then 1 else 0 end) as Phone_Service_Null_count,
sum(case when Multiple_Lines is null or Multiple_Lines='' then 1 else 0 end) as Multiple_Lines_Null_count,
sum(case when Internet_Service is null or Internet_Service='' then 1 else 0 end) as Internet_Service_Null_count,
sum(case when Internet_Type is null or Internet_Type='' then 1 else 0 end) as Internet_Type_Null_count,
sum(case when Online_Security is null or Online_Security='' then 1 else 0 end) as Online_Security_Null_count,
sum(case when Online_Backup is null or Online_Backup='' then 1 else 0 end) as Online_Backup_Null_count,
sum(case when Device_Protection_Plan is null or Device_Protection_Plan='' then 1 else 0 end) as Device_Protection_Plan_Null_count,
sum(case when Premium_Support is null or Premium_Support='' then 1 else 0 end) as Premium_Support_Null_count,
sum(case when Streaming_TV is null or Streaming_TV='' then 1 else 0 end) as Streaming_TV_Null_count,
sum(case when Streaming_Movies is null or Streaming_Movies='' then 1 else 0 end) as Streaming_Movies_Null_count,
sum(case when Streaming_Music is null or Streaming_Music='' then 1 else 0 end) as Streaming_Music_Null_count,
sum(case when Unlimited_Data is null or Unlimited_Data='' then 1 else 0 end) as Unlimited_Data_Null_count,
sum(case when Contract is null or Contract='' then 1 else 0 end) as Contract_Null_count,
sum(case when Paperless_Billing is null or Paperless_Billing='' then 1 else 0 end) as Paperless_Billing_Null_count,
sum(case when Payment_Method is null or Payment_Method='' then 1 else 0 end) as Payment_Method_Null_count,
sum(case when Monthly_Charge is null or Monthly_Charge='' then 1 else 0 end) as Monthly_Charge_Null_count,
sum(case when Total_Charges is null or Total_Charges='' then 1 else 0 end) as Total_Charges_Null_count,
sum(case when Total_Refunds is null or Total_Refunds='' then 1 else 0 end) as Total_Refunds_Null_count,
sum(case when Total_Extra_Data_Charges is null or Total_Extra_Data_Charges='' then 1 else 0 end) as Total_Extra_Data_Charges_Null_count,
sum(case when Total_Long_Distance_Charges is null or Total_Long_Distance_Charges='' then 1 else 0 end) as Total_Long_Distance_Charges_Null_count,
sum(case when Total_Revenue is null or Total_Revenue='' then 1 else 0 end) as Total_Revenue_Null_count,
sum(case when Customer_Status is null or Customer_Status='' then 1 else 0 end) as Customer_Status_Null_count,
sum(case when Churn_Category is null or Churn_Category='' then 1 else 0 end) as Churn_Category_Null_count,
sum(case when Churn_Reason is null or Churn_Reason='' then 1 else 0 end) as Churn_Reason_Null_count
from customer_churn_data;


-- Remove null and insert the new data into prod_churn table

CREATE TABLE prod_Churn AS
SELECT 
    Customer_ID,
    Gender,
    Age,
    Married,
    State,
    Number_of_Referrals,
    ifnull(NULLIF(Value_Deal, ''), 'None') as Value_Deal,
    Phone_Service,
    ifnull(NULLIF(Multiple_Lines, ''), 'No') as Multiple_Lines,
    Internet_Service,
    ifnull(NULLIF(Internet_Type, ''), 'None') as Internet_Type,
    ifnull(NULLIF(Online_Security, ''), 'No') as Online_Security,
    ifnull(NULLIF(Online_Backup, ''), 'No') as Online_Backup,
    ifnull(NULLIF(Device_Protection_Plan, ''), 'No') as Device_Protection_Plan,
    ifnull(NULLIF(Premium_Support, ''), 'No') as Premium_Support,
    ifnull(NULLIF(Streaming_TV, ''), 'No') as Streaming_TV,
    ifnull(NULLIF(Streaming_Movies, ''), 'No') as Streaming_Movies,
    ifnull(NULLIF(Streaming_Music, ''), 'No') as Streaming_Music,
    ifnull(NULLIF(Unlimited_Data, ''), 'No') as Unlimited_Data,
    Contract,
    Paperless_Billing,
    Payment_Method,
    Monthly_Charge,
    Total_Charges,
    Total_Refunds,
    Total_Extra_Data_Charges,
    Total_Long_Distance_Charges,
    Total_Revenue,
    Customer_Status,
    ifnull(NULLIF(Churn_Category, ''), 'Others') as Churn_Category,
    ifnull(NULLIF(Churn_Reason, ''), 'Others') as Churn_Reason
FROM customer_churn_data;



 


                                                                                                                                                                               