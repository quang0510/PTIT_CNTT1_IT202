create database ex4;
use ex4;


create table products(
	product_id int primary key,
    product_name VARCHAR(255) NOT NULL,
    price DECIMAL(10,2),
    stock int,
    sold_quantity int,
    status ENUM('active','inactive')
);

insert into products (product_id, product_name, price, stock, sold_quantity, status) values
(1, 'Laptop Dell Inspiron', 15000000.00, 10, 5, 'active'),
(2, 'Laptop HP Pavilion', 16500000.00, 8, 3, 'active'),
(3, 'Laptop Asus Vivobook', 14000000.00, 12, 6, 'active'),
(4, 'MacBook Air M1', 23000000.00, 5, 4, 'active'),
(5, 'Chuột không dây Logitech', 350000.00, 50, 20, 'active'),
(6, 'Chuột gaming Razer', 1200000.00, 30, 12, 'active'),
(7, 'Bàn phím cơ Keychron K2', 2200000.00, 25, 10, 'active'),
(8, 'Bàn phím Logitech K380', 750000.00, 40, 18, 'active'),
(9, 'Màn hình Samsung 24 inch', 4200000.00, 15, 7, 'inactive'),
(10, 'Màn hình LG 27 inch', 5200000.00, 10, 5, 'active'),
(11, 'Tai nghe Sony WH-1000XM5', 8500000.00, 8, 6, 'active'),
(12, 'Tai nghe AirPods Pro', 6200000.00, 20, 14, 'active'),
(13, 'USB Kingston 64GB', 250000.00, 100, 60, 'active'),
(14, 'Ổ cứng SSD Samsung 1TB', 3200000.00, 18, 9, 'active'),
(15, 'Webcam Logitech C920', 2800000.00, 12, 4, 'inactive');

--  Lấy 10 sản phẩm bán chạy nhất
select * from products 
order by sold_quantity desc
limit 10;

-- Lấy 5 sản phẩm bán chạy tiếp theo (bỏ qua 10 sản phẩm đầu)
select * from products
order by sold_quantity desc
limit 5 offset 10;

-- Hiển thị danh sách sản phẩm giá < 2.000.000, sắp xếp theo số lượng bán giảm dần
select * from products
where price < 2000000
order by sold_quantity desc;















