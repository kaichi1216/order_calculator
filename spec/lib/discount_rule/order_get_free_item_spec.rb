require_relative '../../../lib/discount_rule/base'
require_relative '../../../lib/discount_rule/order_get_free_item'
require_relative '../../../model/user'
require_relative '../../../model/product'
require_relative '../../../model/cart'
require_relative '../../../model/promotion'

describe DiscountRule::OrderGetFreeItem do
  context "conform order discount get free item" do
    before do
      @user = User.new(1)
      @cart = Cart.new(@user)
      @p_1 = Product.new(1, "飯糰", 30, "鮮食")
    end

    it "Not eligible for order discount" do
      2.times do 
        @cart << @p_1
      end
      msg = DiscountRule::OrderGetFreeItem.new(cart: @cart, order_price: @cart.total_price, order_price_rule: 100).perform
      
      expect(msg[:original]).to eq(60)
      expect(msg[:discount]).to eq(0)
      expect(msg[:final]).to eq(60)
      expect(msg[:content]).to eq([])
    end

    it "conform order discount" do
      4.times do 
        @cart << @p_1
      end

      msg = DiscountRule::OrderGetFreeItem.new(cart: @cart, order_price: @cart.total_price, order_price_rule: 100).perform
      
      expect(msg[:original]).to eq(120)
      expect(msg[:discount]).to eq(0)
      expect(msg[:final]).to eq(120)
      expect(msg[:content].count).to eq(1)
    end

  end
end