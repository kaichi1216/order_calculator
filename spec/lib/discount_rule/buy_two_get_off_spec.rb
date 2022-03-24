require_relative '../../../lib/discount_rule/base'
require_relative '../../../lib/discount_rule/buy_two_get_off'
require_relative '../../../model/user'
require_relative '../../../model/product'
require_relative '../../../model/cart'
require_relative '../../../model/promotion'

describe DiscountRule::BuyTwoGetOff do
  context "conform item quantity discount" do
    before do
      @user = User.new(1)
      @cart = Cart.new(@user)
      @p_1 = Product.new(1, "飯糰", 30, "鮮食")
    end

    it "conform discount price" do
      2.times do 
        @cart << @p_1
      end
      msg = DiscountRule::BuyTwoGetOff.new(cart: @cart, id: 1, count_rule: 2, discount_money: 10).perform
      
      expect(msg[:original]).to eq(60)
      expect(msg[:discount]).to eq(10)
      expect(msg[:final]).to eq(50)
    end

    it "conform once discount" do
      3.times do 
        @cart << @p_1
      end
      msg = DiscountRule::BuyTwoGetOff.new(cart: @cart, id: 1, count_rule: 2, discount_money: 10).perform
      
      expect(msg[:original]).to eq(90)
      expect(msg[:discount]).to eq(10)
      expect(msg[:final]).to eq(80)
    end
  end
end