require_relative './item'

class ItemRepository
  def all
    sql = 'SELECT id, name, unit_price, quantity FROM items;'
    items = []

    result_set = DatabaseConnection.exec_params(sql, [])
    item = Item.new

    result_set.each do |record|
      item.id = record['id']
      item.name = record['name']
      item.unit_price = record['unit_price']
      item.quantity = record['quantity']
    

      items << item
    end
    return items
  end

  # Gets a single record by its ID
  # One argument: the id (number)
  def find(id)
    # Executes the SQL query:
    # SELECT id, name, unit_price, quantity FROM items WHERE id = $1;

    # Returns a single Item object.
  end

  # Creates a single record
  # Takes an Item object as an argument
  def create(item)
    # Executes the SQL query:
    # INSERT INTO items (name, unit_price, quantity) VALUES($1, $2, $3)

    # returns nil (just creates a new order)
  end

  # Updates a record
  # Takes an id as the argument
  def update(id)
    # Executes the SQL query:
    # UPDATE items SET name, unit_price, quantity WHERE id = $1;

    # returns nil (only updates the record)
  end

  # Creates a single record
  # Takes an Item object as an argument
  def delete(item)
    # Executes the SQL query:
    # DELETE FROM items WHERE id = $1;

    # returns nil (only deletes the record)
  end
end
