class Shop
  def initialize(io = Kernel)
    @io = io
  end

  def start_shop
    shop_welcome = "Welcome to the shop management program!\n\nWhat do you want to do?\n      1 = list all shop items\n      2 = create a new item\n      3 = list all orders\n      4 = create a new order"
    choice = @io.gets.chomp
    shop_items = "Here's a list of all shop items:\n\n    #1 Super Shark Vacuum Cleaner - Unit price: 99 - Quantity: 30\n    #2 Makerspresso Coffee Machine - Unit price: 69 - Quantity: 15"
    @io.puts shop_welcome 
    @io.puts shop_items
  end
end