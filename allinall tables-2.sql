use allinall2;

CREATE TABLE customer (
customer_id INT NOT NULL UNIQUE PRIMARY KEY,
c_name VARCHAR(20) NOT NULL,
address VARCHAR(25) NOT NULL,
zipcode INT NOT NULL,
email_id VARCHAR(30) UNIQUE,
ph_no INT NOT NULL UNIQUE
);


CREATE TABLE non_membership(
non_customer_id INT NOT NULL,
FOREIGN KEY (non_customer_id) references customer(customer_id)
);


CREATE TABLE membership(
m_customer_id INT NOT NULL,
m_id INT NOT NULL PRIMARY KEY,
reward_points INT,
foreign key (m_customer_id) references customer(customer_id)
);





CREATE TABLE payment (
payment_id DOUBLE NOT NULL PRIMARY KEY ,
payment_type VARCHAR(20),
m_id INT ,
FOREIGN KEY (m_id) REFERENCES membership(m_id)
);







CREATE TABLE cart(
payment_id DOUBLE UNIQUE NOT NULL,
order_id VARCHAR (30) PRIMARY KEY NOT NULL,
total_cost FLOAT NOT NULL,
FOREIGN KEY (payment_id) REFERENCES payment(payment_id)
);

CREATE TABLE shipping(
tracking_id VARCHAR(30)  NOT NULL,
shipping_date Date,
shipper_ph BIGINT,
order_id VARCHAR(30),
FOREIGN KEY (order_id) REFERENCES cart(order_id)
);
select * from shipping;



CREATE TABLE shop(
s_id INT NOT NULL PRIMARY KEY,
s_address VARCHAR(20) NOT NULL,
s_ph BIGINT NOT NULL,
s_zipcode INT NOT NULL
);
select * from shop;
CREATE TABLE products(
p_category VARCHAR(20),
p_id VARCHAR(15) PRIMARY KEY,
price FLOAT,
p_description TEXT
);


CREATE TABLE stock(
st_id INT PRIMARY KEY,
st_category VARCHAR(10),
st_quantity INT,
p_id VARCHAR(15),
FOREIGN KEY(p_id) references products(p_id)
);



select p_id from products;

select s_id from shop; 

CREATE TABLE brand(
b_name VARCHAR(20) NOT NULL,
b_id VARCHAR(20) PRIMARY KEY NOT NULL
);






CREATE TABLE selects (
customer_id INT NOT NULL,
p_id VARCHAR(15) NOT NULL,
s_id INT NOT NULL,
FOREIGN KEY(customer_id) references customer(customer_id), 
FOREIGN KEY(p_id) references products(p_id),
FOREIGN KEY(s_id) references shop(s_id)
);
select * from selects;


CREATE TABLE stock_added_to(
s_id INT NOT NULL,
st_id INT NOT NULL,
p_id VARCHAR(15) NOT NULL,
foreign key(p_id) references products(p_id),
foreign key(st_id) references stock(st_id),
foreign key(s_id) references shop(s_id)
);


CREATE TABLE admininstrator (
a_id INT NOT NULL,
a_name VARCHAR(20) NOT NULL
);


CREATE TABLE adds(
st_id INT NOT NULL,
a_id INT NOT NULL
);

CREATE TABLE has(
p_id VARCHAR(15),
b_id varchar(20),
foreign key(p_id) references products(p_id),
foreign key(b_id) references brand(b_id)
);



ALTER TABLE customer modify COLUMN address VARCHAR (100) ;
ALTER TABLE customer modify COLUMN zipcode VARCHAR (20) ;
ALTER TABLE customer modify COLUMN email_id VARCHAR (80) ;
ALTER TABLE customer modify COLUMN c_name VARCHAR(30);
