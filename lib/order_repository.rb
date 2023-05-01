require_relative './order'

class OrderRepository

  def all
    sql = 'SELECT id, customer_name, order_date, item_id FROM orders;'
    orders = []

    result_set = DatabaseConnection.exec_params(sql, [])

    result_set.each do |record|
      orders << record_to_order_object(record)
    end
    return orders
  end

  def find(id)
    sql = 'SELECT id, customer_name, order_date, item_id FROM orders WHERE id = $1;'
    sql_params = [id]

    result_set = DatabaseConnection.exec_params(sql, sql_params)

    record = result_set[0]

    return record_to_order_object(record)
  end

  # Creates a single record
  # Takes an Order object as an argument
  def create(order)
    # Executes the SQL query:
    # INSERT INTO orders (customer_name, order_date, item_id) VALUES($1, $2, $3)

    # returns nil (just creates a new order)
  end

  # Updates a record
  # Takes an id as the argument
  def update(id)
    # Executes the SQL query:
    # UPDATE orders SET customer_name, order_date, item_id WHERE id = $1;

    # returns nil (only updates the record)
  end

  # Creates a single record
  # Takes an Order object as an argument
  def delete(order)
    # Executes the SQL query:
    # DELETE FROM orders WHERE id = $1;

    # returns nil (only deletes the record)
  end

  private

  def record_to_order_object(record)
    order = Order.new
    order.id = record['id'].to_i
    order.customer_name = record['customer_name']
    order.order_date = record['order_date']
    order.item_id = record['item_id'].to_i
    return order
  end
end
