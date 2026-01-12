use social_network_pro;

delimiter //

create procedure ex2(in p_post_id int  , out total_likes int)

begin 
	select count(user_id) into total_likes from likes 
    where p_post_id = post_id;
end //

delimiter ;

drop procedure ex2;

call ex2( 102 , @total_likes);
select  @total_likes;
