create database ex3;
use ex3;

create table orders(
	order_id int auto_increment primary key,
    customer_id int ,
    order_date date,
    total_amount decimal(10,2) , 
    status enum('pending', 'completed','cancelled')
); 

insert into orders (order_id, customer_id, order_date, status) values
(1, 1, '2025-01-05', 'completed'),
(2, 2, '2025-01-06', 'completed'),
(3, 3, '2025-01-07', 'cancelled'),
(4, 1, '2025-01-08', 'completed'),
(5, 4, '2025-01-09', 'pending');

-- Viết SQL các câu lệnh DML:
	-- Sửa lại thông tin dữ liệu trong bảng thêm dữ liệu cho mỗi orders có thêm dữ liệu của trường dữ liệu ở cột total_amount
update orders
set total_amount = 1500000
where order_id = 1;

update orders
set total_amount = 2500000
where order_id = 2;

update orders
set total_amount = 3500000
where order_id = 3;

update orders
set total_amount = 4500000
where order_id = 4;

update orders
set total_amount = 5500000
where order_id = 5;

-- Tính tổng doanh thu theo từng ngày
select order_date , sum(total_amount) as total_day from orders
where status = 'completed'
group by order_date;
-- Tính số lượng đơn hàng theo từng ngày
select order_date , count(order_id) as order_day from orders
where status = 'completed'
group by order_date;

-- Chỉ hiển thị các ngày có doanh thu > 10.000.000
select order_date , sum(total_amount) as total_day from orders 
where status = 'completed' 
group by order_date
having sum(total_amount) > 10000000
