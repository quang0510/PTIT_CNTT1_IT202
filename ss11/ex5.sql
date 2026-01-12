-- 2) viết procedure tên calculateuseractivityscore nhận in p_user_id (int),
-- trả về out activity_score (int) và out activity_level (varchar(50))

delimiter //

create procedure calculateuseractivityscore(in p_user_id int, out activity_score int, out activity_level varchar(50))
begin
    declare v_post_count int default 0;
    declare v_comment_count int default 0;
    declare v_like_count int default 0;

    select count(*) into v_post_count from posts
    where user_id = p_user_id;

    select count(*) into v_comment_count from comments
    where user_id = p_user_id;

    select count(*) into v_like_count from likes l
    join posts p on l.post_id = p.post_id
    where p.user_id = p_user_id;

    set activity_score = (v_post_count * 10) + (v_comment_count * 5) + (v_like_count * 3);

    case
        when activity_score > 500 then
            set activity_level = 'rất tích cực';
        when activity_score between 200 and 500 then
            set activity_level = 'tích cực';
        else
            set activity_level = 'bình thường';
    end case;

end //

delimiter ;

-- 3) gọi thủ tục
call calculateuseractivityscore(2, @score, @level);

select @score as activity_score, @level as activity_level;

-- 4) xóa thủ tục
drop procedure  calculateuseractivityscore;
