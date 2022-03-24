require_relative '../../../lib/discount_rule/base'
require_relative '../../../model/user'
require_relative '../../../model/product'
require_relative '../../../model/cart'
require_relative '../../../model/promotion'

describe DiscountRule::Base do
  context "discount rule base" do
    before do
      @user = User.new(1)
      @cart = Cart.new(@user)
      @p_1 = Product.new(1, "飯糰", 30, "鮮食")
      @p_2 = Product.new(2, "麥香奶茶", 10, "飲品")
      @cart << @p_1
      @cart << @p_2
    end

    it "user id should be 1" do
      msg = DiscountRule::Base.new(cart: @cart).perform
      
      expect(msg[:original]).to eq(40)
      expect(msg[:discount]).to eq(0)
      expect(msg[:final]).to eq(40)
      expect(msg[:content]).to eq([])
    end
  end
end