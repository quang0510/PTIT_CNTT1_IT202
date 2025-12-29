create database ss3_ex2;

use ss3_ex2;

create table Student (
	student_id int primary key,
    full_name varchar(30) not null,
    date_of_birth date,
    email varchar(50) not null
);


insert into student (student_id, full_name,date_of_birth, email)values 
(3,'quang','2002-10-15','quang@gmail.com'),
(2,'huy','2002-10-15','huy@gmail.com') ,
(5,'le','2002-10-15','le@gmail.com') 
 ;
 
select * from student;
select student_id , full_name from student;

update student set email = 'abcd@gmail.com'
where student_id = 3;

update student  set date_of_birth = '1999-09-09'
where student_id = 2;

delete from student where student_id = 5;