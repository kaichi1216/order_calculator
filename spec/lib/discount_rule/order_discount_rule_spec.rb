require_relative '../../../lib/discount_rule/base'
require_relative '../../../lib/discount_rule/order_discount_rule'
require_relative '../../../model/user'
require_relative '../../../model/product'
require_relative '../../../model/cart'
require_relative '../../../model/promotion'

describe DiscountRule::OrderDiscountRule do
  context "order discount rule" do
    before do
      @user = User.new(1)
      @cart = Cart.new(@user)
      @p_1 = Product.new(3, "飯糰", 30, "鮮食")
    end

    it "Not eligible for order discount" do
      3.times do 
        @cart << @p_1
      end

      msg = DiscountRule::OrderDiscountRule.new(cart: @cart, order_price: @cart.total_price, order_price_rule: 100, discount_money: 20, use_count: 1).perform
      
      expect(msg[:original]).to eq(90)
      expect(msg[:discount]).to eq(0)
      expect(msg[:final]).to eq(90)
    end

    it "conform order discount" do
      user = User.new(2)
      cart = Cart.new(user)

      4.times do 
        cart << @p_1
      end

      msg = DiscountRule::OrderDiscountRule.new(cart: cart, order_price: cart.total_price, order_price_rule: 100, discount_money: 20, use_count: 1).perform
      
      expect(msg[:original]).to eq(120)
      expect(msg[:discount]).to eq(20)
      expect(msg[:final]).to eq(100)
    end

  end
end