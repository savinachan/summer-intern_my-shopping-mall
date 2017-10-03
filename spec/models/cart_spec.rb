require 'rails_helper'

RSpec.describe Cart, type: :model do

  ###before(:each) { @cart = Cart.new } 
  #each 每個測試都做一次 / all 一個測試檔只做一次
  # => cart 變成 @cart 並且不用 “cart = Cart.new”

  let(:cart) { Cart.new }
  #照樣用 cart 不用 “cart = Cart.new”

  describe "購物車基本功能" do
    it "可以新增商品到購物車裡，然後購物車裡就有東西了" do
    	
    	#cart = Cart.new
    	cart.add_item(1)
    	expect(cart.empty?).to be false
    end

    it "如果加了相同種類的商品，購買項目(CartItem)並不會增加，但數量會改變。" do
    	#cart = Cart.new
    	3.times { cart.add_item(1) }
    	5.times { cart.add_item(2) }
    	expect(cart.items.count).to be 2
    	expect(cart.items.first.quantity).to be 3
    	expect(cart.items.last.quantity).to be 5



    end

    it "商品可以放到購物車裡，也可以再拿出來" do
    	p1 = Product.create    # ActiveRecord
    	#cart = Cart.new
    	cart.add_item(p1.id)

    	expect(cart.items.first.product).to be_a Product 
    	expect(cart.items.first.product_id).to be p1.id
    end

    it "可以計算整個購物車的總消費金額" do
    	p1 = Product.create(title:"Ruby", price: 10)
    	p2 = Product.create(title:"PHP", price: 100)
    	#cart = Cart.new
    	3.times { cart.add_item(p1.id) }
    	5.times { cart.add_item(p2.id) }
    
    	expect(cart.total_price).to eq 530
    end
  end

  describe "購物車進階功能" do
      it "可以將購物車內容轉換成 Hash，存到 Session 裡" do
        #cart = Cart.new
        3.times { cart.add_item(2) }   # 新增商品 id 2
        4.times { cart.add_item(5) }   # 新增商品 id 5

        expect(cart.serialize).to eq session_hash
      end

      it "可以把 Session 的內容（Hash 格式），還原成購物車的內容" do
        cart = Cart.from_hash(session_hash)

        expect(cart.items.first.product_id).to be 2
        expect(cart.items.first.quantity).to be 3
        expect(cart.items.second.product_id).to be 5
        expect(cart.items.second.quantity).to be 4
      end

    end

  private ####
  def session_hash
      {
        "items" => [
          {"product_id" => 2, "quantity" => 3},
          {"product_id" => 5, "quantity" => 4}
        ]
      }
  end


end
