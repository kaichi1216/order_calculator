require_relative '../../../lib/discount_rule/base'
require_relative '../../../lib/discount_rule/discount_money_on_order'
require_relative '../../../model/user'
require_relative '../../../model/product'
require_relative '../../../model/cart'
require_relative '../../../model/promotion'

describe DiscountRule::DiscountMoneyOnOrder do
  context "order discount have limit discount money" do
    before do
      @user = User.new(1)
      @cart = Cart.new(@user)
      @p_1 = Product.new(1, "飯糰", 30, "鮮食")
    end

    it "Not eligible for order discount" do
      2.times do 
        @cart << @p_1
      end

      msg = DiscountRule::DiscountMoneyOnOrder.new(cart: @cart, user_id: @cart.user_id, order_price: @cart.total_price, order_amount: 300, persent: 9, limit_money: 100).perform
      
      expect(msg[:original]).to eq(60)
      expect(msg[:discount]).to eq(0)
      expect(msg[:final]).to eq(60)
    end

    it "conform discount" do
      10.times do 
        @cart << @p_1
      end

      msg = DiscountRule::DiscountMoneyOnOrder.new(cart: @cart, user_id: @cart.user_id, order_price: @cart.total_price, order_amount: 300, persent: 9, limit_money: 100).perform
      
      expect(msg[:original]).to eq(300)
      expect(msg[:discount]).to eq(30)
      expect(msg[:final]).to eq(270)
    end

    it "discount money has limit" do
      30.times do 
        @cart << @p_1
      end

      msg = DiscountRule::DiscountMoneyOnOrder.new(cart: @cart, user_id: @cart.user_id, order_price: @cart.total_price, order_amount: 300, persent: 9, limit_money: 100).perform
      
      expect(msg[:original]).to eq(900)
      expect(msg[:discount]).to eq(70)
      expect(msg[:final]).to eq(830)
    end
  end
end