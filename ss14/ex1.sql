create database social_network;
use social_network;

create table users(
	user_id int auto_increment primary key,
    username varchar(50) not null,
    posts_count int default 0
);

create table posts (
	post_id int auto_increment primary key,
    user_id int not null,
    content text not null,
    created_at datetime default current_timestamp,
    foreign key (user_id) references  users(user_id)
);

-- Viết script SQL sử dụng TRANSACTION để thực hiện:
	-- INSERT một bản ghi mới vào bảng posts (với user_id và content do bạn chọn).
	-- UPDATE tăng posts_count +1 cho user tương ứng.
	-- Nếu bất kỳ thao tác nào thất bại, thực hiện ROLLBACK.
	-- Nếu thành công, thực hiện COMMIT.

insert into users (username) values 
('Tôn phạm quang huy'),
('Trần trí dương');

start transaction;

insert into posts(user_id , content  ) values
(1 , 'Huy yêu tươi');

update users set posts_count = posts_count +1 
where user_id = 1;

commit;

-- Chạy script với ít nhất 2 trường hợp:
	-- Trường hợp thành công (COMMIT).
	-- Trường hợp gây lỗi cố ý (ví dụ: vi phạm ràng buộc khóa ngoại bằng user_id không tồn tại) để kiểm tra ROLLBACK.

start transaction;

insert into posts(user_id , content  ) values
(999 , 'Huy yêu tươi quá đi thôi');

update users set posts_count = posts_count +1 
where user_id = 999;

rollback;

select * from users;
select * from posts;

