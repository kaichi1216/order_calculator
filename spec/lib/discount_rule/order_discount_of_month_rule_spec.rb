require_relative '../../../lib/discount_rule/base'
require_relative '../../../lib/discount_rule/order_discount_of_month_rule'
require_relative '../../../model/user'
require_relative '../../../model/product'
require_relative '../../../model/cart'
require_relative '../../../model/promotion'

describe DiscountRule::OrderDiscountOfMonthRule do
  context "conform order discount of month rule" do
    before do
      @user = User.new(1)
      @cart = Cart.new(@user)
      @p_1 = Product.new(1, "飯糰", 50, "鮮食")
    end

    it "conform once discount" do
      20.times do 
        @cart << @p_1
      end

      msg = DiscountRule::OrderDiscountOfMonthRule.new(cart: @cart, user_id: @cart.user_id, order_price: @cart.total_price).perform

      expect(msg[:original]).to eq(1000)
      expect(msg[:discount]).to eq(50)
      expect(msg[:final]).to eq(950)
    end

    it "conform limit discount" do
      60.times do 
        @cart << @p_1
      end
      
      msg = DiscountRule::OrderDiscountOfMonthRule.new(cart: @cart, user_id: @cart.user_id, order_price: @cart.total_price).perform
      
      expect(msg[:original]).to eq(3000)
      expect(msg[:discount]).to eq(150)
      expect(msg[:final]).to eq(2850)
    end

    it "conform no discount" do
      20.times do 
        @cart << @p_1
      end
      
      msg = DiscountRule::OrderDiscountOfMonthRule.new(cart: @cart, user_id: @cart.user_id, order_price: @cart.total_price).perform
      
      expect(msg[:original]).to eq(1000)
      expect(msg[:discount]).to eq(0)
      expect(msg[:final]).to eq(1000)
    end

    it "conform all discount" do
      @user2 = User.new(2)
      @cart2 = Cart.new(@user2)
      80.times do 
        @cart2 << @p_1
      end
      
      msg = DiscountRule::OrderDiscountOfMonthRule.new(cart: @cart2, user_id: @cart2.user_id, order_price: @cart2.total_price).perform
      
      expect(msg[:original]).to eq(4000)
      expect(msg[:discount]).to eq(200)
      expect(msg[:final]).to eq(3800)
    end
  end
end