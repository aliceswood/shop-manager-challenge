CREATE TABLE orders (
  id SERIAL PRIMARY KEY,
  customer_name text,
  order_date date
);

-- Then the table with the foreign key first.
CREATE TABLE items (
  id SERIAL PRIMARY KEY,
  name text,
  unit_price money,
  quantity int,
-- The foreign key name is always {other_table_singular}_id
  order_id int,
  constraint fk_order foreign key(order_id)
    references orders(id)
    on delete cascade
);