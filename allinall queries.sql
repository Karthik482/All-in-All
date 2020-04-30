#simple queries
use allinall;

SHOW VARIABLES LIKE 'sql_mode';
set global sql_mode='';

#list out all names of customers with membership card in allinall

select c_name as membership_customer 
from customer c 
inner join membership m 
on c.customer_id=m.m_customer_id;


#list out customer names with no membership card

select c_name as non_membership_customer
from customer c 
inner join 
non_membership m 
on c.customer_id=m.non_customer_id;




#list out top 10 customer names and their address that purchased most number of products

select distinct(c.c_name), c.address,count(p.p_id) as number_of_products 
from customer c 
inner join selects s on c.customer_id=s.customer_id 
inner join products p on p.p_id=s.p_id 
group by p.p_id 
order by number_of_products 
desc
limit 10;




#list out which product category is purchased most 

select p_category,count(p_category) as number_of_products 
from customer c 
inner join selects s on c.customer_id=s.customer_id 
inner join products p on p.p_id=s.p_id 
group by p_category
order by number_of_products
desc;

# Check weather non-membership or membership customers spend more ?

select  round(sum(total_cost),0) as membership_customers from cart c inner join payment p on c.payment_id=p.payment_id
where p.m_id is not null;
select  round(sum(total_cost),0) as non_membership_customers from cart c inner join payment p on c.payment_id=p.payment_id
where p.m_id is  null;

#on average non members spend more that members?

select  round(avg(total_cost),0) as membership_customers from cart c inner join payment p on c.payment_id=p.payment_id
where p.m_id is not null;
select  round(avg(total_cost),0) as non_membership_customers from cart c inner join payment p on c.payment_id=p.payment_id
where p.m_id is  null;


# which customer has spent the most spendings in membership ? retrive address,name,spendings (only top 5)

select c.c_name,c.address,round(sum(ca.total_cost),0) as total_spending
from customer c 
inner join membership m on c.customer_id=m.m_customer_id
inner join payment p on p.m_id=m.m_id
inner join cart ca on ca.payment_id=p.payment_id
group by c.c_name
order by total_spending desc
limit 5; 


#which brand is most popular among grocery selected by customers?

select b.b_name,count(b.b_name) as quantity from selects s inner join products p on p.p_id=s.p_id
inner join has h on h.p_id=p.p_id
inner join brand b on b.b_id=h.b_id
where p_category='Grocery'
group by s.p_id
order by quantity 
desc;
select * from products;


#list out all the popular products among Grocery except for minimum?



select p.p_description,count(*) as total from selects s inner join products p on p.p_id=s.p_id
inner join has h on h.p_id=p.p_id
inner join brand b on b.b_id=h.b_id
where p_category='Grocery'
group by p.p_description
having total > any
                 (select count(*)
                 from products
                 group by p_description)
                 order by total desc;
                 
              
                 

# create a trigger to show decline message when anyone enters the price as zero for a product value.


DELIMITER $$
CREATE TRIGGER before_insert_price
    BEFORE INSERT ON products FOR EACH ROW
    BEGIN
        IF new.price <= 0 THEN
        SIGNAL SQLSTATE'45000'
        SET MESSAGE_TEXT ='PRICE CANT BE BELOW ZERO.';
        END IF;
        END;
        $$
        


            
insert into products(p_category,p_id,price,p_description) values('Clothing','#H219#','0','pepe M');









#  #  #  #   #  #  #  #  #  #  #  #   #   #                   R QUERIES                                      #  #  #  #  #  #  # # #   #####




#on which data most products were orderd 
select shipping_date,count(*) from shipping
group by shipping_date
order by count(*) desc ;

#on 2020-03-03 we had most sales. lets see how much profit we got on that day

select s.shipping_date,round(sum(c.total_cost),0) as total_amount from shipping s 
inner join cart c on c.order_id=s.order_id
where s.shipping_date="2020-03-03"
group by s.shipping_date; 

#on which date we had most sales?

select max(total_amount) as total,shipping_date
from
(select s.shipping_date,round(sum(c.total_cost),0) as total_amount from shipping s 
inner join cart c on c.order_id=s.order_id
group by s.shipping_date)t; 

#which payment method is most used 

select payment_type,count(payment_type) as total from payment
group by payment_type
order by total desc;

#suppose visa wants to do pramotion in shops to use their card and want to know how much total sales were done till now using visa card

select round(sum(total_cost),0) as net_sales
from payment p inner join cart c on p.payment_id=c.payment_id
where payment_type="visa";

# how does other payment types perform compared to visa

select payment_type,round(sum(total_cost),0) as net_sales
from payment p inner join cart c on p.payment_id=c.payment_id
where payment_type<>"visa"
group by payment_type
order by net_sales desc;

# at which shop most revenue happened 

select s.s_id,round(sum(c.total_cost),2) as net_revenue from selects s inner join added_to a on  s.p_id=a.p_id
inner join cart c on c.order_id=a.order_id
group by s.s_id
order by net_revenue desc; 






