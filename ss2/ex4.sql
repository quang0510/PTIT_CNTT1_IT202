create database ex4;
use ex4;

create table teacher(
	teacher_id int auto_increment primary key,
    teacher_name varchar(50) not null,
    email varchar(50) unique
);

create table subject(
	subject_id int auto_increment,
    subeject_name varchar(50) not null,
    teacher_id int ,
    foreign key (teacher_id ) references teacher(teacher_id)
);