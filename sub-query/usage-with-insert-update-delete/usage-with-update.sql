-- Populate the money col of loyal_cutomer table using the orders table. Provide a 10% app money to all customers based on their order value.
UPDATE zomato.loyal_users
SET money = (SELECT SUM(order_value) * 0.1
             FROM orders o
             WHERE o.user_id = loyal_users.user_id
             GROUP BY o.user_id);
             