create database session14_ex6;
use session14_ex6;

create table users (
    user_id int primary key auto_increment,
    username varchar(50) not null,
    posts_count int default 0,
    following_count int default 0,
    followers_count int default 0,
    friends_count int default 0
);

create table posts (
    post_id int primary key auto_increment,
    user_id int not null,
    content text not null,
    created_at datetime default current_timestamp,
    likes_count int default 0,
    comments_count int default 0,
    foreign key (user_id) references users(user_id)
);

create table likes (
    like_id int primary key auto_increment,
    post_id int not null,
    user_id int not null,
    foreign key (post_id) references posts(post_id),
    foreign key (user_id) references users(user_id),
    unique key unique_like (post_id, user_id)
);

create table follows (
    follower_id int not null,
    followed_id int not null,
    primary key (follower_id, followed_id)
);

create table comments (
    comment_id int primary key auto_increment,
    post_id int not null,
    user_id int not null,
    content text not null,
    created_at datetime default current_timestamp,
    foreign key (post_id) references posts(post_id),
    foreign key (user_id) references users(user_id)
);

create table delete_log (
    log_id int primary key auto_increment,
    post_id int,
    deleted_at datetime default current_timestamp,
    deleted_by int
);

create table friend_requests (
    request_id int primary key auto_increment,
    from_user_id int,
    to_user_id int,
    status enum('pending','accepted','rejected') default 'pending'
);

create table friends (
    user_id int,
    friend_id int,
    primary key (user_id, friend_id)
);

insert into users (username) values
('nguyenvana'),
('tran_thi_b'),
('le_van_c'),
('pham_dang_d'),
('hoang_thi_e'),
('minh_tuan_99');

-- bài 1
delimiter //
create procedure add_posts(in p_user_id int, in p_content text)
begin
    declare exit handler for sqlexception
    begin
        rollback;
        select 'đã có lỗi xảy ra, hệ thống đã khôi phục dữ liệu' as errormessage;
    end;

    start transaction;

    if not exists (select 1 from users where user_id = p_user_id) then
        rollback;
        select 'user id không tồn tại!' as errormessage;
    else
        insert into posts (user_id, content)
        values (p_user_id, p_content);

        update users
        set posts_count = posts_count + 1
        where user_id = p_user_id;

        commit;
    end if;
end //
delimiter ;

call add_posts(1, 'học csdl');
call add_posts(20, 'học csdl');

select * from posts;
select * from users;

-- bài 2
delimiter //
create procedure sp_like_post(in p_user_id int, in p_post_id int)
begin
    declare exit handler for sqlexception
    begin
        rollback;
        select 'bài viết đã được like' as message;
    end;

    start transaction;

    insert into likes (post_id, user_id)
    values (p_post_id, p_user_id);

    update posts
    set likes_count = likes_count + 1
    where post_id = p_post_id;

    commit;
    select 'like bài viết thành công!' as message;
end //
delimiter ;

call add_posts(1, 'chào buổi chiều');
call sp_like_post(1, 1);

select * from likes;
select post_id, content, likes_count from posts;

call sp_like_post(1, 1);

-- bài 3
delimiter //
create procedure sp_follow_user(in p_follower_id int, in p_followed_id int)
begin
    declare exit handler for sqlexception
    begin
        rollback;
        select 'lỗi: đã xảy ra lỗi hệ thống, thao tác đã được khôi phục.' as message;
    end;

    start transaction;

    if not exists (select 1 from users where user_id = p_follower_id)
       or not exists (select 1 from users where user_id = p_followed_id) then
        rollback;
        select 'một trong hai user id không tồn tại trên hệ thống.' as message;

    elseif p_follower_id = p_followed_id then
        rollback;
        select 'không thể tự follow chính mình.' as message;

    elseif exists (
        select 1
        from follows
        where follower_id = p_follower_id
          and followed_id = p_followed_id
    ) then
        rollback;
        select 'đã theo dõi' as message;

    else
        insert into follows (follower_id, followed_id)
        values (p_follower_id, p_followed_id);

        update users
        set following_count = following_count + 1
        where user_id = p_follower_id;

        update users
        set followers_count = followers_count + 1
        where user_id = p_followed_id;

        commit;
        select 'đã theo dõi người dùng.' as message;
    end if;
