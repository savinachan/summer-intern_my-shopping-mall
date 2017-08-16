require 'rails_helper'

RSpec.describe CartItem, type: :model do

  it "每台購物車都可計算他自己的金額（小計）" do
    	
    #p1 = Product.create(title:"Ruby", price: 10)
    #p2 = Product.create(title:"PHP", price: 100)
    p1 = FactoryGirl.create(:product, price: 10)
    p2 = FactoryGirl.create(:product, price: 100)
    #spec/fatories/cart_items.rb

    cart = Cart.new
    3.times { cart.add_item(p1.id) }
    5.times { cart.add_item(p2.id) }
    
    expect(cart.items.first.total_price).to eq 30
    expect(cart.items.last.total_price).to eq 500
  end


end
