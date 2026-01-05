create database ex2;
use ex2;

create table customers(
	customer_id int auto_increment primary key,
    full_name varchar(255) ,
    city varchar(255)
);

create table orders(
	order_id int auto_increment primary key,
    customer_id int ,
    order_date date,
    total_amount decimal(10,2) , 
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

-- Viết SQL truy vấn:
	-- Hiển thị tổng tiền mà mỗi khách hàng đã chi tiêu
select c.full_name , sum(o.total_amount) as total_spent from customers c
join orders o on c.customer_id = o.customer_id
where status = 'completed'
group by c.full_name;

	-- Hiển thị giá trị đơn hàng cao nhất của từng khách
select c.full_name , max(o.total_amount) as max_order from customers c
join orders o on c.customer_id = o.customer_id
where status = 'completed'
group by c.full_name;

	-- Sắp xếp danh sách khách hàng theo tổng tiền giảm dần
select c.full_name , sum(o.total_amount) as total_spent from customers c
join orders o on c.customer_id = o.customer_id
where status = 'completed'
group by c.full_name
order by total_spent desc;

    
    
    