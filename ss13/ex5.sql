use ex3_ss13;

-- 1)tạo stored procedure add_user(username, email, created_at) thực hiện insert vào users.
delimiter //
create procedure add_user(in_username varchar(255), in_email varchar(255), in_created_at date)
begin
	insert into users(username,email,created_at) value
    (in_username,in_email,in_created_at);
end //
delimiter ;

-- 2) tạo trigger before insert trên users:
delimiter //
create trigger tg_before_insert_user
before insert
on users
for each row
begin
    -- kiểm tra email chứa '@' và '.'.
    if (new.email not like '%@%') or (new.email not like '%.%') then
        signal sqlstate '45000' 
        set message_text = 'lỗi: email không đúng định dạng (thiếu @ hoặc .)';
    end if;

    -- kiểm tra username chỉ chứa chữ cái, số và underscore.
    if new.username regexp '[^a-za-z0-9_]' then
        signal sqlstate '45000' 
        set message_text = 'lỗi: username chứa ký tự đặc biệt không cho phép!';
    end if;
end //
delimiter ;

-- 3) gọi procedure với dữ liệu hợp lệ và không hợp lệ để kiểm thử.
call add_user('!quang1','quang1@gmail.com',curdate());
call add_user('quang2','quang2@gmail',curdate());
call add_user('quang3','quang3@gmail.com',curdate());
-- 4) select * from users để xem kết quả.
select * from users;
