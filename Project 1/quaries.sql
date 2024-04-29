-- location for user
select users.user_id,username,email,location from post inner join users on users.user_id=post.user_id where location in ('Agra','maharashtra','west bengal') ;
select * from users;

-- most followed hasttag

select hashtags.hashtag_id,hashtag_name,count(hashtags.hashtag_id) as most_followed_hashtag
from hashtag_follow inner join hashtags on hashtags.hashtag_id=hashtag_follow.hashtag_id
group by hashtags.hashtag_id 
order by count(hashtags.hashtag_id) desc limit 5;

-- 3. Most Used Hashtag
select hashtags.hashtag_id,hashtag_name,count(post_tags.hashtag_id) as most_used_hashtag 
from post_tags inner join hashtags on hashtags.hashtag_id=post_tags.hashtag_id
group by post_tags.hashtag_id order by most_used_hashtag desc limit 10 ;

-- 4. Most Inactive User
select user_id,username from users 
where user_id 
not in (select user_id from post);

-- 5. Most Likes Posts
select post.post_id,post.user_id,count(post.post_id) from post_likes
inner join post on post.post_id=post_likes.post_id 
group by post.post_id 
order by count(*) desc ;

-- 6. Average post per user
select round((count(post_id)/count(distinct user_id)),2) from post;

-- 7. no. of login by per user
select users.user_id,email,username,login_id from login 
inner join users on users.user_id=login.user_id ;

-- 8. User who liked every single post (CHECK FOR BOT)

select username,count(*) as num_likes from users inner join 
post_likes on  post_likes.user_id=users.user_id 
group by post_likes.user_id
having num_likes=(select count(*) from post);

-- 9. User Never Comment
select user_id,username from users 
where user_id not in (select distinct(user_id) from comments); 

-- 10. User who commented on every post (CHECK FOR BOT)
select username,count(*) as num_comments from comments 
inner join users on users.user_id=comments.user_id 
group by(username) 
having num_comments=(select count(*) from post);

-- 11. User Not Followed by anyone
select user_id,username  from users where user_id not in (select user_id from follows);

-- 12. User Not Following Anyone
select user_id,username from users where user_id not in (select user_id from follows);

-- 13. Posted more than 5 times
select user_id,count(*) as posts 
from post group by user_id 
having posts>5 order by posts desc;

-- 14. Followers > 40
select followee_id,count(follower_id) as num_followers 
from follows group by followee_id 
having num_followers > 40 order by num_followers desc;

-- 15. Any specific word in comment
select * from comments where comment_text like '%good%' or comment_text like '%beautiful%';

select user_id,caption,length(caption) from post 
order by length(caption) desc limit 5;


