create database ex2_ss13;
use ex2_ss13;

create table users (
	user_id int auto_increment primary key,
    username varchar(50) not null unique,
    email varchar(50) not null unique,
    created_at date,
    follower_count int default 0,
    post_count int default 0
);

create table posts(
	post_id int auto_increment primary key,
    user_id int ,
    content text,
    created_at datetime,
    like_count int default 0,
    foreign key (user_id) references users(user_id)
);

create table likes (
	like_id int auto_increment primary key,
    user_id int ,
    post_id int ,
    liked_at datetime ,
	foreign key (user_id) references users(user_id),
    foreign key (post_id) references posts(post_id)
);

INSERT INTO users (username, email, created_at) VALUES
('alice', 'alice@example.com', '2025-01-01'),
('bob', 'bob@example.com', '2025-01-02'),
('charlie', 'charlie@example.com', '2025-01-03');


-- Tạo trigger AFTER INSERT và AFTER DELETE trên likes để tự động cập nhật like_count trong bảng posts.
delimiter //
create trigger trigger_AFTER_INSERT
AFTER INSERT on likes 
for each row
begin
	update posts set like_count = like_count +1
    where post_id = new.post_id;
end //

delimiter ;

-- 
delimiter //
create trigger trigger_AFTER_DELETE 
AFTER DELETE on likes 
for each row
begin
	update posts set like_count = like_count -1
    where post_id = old.post_id;
end //

delimiter ;

-- Tạo một View tên user_statistics hiển thị: user_id, username, post_count, total_likes (tổng like_count của tất cả bài đăng của người dùng đó).

create or replace view user_statistics
as
select u.user_id , u.username ,u.post_count , sum(like_count) as total_likes from users u
left join posts p on u.user_id = p.user_id
group by u.user_id;

-- Thực hiện thêm/xóa một lượt thích và kiểm chứng: 

INSERT INTO likes (user_id, post_id, liked_at) VALUES (2, 4, NOW());
SELECT * FROM posts WHERE post_id = 4;
SELECT * FROM user_statistics;

-- Xóa một lượt thích và kiểm chứng lại View.

delete from likes where like_id = 2;


