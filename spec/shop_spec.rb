require 'shop'

RSpec.describe Shop do
  it 'greets the shop manager' do
    io = double :io
    shop_welcome = "Welcome to the shop management program!\n\nWhat do you want to do?\n      1 = list all shop items\n      2 = create a new item\n      3 = list all orders\n      4 = create a new order"
    shop_items = "Here's a list of all shop items:\n\n    #1 Super Shark Vacuum Cleaner - Unit price: 99 - Quantity: 30\n    #2 Makerspresso Coffee Machine - Unit price: 69 - Quantity: 15"
    expect(io).to receive(:puts).with(shop_welcome)
    expect(io).to receive(:gets).and_return("1")
    expect(io).to receive(:puts).with(shop_items)

    shop = Shop.new(io)
    shop.start_shop
  end
end