require_relative '../../model/calculator'
require_relative '../../model/user'
require_relative '../../model/product'
require_relative '../../model/cart'
require_relative '../../model/promotion'
require 'pry'

describe Calculator do
  context "calculate items discount" do
    before do
      @user = User.new(1)
      @cart = Cart.new(@user)
      @p_1 = Product.new(1, "飯糰", 30, "鮮食")
      @p_2 = Product.new(2, "麥香奶茶", 10, "飲品")
    end

    it "no item in cart discount is 0" do
      res = Calculator.caculate(@cart)
      expect(res[:discount]).to eq(0)
    end

    it "match discount quantity rule item in cart" do
      2.times do 
        @cart << @p_1
      end

      res = Calculator.caculate(@cart)
      expect(res[:discount]).to eq(10)
    end

    it "cart total price match discount rule" do
      10.times do 
        @cart << @p_2
      end

      res = Calculator.caculate(@cart)
      expect(res[:discount]).to eq(10)
    end

    it "match two discount rule" do
      3.times do 
        @cart << @p_1
      end
      10.times do 
        @cart << @p_2
      end

      res = Calculator.caculate(@cart)
      expect(res[:discount]).to eq(29)
    end

    it "match all discount rule" do
      user = User.new(10)
      @cart_2 = Cart.new(user)

      30.times do 
        @cart_2 << @p_1
      end
      10.times do 
        @cart_2 << @p_2
      end

      res = Calculator.caculate(@cart_2)
      
      expect(res[:original]).to eq(1000)
      expect(res[:discount]).to eq(370)
      expect(res[:final]).to eq(630)
      expect(res[:discount_content].count).to eq(5)
    end
  end
end