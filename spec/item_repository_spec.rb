require 'item_repository'

RSpec.describe ItemRepository do
  xit 'gets a list of all items' do
    repo = ItemRepository.new

    items = repo.all

    expect(items.length).to eq(2)
    expect(items.first.id).to eq('1')
    expect(items.first.name).to eq('Super Shark Vacuum Cleaner')
    expect(items.first.unit_price).to eq('99')
    expect(items.first.quantity).to eq('30')
  end
  
  xit 'returns the item at id 1' do
    repo = ItemRepository.new

    order = repo.find(1)

    expect(items.id).to eq('1')
    expect(items.name).to eq('Super Shark Vacuum Cleaner')
    expect(items.unit_price).to eq('99')
    expect(items.quantity).to eq('30')
  end

  xit 'returns the item at id 2' do
    repo = ItemRepository.new

    order = repo.find(1)

    expect(items.id).to eq('2')
    expect(items.name).to eq('Makerspresso Coffee Machine')
    expect(items.unit_price).to eq('69')
    expect(items.quantity).to eq('15')
  end
    
  xit 'creates a new item' do
    repo = ItemRepository.new

    item = Item.new
    item.name = 'Big TV'
    item.unit_price = 129
    item.quantity = 45

    repo.create(item)

    all_items = repo.all
    latest_item = all_items.last

    expect(latest_item.id).to eq('3')
    expect(latest_item.name).to eq('Big TV')
    expect(latest_item.unit_price).to eq('129')
    expect(latest_item.quantity).to eq('45')
  end

  xit 'updates all of the information for an item' do
    repo = ItemRepository.new
    item = repo.find(1)

    item.name = 'Comfy Armchair'
    item.unit_price = '79'
    item.quantity = '60'

    repo.update(item)
    updated_item = repo.find(1)

    expect(updated_item.name).to eq('Comfy Armchair')
    expect(updated_item.unit_price).to eq('79')
    expect(updated_item.quantity).to eq('60')
  end
    # 5 
    # Updates some information in an item
  xit 'updates some of the information for an item' do
    repo = ItemRepository.new
    item = repo.find(1)

    item.name = 'Comfy Armchair'

    repo.update(item)
    updated_item = repo.find(1)

    expect(updated_item.name).to eq('Comfy Armchair')
    expect(updated_item.unit_price).to eq('99')
    expect(updated_item.quantity).to eq('30')
  end
   
  xit 'deletes the item with id 1' do
    repo = ItemRepository.new

    id_to_delete = 1
    repo.delete(id_to_delete)

    all_items = repo.all

    expect(all_items.length).to eq(1)
    expect(all_items.first.id).to eq('2')
    expect(all_items.first.name).to eq('Makerspresso Coffee Machine')
    expect(all_items.first.unit_price).to eq('69')
    expect(all_items.first.quantity).to eq('15')
  end

  xit 'deletes both records' do
    repo = ItemRepository.new

    repo.delete(1)
    repo.delete(2)

    all_items = repo.all
    expect(all_items.length).to eq(0)
  end
end