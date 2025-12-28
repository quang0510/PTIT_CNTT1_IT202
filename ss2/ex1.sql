create database ss2;
use ss2;

create table class(
	class_id int auto_increment primary key ,
    class_name varchar(50),
    class_year year
);

create table student(
	student_id int auto_increment primary key, 
    student_name varchar(50),
    student_dateofBirth date,
    class_id int not null,
    foreign key (class_id) references class(class_id)
);

select * from classl;
select * from student