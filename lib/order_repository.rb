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

  def create(order)
    sql = 'INSERT INTO orders (customer_name, order_date, item_id) VALUES($1, $2, $3);'
    sql_params = [order.customer_name, order.order_date, order.item_id]

    DatabaseConnection.exec_params(sql, sql_params)
    
    return nil
  end

  def update(order)
    sql = 'UPDATE orders SET customer_name = $1, order_date = $2, item_id = $3 WHERE id = $4;'
    sql_params = [order.customer_name, order.order_date, order.item_id, order.id]

    DatabaseConnection.exec_params(sql, sql_params)
    
    return nil
  end

  def delete(id)
    sql = 'DELETE FROM orders WHERE id = $1;'
    sql_params = [id]

    DatabaseConnection.exec_params(sql, sql_params)
    
    return nil
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
