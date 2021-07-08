use supermarketsalesdb;
####Query 1

#Some retailers believe that there is more money to be
# made in selling fashion accessories to men 
#than sports and travel to women.Is this true?

select sum(case when c.gender = 'Male' and p.`Product line` like '%Fashion Accessories%' 
then rd.`Gross income` end ) as Men_Fashion_Accessories_Revenue,
sum(case when c.gender = 'Female' and p.`Product line` like '%Sports and Travel%' 
then rd.`Gross income` end) as Women_Sports_and_Travel_Revenue
from Customers as c
join customer_ratings as cr
on c.`Customer ID` = cr.`Customer ID`
join revenue_details as rd
on cr.`Invoice ID`  = rd.`Invoice ID`
join invoices as i
on rd.`Invoice ID`  = i.`Invoice ID`
join products as p
on i.`Product ID` = p.`Product ID`;

####Query 2
#Some retailers believe that revenue in food and 
#beverages can be increased amongst women by focusing 
#on Ewallets, while others believe eWallets are 
#more popular with men buying electronic accessories. Who is right?

select i.payment, sum(case when p.`Product line` like '%Food and Beverages%' 
and c.gender like '%Female%'then rd.`Gross income` end ) as Food_and_Beverages_Women_Revenue,
sum(case when p.`Product line` like '%Electronic Accessories%' 
and c.gender like '%Male%'then rd.`Gross income` end) as Electronic_Accessories_Men_Revenue,
count(case when p.`Product line` like '%Food and Beverages%' 
and c.gender like '%Female%'then i.payment end ) as Food_and_Beverages_Women_Count,
count(case when p.`Product line` ='Electronic Accessories' 
and c.gender = 'Male'then i.payment end) as Electronic_Accessories_Men_Count
from Customers as c
join customer_ratings as cr
on c.`Customer ID` = cr.`Customer ID`
join revenue_details as rd
on cr.`Invoice ID`  = rd.`Invoice ID`
join invoices as i
on rd.`Invoice ID`  = i.`Invoice ID`
join products as p
on i.`Product ID` = p.`Product ID`
group by i.Payment;


####QUERY 3
#Some retailers believe payment method is a bigger 
#indicator of health and beauty purchases while other retailers
# believe gender is a bigger factor. Who is right?
select distinct i.payment as Factor, count(i.payment) as Healht_and_Beauty_Count
from invoices as i
join products as p
on i.`Product ID` = p.`Product ID`
where p.`Product Line` like '%Health and Beauty%'
group by `Payment`
union
select "--", "--"
union
select distinct c.Gender as Factor, count(c.Gender) as Healht_and_Beauty_Count
from customers as c
join `customer_ratings` as cr
on c.`Customer ID` = cr.`Customer ID`
join invoices as i
on cr.`Invoice ID` = i.`Invoice ID`
join products as p
on i.`Product ID` = p.`Product ID`
where p.`Product Line` like '%Health and Beauty%'
group by `Gender` ;



###QUERY 4
#Some retailers believe that their members are spending more per 
#purchase while members believe they are spending less per purchase. 
#Who is right?
select avg(case when c.`Customer Type` = 'Member' 
then i.Total end) as Avg_Members_Spending,
avg(case when c.`Customer Type` = 'Normal' 
then i.Total end) as Avg_Non_Members_Spending
from Customers as c
join customer_ratings as cr
on c.`Customer ID` = cr.`Customer ID`
join revenue_details as rd
on cr.`Invoice ID`  = rd.`Invoice ID`
join invoices as i
on rd.`Invoice ID`  = i.`Invoice ID`
join products as p
on i.`Product ID` = p.`Product ID`;



####Query 5
#Some retailers believe that their male members 
#are bringing in more overall revenue per purchase 
#while others believe female non-members are bringing in more 
#revenue per purchase of fashion accessories. Who is right?


select  sum(case when p.`Product line` like '%Fashion Accessories%' 
and c.`Customer Type` like '%Member%' and c.gender = 'Male' then i.Total end ) as Male_Fashion_Accessories_Revenue_Member,
avg(case when p.`Product line` like '%Fashion Accessories%' 
and c.`Customer Type` like '%Member%' and c.gender = 'Male' then i.Total end ) as Avg_Male_Fashion_Accessories_Revenue_Member,
sum(case when p.`Product line` like '%Fashion Accessories%' 
and c.`Customer Type` like '%Normal%' and c.gender = 'Female' then i.Total end ) as Female_Fashion_Accessories_Revenue_Normal,
avg(case when p.`Product line` like '%Fashion Accessories%' 
and c.`Customer Type` like '%Normal%' and c.gender = 'Female' then i.Total end ) as AVG_Fashion_Accessories_Revenue_Normal
from Customers as c
join customer_ratings as cr
on c.`Customer ID` = cr.`Customer ID`
join revenue_details as rd
on cr.`Invoice ID`  = rd.`Invoice ID`
join invoices as i
on rd.`Invoice ID`  = i.`Invoice ID`
join products as p
on i.`Product ID` = p.`Product ID`;



####Query 7
#Yangon calls itself the most eWallet-friendly city for health 
#and beauty while Mandalay calls itself a haven for cash spending. 
#Does the data support their claims?

#TODO --- Add sum total and profit

select i.payment as Payment_Type, count(case when s.city like '%Mandalay%'  and p.`Product Line` = 'Health and Beauty' then s.city end) as Mandalay_Count,
count(case when s.city like '%Yangon%'and p.`Product Line` = 'Health and Beauty' then s.city end) as Yangon_Count
from stores as s
join invoices as i
on s.branch = i.branch
join products as p
on i.`Product ID` = p.`Product ID`
group by i.payment;


