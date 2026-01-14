create database ex3_ss13;
use ex3_ss13;

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

INSERT INTO posts (user_id, content, created_at) VALUES
(1, 'Hello world from Alice!', '2025-01-10 10:00:00'),
(1, 'Second post by Alice', '2025-01-10 12:00:00'),
(2, 'Bob first post', '2025-01-11 09:00:00'),
(3, 'Charlie sharing thoughts', '2025-01-12 15:00:00');

INSERT INTO likes (user_id, post_id, liked_at) VALUES
(2, 1, '2025-01-10 11:00:00'),
(3, 1, '2025-01-10 13:00:00'),
(1, 3, '2025-01-11 10:00:00'),
(3, 4, '2025-01-12 16:00:00');

delimiter //

create trigger trigger_validateuserlikes
before insert on likes
for each row
begin
	declare author_id int;
    
    select user_id into author_id from posts
    where post_id = new.post_id;

    if new.user_id = author_id then
        signal sqlstate '45000' set message_text = 'lỗi: không thể tự like bài viết chính mình!';
    end if;
end //

delimiter ;

-- after insert/delete/update: cập nhật like_count trong posts tương ứng (tăng/giảm khi thêm/xóa, điều chỉnh khi update post_id).

delimiter //

create trigger trigger_updatelikecount_afterupdate
after update on likes
for each row
begin
	-- giảm like ở bài cũ
    update posts
    set like_count = like_count - 1
    where post_id = old.post_id;
    
    -- tăng like ở bài mới
    update posts
    set like_count = like_count + 1
    where post_id = new.post_id;
end //

delimiter ;

-- thực hiện các thao tác kiểm thử:

-- thử like bài của chính mình (phải báo lỗi)
insert into likes (user_id, post_id) values (1, 1);

-- thêm like hợp lệ, kiểm tra like_count
insert into likes (user_id, post_id) values (2, 1);
insert into likes (user_id, post_id) values (3, 1);

-- update một like sang post khác, kiểm tra like_count của cả hai post
update likes
set post_id = 2
where user_id = 3 and post_id = 1;

select * from posts;

-- xóa like và kiểm tra
delete from likes
where user_id = 2 and post_id = 1;

-- kiểm tra kết quả
select * from posts where post_id = 1;










