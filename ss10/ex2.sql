use social_network_mini;

create or replace view view_user_post 
as
select u.user_id , u.full_name, count(p.post_id) as total_user_post  
from users u
join posts p on u.user_id = p.user_id
group by u.user_id ;

select * from view_user_post;