end //
delimiter ;

call sp_follow_user(1, 2);
select * from users where user_id in (1, 2);

call sp_follow_user(1, 1);
call sp_follow_user(1, 2);

-- bài 4
delimiter //
create procedure sp_add_comment(
    in p_post_id int,
    in p_user_id int,
    in p_content text
)
begin
    start transaction;

    insert into comments (post_id, user_id, content)
    values (p_post_id, p_user_id, p_content);

    savepoint after_insert;

    if p_content = 'lỗi' then
        rollback to after_insert;
        select 'đã có lỗi sau khi thêm bình luận' as message;
    else
        update posts
        set comments_count = comments_count + 1
        where post_id = p_post_id;

        select 'đã thêm bình luận và cập nhật số lượng.' as message;
    end if;

    commit;
end //
delimiter ;

call sp_add_comment(1, 2, 'bài viết rất hay!');
select * from comments;
select post_id, comments_count from posts where post_id = 1;

call sp_add_comment(1, 3, 'lỗi');
select * from comments;
select post_id, comments_count from posts where post_id = 1;

-- bài 5
delimiter //
create procedure sp_delete_post(in p_post_id int, in p_user_id int)
begin
    declare exit handler for sqlexception
    begin
        rollback;
        select 'lỗi khi xóa bài viết' as message;
    end;

    start transaction;

    if not exists (
        select 1
        from posts
        where post_id = p_post_id
          and user_id = p_user_id
    ) then
        rollback;
        select 'bài viết không tồn tại hoặc bạn không có quyền xóa!' as message;
    else
        delete from likes where post_id = p_post_id;
        delete from comments where post_id = p_post_id;
        delete from posts where post_id = p_post_id;

        update users
        set posts_count = posts_count - 1
        where user_id = p_user_id;

        insert into delete_log (post_id, deleted_by)
        values (p_post_id, p_user_id);

        commit;
        select 'xóa bài viết thành công!' as message;
    end if;
end //
delimiter ;

call sp_delete_post(1, 1);
select * from delete_log;

call sp_delete_post(2, 2);

-- bài 6
insert into friend_requests (from_user_id, to_user_id, status)
values (2, 1, 'pending');

delimiter //
create procedure sp_accept_friend_request(
    in p_request_id int,
    in p_to_user_id int
)
begin
    declare v_from_user_id int;
    declare v_status enum('pending','accepted','rejected');

    declare exit handler for sqlexception
    begin
        rollback;
        select 'lỗi' as message;
    end;

    set transaction isolation level repeatable read;
    start transaction;

    select from_user_id, status
    into v_from_user_id, v_status
    from friend_requests
    where request_id = p_request_id
      and to_user_id = p_to_user_id;

    if v_from_user_id is null or v_status != 'pending' then
        rollback;
        select 'yêu cầu không tồn tại hoặc đã được xử lý' as message;
    else
        insert into friends (user_id, friend_id)
        values (v_from_user_id, p_to_user_id);

        insert into friends (user_id, friend_id)
        values (p_to_user_id, v_from_user_id);

        update users
        set friends_count = friends_count + 1
        where user_id in (v_from_user_id, p_to_user_id);

        update friend_requests
        set status = 'accepted'
        where request_id = p_request_id;

        commit;
        select 'thành công: đã chấp nhận lời mời kết bạn.' as message;
    end if;
end //
delimiter ;

call sp_accept_friend_request(1, 1);

select * from friends;
select user_id, username, friends_count
from users
where user_id in (1, 2);

select * from friend_requests;

call sp_accept_friend_request(1, 1);
call sp_accept_friend_request(1, 3);
