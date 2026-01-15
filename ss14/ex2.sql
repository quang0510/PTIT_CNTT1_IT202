use social_network;

create table likes(
	like_id int auto_increment primary key,
    post_id int not null,
    user_id int not null,
    unique (post_id, user_id),
    foreign key (post_id) references posts(post_id),
    foreign key (user_id) references users(user_id)
);

-- Thêm cột likes_count INT DEFAULT 0 vào bảng posts nếu chưa có.
alter table posts
add column likes_count int default 0;

-- Viết script SQL sử dụng TRANSACTION để:
	-- INSERT vào bảng likes (post_id và user_id do bạn chọn).
	-- UPDATE tăng likes_count +1 cho bài viết tương ứng.
	-- Nếu vi phạm UNIQUE constraint (đã like trước đó) hoặc lỗi khác, ROLLBACK.
	-- Nếu thành công, COMMIT.
start transaction ;

insert into likes (post_id , user_id ) values (1 ,1 );

update posts set likes_count =  likes_count +1
where post_id = 1;

commit;

start transaction;

-- like trùng (post_id = 1, user_id = 1 đã tồn tại)
insert into likes (post_id, user_id)
values (1, 1);
-- dòng này không chạy vì insert trên bị lỗi unique
update posts set likes_count = likes_count + 1
where post_id = 1;

rollback;






