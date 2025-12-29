create database ss3_ex1;
use ss3_ex1;

create table student (
	student_id int auto_increment primary key,
    full_name varchar(30) not null,
    date_of_birth date not null,
    email varchar(50) unique not null
); 

insert into student (full_name, date_of_birth ,email ) values 
('Nguyen Dang Quang` ', '1-1-2025' , 'ndq@gmail.com'),
('Nguyen Dang Quang2 ', '2-1-2025' , 'ndq2@gmail.com'),
('Nguyen Dang Quang3 ', '3-1-2025' , 'ndq3@gmail.com');

SELECT * FROM student;
SELECT student_id, full_name FROM student;
