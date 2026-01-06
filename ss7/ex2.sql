create database ex2;
use ex2;

create table products(
	id int auto_increment primary key,
    name varchar(50) not null,
    price decimal(10,2) 
);

create table order_items(
	order_id int,
    product_id int,
    quantity int
);

insert into products (name, price) values
('Laptop Dell', 15000000),
('Chuột Logitech', 500000),
('Bàn phím cơ', 1200000),
('Màn hình Samsung', 3500000),
('Tai nghe Sony', 2000000),
('Ổ cứng SSD', 1800000);

insert into order_items (order_id, product_id, quantity) values
(1, 1, 1),
(1, 2, 2),
(2, 3, 1),
(3, 1, 1),
(3, 4, 1),
(4, 6, 2);

select id , name , price from products 
where id in(select distinct product_id from order_items);
