create database ex1;
use ex1;

create table customers(
	customer_id int auto_increment primary key,
    full_name varchar(255) ,
    city varchar(255)
);

create table orders(
	order_id int auto_increment primary key,
    customer_id int ,
    order_date date,
    status enum('pending', 'completed','cancelled')
); 
    
-- Thêm dữ liệu vào bảng customers tối thiếu 5 dữ liệu
insert into customers (customer_id, full_name, city) values 
(1, 'Nguyễn Đăng Quang', 'Hà Nội'),
(2, 'Trần Văn Minh', 'Hải Phòng'),
(3, 'Lê Thị Hồng', 'Đà Nẵng'),
(4, 'Phạm Quốc Anh', 'TP Hồ Chí Minh'),
(5, 'Vũ Thu Trang', 'Cần Thơ');

-- Thêm dữ liệu vào bảng orders tối thiểu 5 dữ liệu
insert into orders (order_id, customer_id, order_date, status) values
(1, 1, '2025-01-05', 'completed'),
(2, 2, '2025-01-06', 'pending'),
(3, 3, '2025-01-07', 'cancelled'),
(4, 1, '2025-01-08', 'completed'),
(5, 4, '2025-01-09', 'pending');

select * from customers;
select * from orders;

-- Hiển thị danh sách đơn hàng kèm tên khách hàng
select o.order_id , c.full_name from orders o
join customers c on o.customer_id = c.customer_id;

-- Hiển thị mỗi khách hàng đã đặt bao nhiêu đơn hàng
select c.customer_id, c.full_name, count(o.order_id) as 'Tổng số đơn hàng'
from customers c
left join orders o on c.customer_id = o.customer_id
group by c.customer_id;

-- Chỉ hiển thị các khách hàng có ít nhất 1 đơn hàng
select c.customer_id, c.full_name, count(*) as 'Tổng số đơn hàng'
from customers c
join orders o on c.customer_id = o.customer_id
group by c.customer_id;


