-- 2) viết stored procedure tên notifyfriendsonnewpost nhận hai tham số in:

-- p_user_id (int) – id của người đăng bài
-- p_content (text) – nội dung bài viết
-- procedure sẽ thực hiện hai việc:

-- thêm một bài viết mới vào bảng posts với user_id và content được truyền vào.
-- tự động gửi thông báo loại 'new_post' vào bảng notifications cho tất cả bạn bè đã accepted
-- (cả hai chiều trong bảng friends).
-- nội dung thông báo: “[full_name của người đăng] đã đăng một bài viết mới”.
-- không gửi thông báo cho chính người đăng bài.

delimiter //

create procedure notifyfriendsonnewpost(in p_user_id int, in p_content text
)
begin
    declare v_post_id int;
    declare v_full_name varchar(255);

    select full_name into v_full_name from users
    where user_id = p_user_id;

    insert into posts(user_id, content, created_at)
    values (p_user_id, p_content, now());

    set v_post_id = last_insert_id();

    insert into notifications(user_id, type, content, created_at)
    select
        friend_user_id,
        'new_post',
        concat(v_full_name, ' đã đăng một bài viết mới'),
        now()
    from (
        select friend_id as friend_user_id
        from friends
        where user_id = p_user_id
          and status = 'accepted'
        union
        select user_id as friend_user_id
        from friends
        where friend_id = p_user_id
          and status = 'accepted'
    ) as all_friends
    where friend_user_id <> p_user_id;

end //

delimiter ;

-- 3) gọi procedure trên và thêm bài viết mới
call notifyfriendsonnewpost(3, 'hôm nay mình vừa học xong stored procedure trong mysql!' );

-- 4) select ra những thông báo của bài viết vừa đăng
select n.*, u.full_name
from notifications n
join users u on n.user_id = u.user_id
where n.type = 'new_post'
order by n.created_at desc;

-- 5) xóa thủ tục vừa khởi tạo trên
drop procedure notifyfriendsonnewpost;
