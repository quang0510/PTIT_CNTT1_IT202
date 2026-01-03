create database ex1;
use ex1;

create table Products(
	product_id int auto_increment primary key,
    product_name varchar(255) ,
    price decimal(10,2) ,
    stock int ,
    status enum('active' , 'inactive' )
);

INSERT INTO products (product_id, product_name, price, stock, status) VALUES
(1, 'Laptop Dell Inspiron', 15000000.00, 10, 'active'),
(2, 'Chuột không dây Logitech', 350000.00, 50, 'active'),
(3, 'Bàn phím cơ Keychron', 2200000.00, 20, 'active'),
(4, 'Màn hình Samsung 24 inch', 4200000.00, 15, 'inactive'),
(5, 'Tai nghe Sony WH-1000XM5', 8500000.00, 8, 'active');

-- lấy ra toàn bộ sản phẩm
select * from Products;

-- lấy ra sản phẩm đang bán ( active ) 
select * from Products where status = 'active';

-- lấy các sản phẩm có giá lớn hơn 1.000.000
select * from Products where price > 1000000;

-- Hiển thị danh sách sản phẩm đang bán, sắp xếp theo giá tăng dần
select * from Products
where status = 'active' 
order by price asc;
