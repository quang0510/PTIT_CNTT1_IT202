create database ex5;
use ex5;

create table customers(
	id int auto_increment primary key,
    name varchar(255) ,
    email varchar(255) unique
);

create table orders(
	id int ,
    customer_id int ,
    order_date date,
    total_amount decimal(10,2) check (total_amount > 0)
);

insert into customers (name, email) values
('Nguyễn Văn A', 'a@gmail.com'),
('Trần Văn B', 'b@gmail.com'),
('Lê Văn C', 'c@gmail.com'),
('Phạm Văn D', 'd@gmail.com'),
('Hoàng Văn E', 'e@gmail.com'),
('Võ Văn F', 'f@gmail.com'),
('Đặng Văn G', 'g@gmail.com');

insert into orders (id, customer_id, order_date, total_amount) values
(1, 1, '2024-08-01', 500000),
(2, 1, '2024-08-05', 700000),
(3, 2, '2024-08-03', 300000),
(4, 3, '2024-08-10', 900000),
(5, 3, '2024-08-15', 600000),
(6, 5, '2024-08-20', 400000),
(7, 7, '2024-08-25', 800000);

select id, name from customers
where id = (select customer_id from orders
			group by customer_id
			having SUM(total_amount) = (select max(total_spent) from (
            select SUM(total_amount) as total_spent from orders
            group by customer_id
        ) as temp
    )
);





