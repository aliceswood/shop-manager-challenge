-- Write your SQL seed here. 

-- First, you'd need to truncate the table - this is so our table is emptied between each test run,
-- so we can start with a fresh state.
-- (RESTART IDENTITY resets the primary key)

TRUNCATE TABLE orders RESTART IDENTITY CASCADE;
TRUNCATE TABLE items RESTART IDENTITY CASCADE;
 -- replace with your own table name.

-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.

INSERT INTO items (name, unit_price, quantity) VALUES ('Super Shark Vacuum Cleaner', 99, 30);
INSERT INTO items (name, unit_price, quantity) VALUES ('Makerspresso Coffee Machine', 69, 15);
-- replace with your own table name.

-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.

INSERT INTO orders (customer_name, order_date, item_id) VALUES ('Alice', '2023-04-01', 1);
INSERT INTO orders (customer_name, order_date, item_id) VALUES ('Chris', '2023-05-01', 2);
