
CREATE TABLE zomato.loyal_users
(
    user_id INT PRIMARY KEY,

    name VARCHAR(100) NOT NULL,

    money DECIMAL(10,2) DEFAULT 0.00,

    CONSTRAINT fk_loyal_users_users
        FOREIGN KEY (user_id)
        REFERENCES users(user_id)


);

-- Populate a already created loyal_customers table with records of only those customers who have ordered food more than 3 times.

INSERT INTO zomato.loyal_users (user_id, name)
SELECT u.user_id, u.name
FROM users u
JOIN orders o ON u.user_id = o.user_id
GROUP BY u.user_id, u.name
HAVING COUNT(o.order_id) > 3;

