CREATE DATABASE StudentDB;

USE StudentDB;
-- 1. Bảng Khoa
CREATE TABLE Department (
    DeptID CHAR(5) PRIMARY KEY,
    DeptName VARCHAR(50) NOT NULL
);

-- 2. Bảng SinhVien
CREATE TABLE Student (
    StudentID CHAR(6) PRIMARY KEY,
    FullName VARCHAR(50),
    Gender VARCHAR(10),
    BirthDate DATE,
    DeptID CHAR(5),
    FOREIGN KEY (DeptID) REFERENCES Department(DeptID)
);

-- 3. Bảng MonHoc
CREATE TABLE Course (
    CourseID CHAR(6) PRIMARY KEY,
    CourseName VARCHAR(50),
    Credits INT
);

-- 4. Bảng DangKy
CREATE TABLE Enrollment (
    StudentID CHAR(6),
    CourseID CHAR(6),
    Score FLOAT,
    PRIMARY KEY (StudentID, CourseID),
    FOREIGN KEY (StudentID) REFERENCES Student(StudentID),
    FOREIGN KEY (CourseID) REFERENCES Course(CourseID)
);
INSERT INTO Department VALUES
('IT','Information Technology'),
('BA','Business Administration'),
('ACC','Accounting');

INSERT INTO Student VALUES
('S00001','Nguyen An','Male','2003-05-10','IT'),
('S00002','Tran Binh','Male','2003-06-15','IT'),
('S00003','Le Hoa','Female','2003-08-20','BA'),
('S00004','Pham Minh','Male','2002-12-12','ACC'),
('S00005','Vo Lan','Female','2003-03-01','IT'),
('S00006','Do Hung','Male','2002-11-11','BA'),
('S00007','Nguyen Mai','Female','2003-07-07','ACC'),
('S00008','Tran Phuc','Male','2003-09-09','IT');

INSERT INTO Course VALUES
('C00001','Database Systems',3),
('C00002','C Programming',3),
('C00003','Microeconomics',2),
('C00004','Financial Accounting',3);

INSERT INTO Enrollment VALUES
('S00001','C00001',8.5),
('S00001','C00002',7.0),
('S00002','C00001',6.5),
('S00003','C00003',7.5),
('S00004','C00004',8.0),
('S00005','C00001',9.0),
('S00006','C00003',6.0),
('S00007','C00004',7.0),
('S00008','C00001',5.5),
('S00008','C00002',6.5);

-- PHẦN A – CƠ BẢN
	-- Câu 1:  Tạo View View_StudentBasic hiển thị: StudentID, FullName , DeptName. Sau đó truy vấn toàn bộ View_StudentBasic;
create or replace view View_StudentBasic 
as
select s.StudentID , s.FullName , d.DeptName from Student s
join Department d on s.DeptID = d.DeptID;

select * from View_StudentBasic;

	-- Câu 2: Tạo Regular Index cho cột FullName của bảng Student.
create index index_fullName on Student(FullName);

	-- câu 3 : Viết Stored Procedure GetStudentsIT
		-- Không có tham số
		-- Chức năng: hiển thị toàn bộ sinh viên thuộc khoa Information Technology trong bảng Student + DeptName từ bảng Department.
		-- Gọi đến procedue GetStudentsIT.
delimiter // 
create procedure GetStudentsIT ()
begin
	select * from Student 
    where DeptID = 'IT';
end //
delimiter ;

call GetStudentsIT();

-- Phần B : khá

-- câu 4 : 
-- a) Tạo View View_StudentCountByDept hiển thị: DeptName, TotalStudents (số sinh viên mỗi khoa).
create or replace view View_StudentCountByDept 
as
select d.DeptName , count(s.StudentID) as TotalStudents from Department d
join Student s on d.DeptID = s.DeptID
group by d.DeptName;

-- b) Từ View trên, viết truy vấn hiển thị khoa có nhiều sinh viên nhất.
select * from View_StudentCountByDept
where TotalStudents = (select max(TotalStudents) 
					from View_StudentCountByDept );

-- câu 5 : 
-- a) Viết Stored Procedure GetTopScoreStudent
	-- Tham số: IN p_CourseID
	-- Chức năng: Hiển thị sinh viên có điểm cao nhất trong môn học được truyền vào. 
delimiter //

create procedure GetTopScoreStudent(in p_CourseID char(6))
begin
    select s.StudentID,s.FullName,c.CourseName,e.Score
    from Enrollment e
    join Student s on e.StudentID = s.StudentID
    join Course c on e.CourseID = c.CourseID
    where e.CourseID = p_CourseID
		  and e.Score = (
          select max(Score) from Enrollment
          where CourseID = p_CourseID
      );
end //

delimiter ;


-- b)  Gọi thủ tục trên để tìm sinh viên có điểm cao nhất môn Database Systems (C00001).

call GetTopScoreStudent('C00002');


-- PHẦN C – GIỎI 

-- câu 6: Nhà trường muốn quản lý việc cập nhật điểm cho môn Database Systems (C00001) theo quy tắc:
	-- Chỉ cho phép cập nhật điểm cho sinh viên thuộc khoa IT.
	-- Nếu điểm mới > 10 → tự động gán = 10.
	-- Việc cập nhật phải thực hiện thông qua Stored Procedure
    -- Dữ liệu cập nhật phải đảm bảo không vi phạm điều kiện của View.
    
-- a) Tạo VIEW
	-- Tạo View View_IT_Enrollment_DB
	-- Hiển thị các sinh viên: Thuộc khoa IT , Đăng ký môn C00001
	-- View phải có WITH CHECK OPTION.

create or replace view 



