-- Delete all the customers record who have never ordered
DELETE FROM zomato.loyal_users
WHERE user_id NOT IN (SELECT DISTINCT user_id FROM orders);