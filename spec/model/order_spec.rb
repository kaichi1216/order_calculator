require_relative '../../model/calculator'
require_relative '../../model/user'
require_relative '../../model/product'
require_relative '../../model/cart'
require_relative '../../model/promotion'
require_relative '../../model/order'

describe Order do
  context "order detail" do
    before do
      @user = User.new(1)
      @cart = Cart.new(@user)
      @p_1 = Product.new(1, "飯糰", 30, "鮮食")
      @p_2 = Product.new(2, "麥香奶茶", 10, "飲品")

    end

    it "order didn't match any discount rule" do
      @cart << @p_1
      res = Calculator.caculate(@cart)
      order = Order.new(product_list: @cart.product_list, user_id: @cart.user_id, calculate: res)

      expect(order.user_id).to eq(1)
      expect(order.discount_price).to eq(0)
      expect(order.final_price).to eq(30)
    end

    it "order match one discount rule" do
      2.times do 
        @cart << @p_1
      end
      res = Calculator.caculate(@cart)
      order = Order.new(product_list: @cart.product_list, user_id: @cart.user_id, calculate: res)

      expect(order.discount_content.length).to eq(1)
      expect(order.discount_price).to eq(10)
      expect(order.final_price).to eq(50)
    end

    it "order match twice discount rule" do
      5.times do 
        @cart << @p_1
      end
      res = Calculator.caculate(@cart)
      order = Order.new(product_list: @cart.product_list, user_id: @cart.user_id, calculate: res)
      
      expect(order.discount_content.length).to eq(2)
      expect(order.discount_price).to eq(35)
      expect(order.final_price).to eq(115)
    end

    it "order match four discount rule" do
      5.times do 
        @cart << @p_1
      end

      30.times do 
        @cart << @p_2
      end

      res = Calculator.caculate(@cart)
      order = Order.new(product_list: @cart.product_list, user_id: @cart.user_id, calculate: res)

      expect(order.discount_content.length).to eq(4)
      expect(order.discount_price).to eq(85)
      expect(order.final_price).to eq(365)
    end

  end
end