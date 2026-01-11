use social_network_mini;

create or replace view view_users_firstname 
as
select user_id , username , full_name , email , created_at
from users
where full_name like 'Nguyễn%'
with check option;

select * from view_users_firstname;

insert into users (user_id ,username , full_name, email , created_at  , password) values
(100 , 'Huy' , 'Nguyễn Quang Huy' , 'nqh@gmail.com' , current_timestamp() , '123');

select * from view_users_firstname;

delete from users where user_id = 100;