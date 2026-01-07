create database ss8;
use ss8;

create table customers (
	customer_id int auto_increment primary key,
    customer_name varchar(100) not null,
    email varchar(100) not null unique,
    phone varchar(100) not null unique
);

create table categories (
	category_id int auto_increment primary key,
    category_name varchar(255) not null unique
);

create table products (
	product_id int auto_increment primary key,
    product_name varchar(255) not null unique,
    price decimal(10,2) not null check(price > 0), 
    category_id int not null,
    foreign key (category_id) references categories(category_id)
);

create table orders (
	order_id int auto_increment primary key,
    customer_id int not null,
    order_date datetime default (current_date()),
    status enum ('pending' , 'completed' , 'cancel') default 'Pending'
);

create table order_items (
	order_item_id int auto_increment primary key,
    order_id int ,
    product_id int,
    quantity int not null check(quantity > 0),
    foreign key (order_id) references orders(order_id),
    foreign key (product_id) references products(product_id)
);

insert into customers (customer_name, email, phone) values
('Nguyễn Văn A', 'a@gmail.com', '0901111111'),
('Trần Văn B', 'b@gmail.com', '0902222222'),
('Lê Văn C', 'c@gmail.com', '0903333333'),
('Phạm Thị D', 'd@gmail.com', '0904444444'),
('Hoàng Văn E', 'e@gmail.com', '0905555555'),
('Đỗ Văn F', 'f@gmail.com', '0906666666'),
('Bùi Thị G', 'g@gmail.com', '0907777777'),
('Vũ Văn H', 'h@gmail.com', '0908888888'),
('Ngô Thị I', 'i@gmail.com', '0909999999'),
('Phan Văn K', 'k@gmail.com', '0910000000');

insert into categories (category_name) values
('Điện thoại'),
('Laptop'),
('Phụ kiện'),
('Đồ gia dụng'),
('Thời trang'),
('Mỹ phẩm'),
('Sách'),
('Thể thao'),
('Nội thất'),
('Đồ chơi');

insert into products (product_name, price, category_id) values
('iPhone 15', 25000000, 1),
('Samsung S23', 20000000, 1),
('MacBook Air M2', 30000000, 2),
('Laptop Dell XPS', 28000000, 2),
('Chuột Logitech', 500000, 3),
('Tai nghe Sony', 1500000, 3),
('Nồi chiên không dầu', 2500000, 4),
('Áo thun nam', 250000, 5),
('Son môi Dior', 900000, 6),
('Bóng đá Adidas', 600000, 8);

insert into orders (customer_id, order_date, status) values
(1, '2024-08-01 09:00:00', 'pending'),
(2, '2024-08-02 10:00:00', 'completed'),
(3, '2024-08-03 11:00:00', 'pending'),
(4, '2024-08-04 12:00:00', 'cancel'),
(5, '2024-08-05 13:00:00', 'completed'),
(6, '2024-08-06 14:00:00', 'pending'),
(7, '2024-08-07 15:00:00', 'completed'),
(8, '2024-08-08 16:00:00', 'pending'),
(9, '2024-08-09 17:00:00', 'cancel'),
(10, '2024-08-10 18:00:00', 'completed');

insert into order_items (order_id, product_id, quantity) values
(1, 1, 1),
(1, 5, 2),
(2, 3, 1),
(2, 6, 1),
(3, 8, 3),
(4, 7, 1),
(5, 2, 2),
(6, 9, 1),
(7, 10, 4),
(10, 4, 1);


-- PHẦN A – TRUY VẤN DỮ LIỆU CƠ BẢN
	-- Lấy danh sách tất cả danh mục sản phẩm trong hệ thống
select * from products;
	-- Lấy danh sách đơn hàng có trạng thái là COMPLETED
select * from orders
where status = 'completed';
	-- Lấy danh sách sản phẩm và sắp xếp theo giá giảm dần
select product_id , product_name ,  price from products
order by price desc;

	-- Lấy 5 sản phẩm có giá cao nhất, bỏ qua 2 sản phẩm đầu tiên
select product_id , product_name ,  price from products 
order by price desc
limit 5 offset 2;

-- PHẦN B – TRUY VẤN NÂNG CAO
	-- Lấy danh sách sản phẩm kèm tên danh mục
select p.product_name , p.price , c.category_name from products p 
join categories c on p.category_id = c.category_id;

	-- Lấy danh sách đơn hàng
select o.order_id , o.order_date , c.customer_name , o.status from orders o
join customers c on o.customer_id = c.customer_id;

	-- Tính tổng số lượng sản phẩm trong từng đơn hàng
select o.order_id , sum(oi.quantity) as total_quantity from orders o
join order_items oi on o.order_id = oi.order_id
group by o.order_id;

	-- Thống kê số đơn hàng của mỗi khách hàng
select c.customer_id , c.customer_name , count(o.order_id) as 'số đơn hàng'  from orders o
join customers c on o.customer_id =  c.customer_id
group by c.customer_id;

	-- Lấy danh sách khách hàng có tổng số đơn hàng ≥ 2
select c.customer_id , c.customer_name , count(o.order_id) as 'số đơn hàng'  from orders o
join customers c on o.customer_id =  c.customer_id
group by c.customer_id
having count(o.order_id) >= 2 ;
    
	-- Thống kê giá trung bình, thấp nhất và cao nhất của sản phẩm theo danh mục
select c.category_name, avg(p.price) as avg_price, min(p.price) as min_price, max(p.price) as max_price from categories c
join products p on c.category_id = p.category_id
group by c.category_name;

-- PHẦN C – TRUY VẤN LỒNG (SUBQUERY)
	-- Lấy danh sách sản phẩm có giá cao hơn giá trung bình của tất cả sản phẩm
select * from products 
where price > (select avg(price) from products);

	-- Lấy danh sách khách hàng đã từng đặt ít nhất một đơn hàng
select * from customers
where customer_id in (select distinct customer_id from orders);
	-- Lấy đơn hàng có tổng số lượng sản phẩm lớn nhất.
    
select order_id, sum(quantity) as total_quantity from order_items
group by order_id
having sum(quantity) = (select max(total_qty) from (select sum(quantity) as total_qty from order_items group by order_id) as temp);

	-- Lấy tên khách hàng đã mua sản phẩm thuộc danh mục có giá trung bình cao nhất

select customer_name from customers 
where customer_id in
(select customer_id from orders 
where order_id in
(select order_id from order_items
where product_id in
(select product_id from products 
where category_id in
(select category_id from products
group by category_id
having avg(price) =
(select max(avg_price) from
(select avg(price) as avg_price from products
group by category_id) as max_avg)))));

	-- Từ bảng tạm (subquery), thống kê tổng số lượng sản phẩm đã mua của từng khách hàng
select c.customer_id, c.customer_name, ( select sum(quantity) from order_items
										 where order_id in ( select order_id from orders
																where customer_id = c.customer_id)
										) as total_quantity
from customers c;


	-- Viết lại truy vấn lấy sản phẩm có giá cao nhất, đảm bảo:
		-- Subquery chỉ trả về một giá trị
		-- Không gây lỗi “Subquery returns more than 1 row”
select * from products
where price = (select max(price) from products);












