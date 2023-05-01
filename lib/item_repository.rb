require_relative './item'

class ItemRepository
  def all
    sql = 'SELECT id, name, unit_price, quantity FROM items;'
    items = []

    result_set = DatabaseConnection.exec_params(sql, [])
    
    result_set.each do |record|
      items << record_to_item_object(record)
    end
    return items
  end

  def find(id)
    sql = 'SELECT id, name, unit_price, quantity FROM items WHERE id = $1;'
    sql_params = [id]

    result_set = DatabaseConnection.exec_params(sql, sql_params)

    record = result_set[0]

    return record_to_item_object(record)
  end

  def create(item)
    sql = 'INSERT INTO items (name, unit_price, quantity) VALUES($1, $2, $3);'
    sql_params = [item.name, item.unit_price, item.quantity]
    DatabaseConnection.exec_params(sql, sql_params)

    return nil
  end

  def update(item)
    sql = 'UPDATE items SET name = $1, unit_price = $2, quantity = $3 WHERE id = $4;'
    sql_params = [item.name, item.unit_price, item.quantity, item.id]
    DatabaseConnection.exec_params(sql, sql_params)

    return nil
  end

  def delete(id)
    sql = 'DELETE FROM items WHERE id = $1;'
    sql_params = [id]
    DatabaseConnection.exec_params(sql, sql_params)

    return nil
  end

  private 

  def record_to_item_object(record)
    item = Item.new
    item.id = record['id'].to_i
    item.name = record['name']
    item.unit_price = record['unit_price'].to_i
    item.quantity = record['quantity'].to_i
    return item
  end
end
