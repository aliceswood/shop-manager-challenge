# Orders Model and Repository Classes Design Recipe

_Copy this recipe template to design and implement Model and Repository classes for a database table._

## 1. Design and create the Table

If the table is already created in the database, you can skip this step.

Otherwise, [follow this recipe to design and create the SQL schema for your table](./single_table_design_recipe_template.md).


```
# EXAMPLE

Table: orders

Columns:
id | customer_name | order_date | item_id
```

## 2. Create Test SQL seeds

Your tests will depend on data stored in PostgreSQL to run.

If seed data is provided (or you already created it), you can skip this step.

```sql
-- EXAMPLE
-- (file: spec/seeds_shop_manager.sql)

-- Write your SQL seed here. 

-- First, you'd need to truncate the table - this is so our table is emptied between each test run,
-- so we can start with a fresh state.
-- (RESTART IDENTITY resets the primary key)

TRUNCATE TABLE orders RESTART IDENTITY; -- replace with your own table name.

-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.

INSERT INTO orders (customer_name, order_date, item_id) VALUES ('Alice', '1 April 2023', 1);
INSERT INTO orders (customer_name, order_date, item_id) VALUES ('Chris', '1 May 2023', 2);
```

Run this SQL file on the database to truncate (empty) the table, and insert the seed data. Be mindful of the fact any existing records in the table will be deleted.

```bash
psql -h 127.0.0.1 shop_manager < seeds_shop_manager.sql]
psql -h 127.0.0.1 shop_manager_test < seeds_shop_manager.sql
```

## 3. Define the class names

Usually, the Model class name will be the capitalised table name (single instead of plural). The same name is then suffixed by `Repository` for the Repository class name.

```ruby
# EXAMPLE
# Table name: orders

# Model class
# (in lib/order.rb)
class Order
end

# Repository class
# (in lib/order_repository.rb)
class OrderRepository
end
```

## 4. Implement the Model class

Define the attributes of your Model class. You can usually map the table columns to the attributes of the class, including primary and foreign keys.

```ruby
# EXAMPLE
# Table name: orders

# Model class
# (in lib/order.rb)

class Order

  # Replace the attributes by your own columns.
  attr_accessor :id, :customer_name, :order_date, :item_id
end

# The keyword attr_accessor is a special Ruby feature
# which allows us to set and get attributes on an object.
```

*You may choose to test-drive this class, but unless it contains any more logic than the example above, it is probably not needed.*

## 5. Define the Repository Class interface

Your Repository class will need to implement methods for each "read" or "write" operation you'd like to run against the database.

Using comments, define the method signatures (arguments and return value) and what they do - write up the SQL queries that will be used by each method.

```ruby
# EXAMPLE
# Table name: orders

# Repository class
# (in lib/order_repository.rb)

class OrderRepository

  # Selecting all records
  # No arguments
  def all
    # Executes the SQL query:
    # SELECT id, customer_name, order_date FROM orders;

    # Returns an array of Order objects.
  end

  # Gets a single record by its ID
  # One argument: the id (number)
  def find(id)
    # Executes the SQL query:
    # SELECT id, customer_name, order_date FROM orders WHERE id = $1;

    # Returns a single Order object.
  end

  # Creates a single record
  # Takes an Order object as an argument
  def create(order)
    # Executes the SQL query:
    # INSERT INTO orders (customer_name, order_date) VALUES($1, $2)

    # returns nil (just creates a new order)
  end

  # Updates a record
  # Takes an id as the argument
  def update(id)
    # Executes the SQL query:
    # UPDATE orders SET customer_name, order_date WHERE id = $1;

    # returns nil (only updates the record)
  end

  # Creates a single record
  # Takes an Order object as an argument
  def delete(order)
    # Executes the SQL query:
    # DELETE FROM orders WHERE id = $1;

    # returns nil (only deletes the record)
  end
end
```

## 6. Write Test Examples

Write Ruby code that defines the expected behaviour of the Repository class, following your design from the table written in step 5.

These examples will later be encoded as RSpec tests.

```ruby
# EXAMPLES

# 1
# Get all orders

repo = OrderRepository.new

orders = repo.all

orders.length # =>  2

orders.first.id # => '1'
orders.first.customer_name # => 'Alice' 
orders.first.order_date # => '1 April 2023'
orders.first.item_id # => '1'

# 2
# Get a single order at id 1

repo = OrderRepository.new

order = repo.find(1)

order.id # =>  '1'
order.customer_name # =>  'Alice'
order.order_date # =>  '1 April 2023'
order.item_id # => '1'

# 2
# Get a single order at id 2

repo = OrderRepository.new

order = repo.find(2)

order.id # =>  '2'
order.customer_name # =>  'Chris'
order.order_date # =>  '1 May 2023'

# 3
# Create a new order

repo = OrderRepository.new

order = Order.new
order.customer_name = 'Lucy'
order.order_date = '1 June 2023'
order.item_id = '2'

repo.create(order)

all_orders = repo.all
latest_order = all_orders.last

latest_order.id # => '3'
latest_order.customer_name # => 'Lucy'
latest_order.order_date # => '1 June 2023'
latest_order.item_id # => '2'

# 4 
# Updates all information in an order

repo = OrderRepository.new

order = repo.find(1)

order.customer_name = 'Emily'
order.order_date = '1 June 2023'
order.item_id = '2'

repo.update(order)

updated_order = repo.find(1)

updated_order.customer_name # => 'Emily'
updated_order.order_date # => '1 June 2023'
updated_order.item_id # => '2'

# 5 
# Updates some information in an order

repo = OrderRepository.new

order = repo.find(1)

order.customer_name = 'Emily'

repo.update(order)

updated_order = repo.find(1)

updated_order.customer_name # => 'Emily'
updated_order.order_date # => '1 April 2023'
update_order.item_id # => '1'

# 6
# Deletes a record at id 1

repo = OrderRepository.new

id_to_delete = 1

repo.delete(id_to_delete)

all_orders = repo.all

all_orders.length # => 1
all_orders.first.id # => '2'
all_orders.first.customer_name # => 'Chris'
all_orders.first.order_date # => '1 May 2023'
all_orders.first.item_id # => '2'

# 7
# Deletes both records 

repo = OrderRepository.new

repo.delete(1)
repo.delete(2)

all_orders = repo.all

all_orders.length # => 0
```

Encode this example as a test.

## 7. Reload the SQL seeds before each test run

Running the SQL code present in the seed file will empty the table and re-insert the seed data.

This is so you get a fresh table contents every time you run the test suite.

```ruby
# EXAMPLE

# file: spec/order_repository_spec.rb

def reset_orders_table
  seed_sql = File.read('spec/seeds_shop_manager.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
  connection.exec(seed_sql)
end

describe OrderRepository do
  before(:each) do 
    reset_orders_table
  end

  # (your tests will go here).
end
```

## 8. Test-drive and implement the Repository class behaviour

_After each test you write, follow the test-driving process of red, green, refactor to implement the behaviour._
