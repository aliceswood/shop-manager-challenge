require 'order_repository'

RSpec.describe OrderRepository do
  def reset_orders_table
    seed_sql = File.read('spec/seeds_shop_manager.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
    connection.exec(seed_sql)
  end
  
  before(:each) do 
    reset_orders_table
  end

  it 'gets a list of all orders' do
    repo = OrderRepository.new
    
    orders = repo.all

    expect(orders.length).to eq(2)
    expect(orders.first.id).to eq(1)
    expect(orders.first.customer_name).to eq('Alice')
    expect(orders.first.order_date).to eq('2023-04-01')
    expect(orders.first.item_id).to eq(1)
  end
    
  it 'gets the information for the order with id 1' do
    repo = OrderRepository.new

    order = repo.find(1)

    expect(order.id).to eq(1)
    expect(order.customer_name).to eq('Alice')
    expect(order.order_date).to eq('2023-04-01')
    expect(order.item_id).to eq(1)
  end
   
  it 'gets the information for the order with id 2' do
    repo = OrderRepository.new

    order = repo.find(2)

    expect(order.id).to eq(2)
    expect(order.customer_name).to eq('Chris')
    expect(order.order_date).to eq('2023-05-01')
  end
    
  xit 'creates a new order' do
    repo = OrderRepository.new

    order = Order.new
    order.customer_name = 'Lucy'
    order.order_date = '2023-06-01'
    order.item_id = '2'

    repo.create(order)

    all_orders = repo.all
    latest_order = all_orders.last

    expect(latest_order.id).to eq('3')
    expect(latest_order.customer_name).to eq('Lucy')
    expect(latest_order.order_date).to eq('2023-06-01')
    expect(latest_order.item_id).to eq('2')
  end
   
  xit 'updates all information for an order' do
    repo = OrderRepository.new
    order = repo.find(1)

    order.customer_name = 'Emily'
    order.order_date = '2023-06-01'
    order.item_id = '2'

    repo.update(order)
    updated_order = repo.find(1)

    expect(updated_order.customer_name).to eq('Emily')
    expect(updated_order.order_date).to eq('2023-06-01')
    expect(updated_order.item_id).to eq('2')
  end
    
  xit 'updates some of the information for an order' do
    repo = OrderRepository.new

    order = repo.find(1)

    order.customer_name = 'Emily'

    repo.update(order)
    updated_order = repo.find(1)

    expect(updated_order.customer_name).to eq('Emily')
    expect(updated_order.order_date).to eq('2023-04-01')
    expect(updated_order.item_id).to eq('1')
  end
    
  xit 'deletes the order with id 1' do
    repo = OrderRepository.new

    id_to_delete = 1
    repo.delete(id_to_delete)
    all_orders = repo.all

    expect(all_orders.length).to eq(1)
    expect(all_orders.first.id).to eq('2')
    expect(all_orders.first.customer_name).to eq('Chris')
    expect(all_orders.first.order_date).to eq('2023-05-01')
    expect(all_orders.first.item_id).to eq('2')
  end
    
  xit 'deletes both orders' do
    repo = OrderRepository.new

    repo.delete(1)
    repo.delete(2)

    all_orders = repo.all

    expect(all_orders.length).to eq(0)
  end
end
