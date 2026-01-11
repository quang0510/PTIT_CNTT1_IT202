use social_network_pro;

--     2) Tạo chỉ mục có tên idx_hometown trên cột hometown của bảng users
create index idx_hometown on users(hometown);

--     3) Thực hiện truy vấn với các yêu cầu sau:
-- Viết một câu truy vấn để tìm tất cả các người dùng (users) có hometown là "Hà Nội"
select * from users where hometown='Hà Nội';

-- Kết hợp với bảng posts để hiển thị thêm post_id và content về các lần đăng bài.
select u.*, post_id, content from users u
join posts p on p.user_id=u.user_id and u.hometown='Hà Nội' ;

-- Sắp xếp danh sách theo username giảm dần và giới hạn kết quả chỉ hiển thị 10 bài đăng đầu tiên.
select u.*, post_id, content from users u join posts p on p.user_id=u.user_id and u.hometown='Hà Nội'
order by username desc limit 10 offset 0;

--     4) Sử dụng EXPLAIN ANALYZE để kiểm tra lại kế hoạch thực thi trước và sau khi có chỉ mục.
drop index idx_hometown on users;
select u.*, post_id, content from users u 
join posts p on p.user_id=u.user_id and u.hometown='Hà Nội';

create index idx_hometown ON users(hometown);
explain analyze
select u.*, post_id, content from users u 
join posts p on p.user_id=u.user_id and u.hometown='Hà Nội';
