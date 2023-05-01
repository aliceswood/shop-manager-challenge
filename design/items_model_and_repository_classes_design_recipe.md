# Items Model and Repository Classes Design Recipe

_Copy this recipe template to design and implement Model and Repository classes for a database table._

## 1. Design and create the Table

If the table is already created in the database, you can skip this step.

Otherwise, [follow this recipe to design and create the SQL schema for your table](./single_table_design_recipe_template.md).


```
# EXAMPLE

Table: items

Columns:
id | name | unit_price | quantity
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

TRUNCATE TABLE items RESTART IDENTITY; -- replace with your own table name.

-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.

INSERT INTO items (name, unit_price, quantity, order_id) VALUES ('Super Shark Vacuum Cleaner', 99, 30);
INSERT INTO items (name, unit_price, quantity, order_id) VALUES ('Makerspresso Coffee Machine', 69, 15);
```

Run this SQL file on the database to truncate (empty) the table, and insert the seed data. Be mindful of the fact any existing records in the table will be deleted.

```bash
psql -h 127.0.0.1 shop_manager < spec/seeds_shop_manager.sql
psql -h 127.0.0.1 shop_manager_test < spec/seeds_shop_manager.sql
```

## 3. Define the class names

Usually, the Model class name will be the capitalised table name (single instead of plural). The same name is then suffixed by `Repository` for the Repository class name.

```ruby
# EXAMPLE
# Table name: items

# Model class
# (in lib/item.rb)
class Item
end

# Repository class
# (in lib/item_repository.rb)
class ItemRepository
end
```

## 4. Implement the Model class

Define the attributes of your Model class. You can usually map the table columns to the attributes of the class, including primary and foreign keys.

```ruby
# EXAMPLE
# Table name: items

# Model class
# (in lib/item.rb)

class Item

  # Replace the attributes by your own columns.
  attr_accessor :id, :name, :unit_price, :quantity
end

# The keyword attr_accessor is a special Ruby feature
# which allows us to set and get attributes on an object,

```

*You may choose to test-drive this class, but unless it contains any more logic than the example above, it is probably not needed.*

## 5. Define the Repository Class interface

Your Repository class will need to implement methods for each "read" or "write" operation you'd like to run against the database.

Using comments, define the method signatures (arguments and return value) and what they do - write up the SQL queries that will be used by each method.

```ruby
# EXAMPLE
# Table name: item

# Repository class
# (in lib/item_repository.rb)

class ItemRepository

  # Selecting all records
  # No arguments
  def all
    # Executes the SQL query:
    # SELECT id, name, unit_price, quantity, order_id FROM items;

    # Returns an array of Order objects.
  end

  # Gets a single record by its ID
  # One argument: the id (number)
  def find(id)
    # Executes the SQL query:
    # SELECT id, name, unit_price, quantity, order_id FROM items WHERE id = $1;

    # Returns a single Item object.
  end

  # Creates a single record
  # Takes an Item object as an argument
  def create(item)
    # Executes the SQL query:
    # INSERT INTO items (name, unit_price, quantity, order_id) VALUES($1, $2, $3, $4)

    # returns nil (just creates a new order)
  end

  # Updates a record
  # Takes an id as the argument
  def update(item)
    # Executes the SQL query:
    # UPDATE items SET name = $1, unit_price = $2, quantity = $3 WHERE id = $4;

    # returns nil (only updates the record)
  end

  # Creates a single record
  # Takes an Item object as an argument
  def delete(id)
    # Executes the SQL query:
    # DELETE FROM items WHERE id = $1;

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
# Get all items
repo = ItemRepository.new

items = repo.all

items.length # =>  2

items.first.id # => 1
items.first.name # => 'Super Shark Vacuum Cleaner'
items.first.unit_price # => 99
items.first.quantity # => 30

# 2
# Get a single order at id 1

repo = ItemRepository.new

item = repo.find(1)

item.id # => 1
item.name # => 'Super Shark Vacuum Cleaner'
item.unit_price # => 99
item.quantity # => 30

# 2
# Get a single order at id 2

repo = ItemRepository.new

item = repo.find(2)

item.id # => 2
item.name # => 'Makerspresso Coffee Machine'
item.unit_price # => 69
item.quantity # => 15

# 3
# Create a new item

repo = ItemRepository.new

item = Item.new
item.name = 'Big TV'
item.unit_price = 129
item.quantity = 45

repo.create(item)

all_item = repo.all
latest_item = all_item.last

latest_item.id # => 3
latest_item.name # => 'Big TV'
latest_item.unit_price # => 129
latest_item.quantity # => 45

# 4 
# Updates all information for an item

repo = ItemRepository.new

item = repo.find(1)

item.name = 'Comfy Armchair'
item.unit_price = '79'
item.quantity = '60'

repo.update(ite,)

updated_item = repo.find(1)

updated_item.name # => 'Comfy Armchair'
updated_item.unit_price # => '79'
updated_item.quantity # => '60'

# 5 
# Updates some information in an item

repo = ItemRepository.new

item = repo.find(1)

item.name = 'Comfy Armchair'

repo.update(item)

updated_item = repo.find(1)

updated_item.name # => 'Comfy Armchair'
updated_item.unit_price # => '99'
updated_item.quantity # => '30'

# 6
# Deletes a record at id 1

repo = ItemRepository.new

id_to_delete = 1

repo.delete(id_to_delete)

all_items = repo.all

all_items.length # => 1
all_items.first.id # => '2'
all_items.first.name # => 'Makerspresso Coffee Machine'
all_items.first.unit_price # => '69'
all_items.first.quantity # => '15'

# 7
# Deletes both records 

repo = ItemRepository.new

repo.delete(1)
repo.delete(2)

all_items = repo.all

all_items.length # => 0
```

Encode this example as a test.

## 7. Reload the SQL seeds before each test run

Running the SQL code present in the seed file will empty the table and re-insert the seed data.

This is so you get a fresh table contents every time you run the test suite.

```ruby
# EXAMPLE

# file: spec/item_repository_spec.rb

def reset_items_table
  seed_sql = File.read('spec/seeds_shop_manager.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
  connection.exec(seed_sql)
end

describe ItemRepository do
  before(:each) do 
    reset_items_table
  end

  # (your tests will go here).
end
```

## 8. Test-drive and implement the Repository class behaviour

_After each test you write, follow the test-driving process of red, green, refactor to implement the behaviour._
