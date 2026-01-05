create database ex6;
use ex6;

create table products(
	product_id int auto_increment primary key,
    product_name varchar(255),
    price decimal(10,2) 
);

create table order_items (
	order_id  int auto_increment primary key,
    product_id int ,
    quantity int,
    foreign key (product_id) references products(product_id)
);

insert into products (product_id, product_name, price) values
(1, 'Bàn học', 1500000),
(2, 'Ghế xoay', 1200000),
(3, 'Laptop', 18000000),
(4, 'Chuột không dây', 350000),
(5, 'Bàn phím cơ', 950000);

insert into order_items (order_id, product_id, quantity) values
(1, 1, 2),
(2, 2, 1),
(3, 3, 1),
(4, 4, 3),
(5, 5, 2);

-- Viết câu SQL truy vấn thỏa mãn các điều kiện sau:
	-- Hiển thị:
		-- Tên sản phẩm
		-- Tổng số lượng bán
		-- Tổng doanh thu
		-- Giá bán trung bình
	-- Chỉ hiển thị sản phẩm:
		-- Đã bán ít nhất 10 sản phẩm
	-- Sắp xếp theo:
		-- Doanh thu giảm dần
	-- Chỉ lấy 5 sản phẩm đứng đầu
select p.product_name , sum(o.quantity) as total_sold , sum(o.quantity * p.price) as total_revenue , avg(p.price) as avg_price from products p 
join order_items o on p.product_id = o.product_id
group by  p.product_name 
having sum(o.quantity) >= 10 
order by total_revenue desc
limit 5 ;










