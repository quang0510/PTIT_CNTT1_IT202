create database ex2;
use ex2;

create table customers (
	customer_id int auto_increment primary key,
    full_name varchar(255) not null,
    email varchar(255) unique,
    city varchar(255) ,
    status enum ('active' , 'inactive' )
);

insert into customers (customer_id, full_name, email, city, status) VALUES
(1, 'Nguyễn Văn An', 'an.nguyen@gmail.com', 'Hà Nội', 'active'),
(2, 'Trần Thị Bình', 'binh.tran@gmail.com', 'TP. Hồ Chí Minh', 'active'),
(3, 'Lê Hoàng Cường', 'cuong.le@gmail.com', 'Đà Nẵng', 'inactive'),
(4, 'Phạm Minh Đức', 'duc.pham@gmail.com', 'Cần Thơ', 'active'),
(5, 'Võ Thị Lan', 'lan.vo@gmail.com', 'Hải Phòng', 'inactive');

-- lấy danh sách tất cả khách hàng
select * from customers;

-- lấy ra khách hàng ở TP.HCM
select * from customers where city = 'TP. Hồ Chí Minh';

-- Lấy khách hàng đang hoạt động và ở Hà Nội
select * from customers 
where status = 'active ' and city = 'Hà Nội';

-- Sắp xếp danh sách khách hàng theo tên (A → Z)
select * from customers order by full_name asc;