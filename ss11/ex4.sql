-- 2) viết procedure tên createpostwithvalidation nhận in p_user_id (int), in p_content (text).
-- nếu độ dài content < 5 ký tự thì không thêm bài viết và set biến thông báo lỗi

delimiter //

create procedure createpostwithvalidation(in p_user_id int, in p_content text, out result_message varchar(255)
)
begin
    case
        when char_length(p_content) < 5 then
            set result_message = 'nội dung quá ngắn';
        else
            insert into posts(user_id, content)
            values (p_user_id, p_content);
            set result_message = 'thêm bài viết thành công';
    end case;
end //

delimiter ;


-- 3) gọi thủ tục và thử insert các trường hợp
call createpostwithvalidation(1, 'hi', @result);
select @result;

call createpostwithvalidation(1, 'đây là bài viết hợp lệ', @result);
select @result;

-- 4) kiểm tra các kết quả
select * from posts
where user_id = 1
order by id desc;

-- 5) xóa thủ tục vừa khởi tạo trên
drop procedure createpostwithvalidation;
