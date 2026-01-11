use social_network_pro;

-- 2) Tạo một index idx_user_gender trên cột gender của bảng users.
create index idx_user_gender on users(gender);

-- 3) Tạo một View tên view_popular_posts để lưu trữ post_id, username người đăng,content(Nội dung bài viết), số like, số comment (sử dụng JOIN giữa posts, users, likes, comments; GROUP BY post_id).
create or replace view view_popular_posts as
select p.post_id, u.username, p.content, count(distinct l.user_id) as like_count, count(distinct c.comment_id) as comment_count
from posts p
join users u on u.user_id = p.user_id
left join likes l on l.post_id = p.post_id
left join comments c on c.post_id = p.post_id
group by p.post_id;

-- 4) Truy vấn các thông tin của view view_popular_posts 
select * from view_popular_posts;

-- 5) viết query sử dụng View này để liệt kê các bài viết có số like + comment > 10, ORDER BY tổng tương tác giảm dần.
select post_id, username, content, like_count, comment_count, (like_count + comment_count) as total_interactions
from view_popular_posts
where (like_count + comment_count) > 10
order by total_interactions desc;