class ItemRepository
  def reset_items_table
    seed_sql = File.read('spec/seeds_shop_manager.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
    connection.exec(seed_sql)
  end
  
  RSpec.describe ItemRepository do
    before(:each) do 
      reset_items_table
    end

    
  end
end
