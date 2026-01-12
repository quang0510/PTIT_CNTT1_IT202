use social_network_pro;

delimiter //
create procedure ex1 (p_user_id int )

begin
	select post_id , content , created_at from posts
    where p_user_id = user_id;

end //
delimiter ;

call ex1(2);

drop procedure ex1;