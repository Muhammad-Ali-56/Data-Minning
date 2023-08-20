use mining_data;
#				Query 1:  Meta Data
show tables;
select project_data;
select * from project_data
limit 15;

#  				Query 2: What is the distribution of order values across all customers in the dataset?
select CustomerID, sum(Quantity * UnitPrice) as Total_Order_Value
from project_data
group by CustomerID
order by Total_Order_Value desc
limit 15;

#				Query 3: How many unique products has each customer purchased?
select CustomerID, count(distinct StockCode) as Unique_Product_Count
from project_data
group by CustomerID
order by 2 desc
limit 15;

#				Query 4: Which customers have only made a single purchase from the company?
select CustomerID, count(distinct InvoiceNo) as Number_Of_Purchases
from project_data
group by CustomerID
having Number_Of_Purchases = 1
order by Number_Of_purchases
limit 10;

# 				Query 5: Which products are most commonly purchased together by customers in the dataset?
select t1.CustomerID, t1.InvoiceNo, t1.StockCode as Product_1, t2.StockCode as Product_2, count(*) as Frequency
from project_data as t1
join project_data as t2 on t1.InvoiceNo=t2.InvoiceNo and t1.StockCode < t2.StockCode
group by Product_1, Product_2, InvoiceNO, CustomerID
order by Frequency desc
limit 10;

# 							ADVANCE QUEIRIES

#				        1.      Customer Segmentation by Purchase Frequency
select CustomerID,
       case
          when count(distinct InvoiceDate) > 10 then 'High'
          when count(distinct InvoiceDate) > 5 then 'Medium'
          else 'Low'
       end as  Purchase_Frequency
from project_data
group by CustomerID
order by Purchase_Frequency desc
limit 15;

#					 2. Average Order Value by Country
select Country, avg(Quantity * UnitPrice) as Avarage_Order_Value
from project_data
group by Country;

#					 3. Customer Churn Analysis
select CustomerID
from project_data
where InvoiceDate <= date_sub(now(), interval 6 month)
group by CustomerID
limit 15;

# 				         4. Product Affinity Analysis
select t1.CustomerID, t1.InvoiceNo, t1.StockCode as Product_1, t2.StockCode as Product_2, count(*) as Frequency
from project_data as t1
join project_data as t2 on t1.InvoiceNo=t2.InvoiceNo and t1.StockCode < t2.StockCode
group by Product_1, Product_2, InvoiceNO, CustomerID
order by Frequency desc
limit 10;

#						 5. Time-based Analysis
select date_format(InvoiceDate,'_d-_m-_y-_h-_m') as Month_,
       count(distinct CustomerID) as Unique_Customers,
       sum(Quantity * UnitPrice) as Total_Revenue
from project_data
group by Month_
order by Month_;

