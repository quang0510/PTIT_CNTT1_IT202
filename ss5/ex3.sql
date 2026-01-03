create database ex3;
use ex3;

create table orders (
	order_id int ,
    customer_id int ,
    total_amount decimal(10,2) ,
    order_date date,
    status enum('pending' , 'completed' , 'cancelled')
);

insert into orders (order_id, customer_id, total_amount, order_date, status) VALUES
(1, 1, 5500000.00, '2025-01-05', 'completed'),
(2, 2, 1800000.00, '2025-01-06', 'pending'),
(3, 3, 3200000.00, '2025-01-10', 'cancelled'),
(4, 1, 1500000.00, '2025-01-08', 'completed'),
(5, 4, 4200000.00, '2025-01-09', 'pending'),
(6, 4, 4200000.00, '2025-01-07', 'pending');

-- Lấy danh sách đơn hàng đã hoàn thành
select * from orders where status = 'completed';

-- Lấy các đơn hàng có tổng tiền > 5.000.000
select * from orders where total_amount > 5000000;

-- Hiển thị 5 đơn hàng mới nhất
select * from orders
order by  order_date desc
limit 5;
-- Hiển thị các đơn hàng đã hoàn thành, sắp xếp theo tổng tiền giảm dần
select * from orders
where status = 'completed' 
order by total_amount desc;