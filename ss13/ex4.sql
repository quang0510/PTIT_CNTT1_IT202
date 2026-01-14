use ex3_ss13;

create table post_history(
	history_id int primary key auto_increment,
    post_id int,
    foreign key(post_id) references posts(post_id),
    old_content text,
    new_content text,
    changed_at datetime,
    changed_by_user_id int
);


-- before update trên posts: nếu content thay đổi, insert bản ghi vào post_history với old_content (old.content), new_content (new.content), changed_at now(), và giả sử changed_by_user_id là user_id của post.
delimiter //
create trigger tg_before_update_post
before update
on posts
for each row
begin
	if old.content <> new.content then
		insert into post_history(post_id,old_content,new_content,changed_at,changed_by_user_id) value
		(old.post_id,old.content,new.content,curdate(),old.user_id);
	end if;
end //
delimiter ;

-- after delete trên posts: có thể ghi log hoặc để cascade.
delimiter //
create trigger tg_after_delete_post
after delete on posts
for each row
begin
	insert into post_history(post_id,old_content,new_content,changed_at,changed_by_user_id) value
    (old.post_id,old.content,'đã xoá',curdate(),old.user_id);
end //

delimiter ;

-- 4) thực hiện update nội dung một số bài đăng, sau đó select từ post_history để xem lịch sử.
update posts
set content = 'nội dung lần 3: chào mọi người, mình mới sửa bài!' 
where post_id = 1;

-- 5) kiểm tra kết hợp với trigger like_count từ bài trước vẫn hoạt động khi update post.
insert into likes (user_id, post_id) values (1, 3);

select * from posts;
select * from post_history;