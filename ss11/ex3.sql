use social_network_pro;

delimiter //

create procedure CalculateBonusPoints(in p_user_id int, inout p_bonus_points int
)
begin
    declare v_post_count int default 0;

    -- Đếm số bài viết của user
    select count(*) into v_post_count
    from posts
    where user_id = p_user_id;

    -- Cộng điểm theo số bài viết
		case
			when v_post_count >= 20 then
				set p_bonus_points = p_bonus_points + 100;
			when v_post_count >= 10 then
				set p_bonus_points = p_bonus_points + 50;
		end case;

end //

-- 3) Gọi thủ tục trên với giá trị id user và p_bonus_points bất kì mà bạn muốn cập nhật
set @bonus_points = 100;

call CalculateBonusPoints(3, @bonus_points);

-- 4) Select ra p_bonus_points 
select @bonus_points as final_bonus_points;

-- 5) Xóa thủ tục mới khởi tạo trên 
drop procedure CalculateBonusPoints;