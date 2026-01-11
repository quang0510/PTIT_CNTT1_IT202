use social_network_pro;

-- 2) Tạo một view với tên view_user_activity_status hiển thị các cột:  user_id , username, gender, created_at, status. Trong đó status được xác định như sau: 

-- "Active" nếu người dùng có ít nhất 1 bài viết hoặc 1 bình luận.
-- "Inactive" nếu người dùng không có bài viết và không có bình luận.
create or replace view view_user_activity_status as
select  u.user_id, u.username, u.gender, u.created_at,
    case
        when count(distinct p.post_id) > 0 or count(distinct c.comment_id) > 0
        then 'Active'
        else 'Inactive'
    end as status
from users u
left join posts p on p.user_id = u.user_id
left join comments c on c.user_id = u.user_id
group by u.user_id, u.username, u.gender, u.created_at;

-- 3) Truy vấn view view_user_activity_status và kiểm tra kết quả thu được. Dưới đây là bảng kết quả tượng trưng:
select * from view_user_activity_status;

-- 4)Truy vấn view view_user_activity_status để thống kê số lượng người dùng theo từng trạng thái (Active, Inactive). Thông tin bao gồm: Tên trạng thái (status) và Số lượng người dùng (user_count), sắp xếp theo số lượng người dùng giảm dần.
select status, count(*) as user_count from view_user_activity_status group by status order by user_count desc;
