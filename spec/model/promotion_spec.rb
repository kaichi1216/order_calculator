require_relative '../../model/user'
require_relative '../../model/product'
require_relative '../../model/cart'
require_relative '../../model/promotion'
require_relative '../../lib/discount_rule/base'
require_relative '../../lib/discount_rule/discount_money_on_order'
require_relative '../../lib/discount_rule/buy_two_get_off'
require_relative '../../lib/discount_rule/order_discount_rule'
require_relative '../../lib/discount_rule/order_get_free_item'
require_relative '../../lib/discount_rule/persent_discount_on_order'

describe Promotion do
  context "prmotion rules" do
    before do 
      @user = User.new(1)
      @cart = Cart.new(@user)
      @p_1 = Product.new(1, "飯糰", 30, "鮮食")
      @p_2 = Product.new(2, "麥香奶茶", 10, "飲品")
    end

    it "check promotion" do
      @cart << @p_1
      @cart << @p_2
      promotion = Promotion.checkout_discount_rules(@cart)
      expect(promotion[:discount_content].length).to eq(0)
      expect(promotion[:total_discount]).to eq(0)
    end

    it "check match once discount" do
      3.times do 
        @cart << @p_1
      end
      promotion = Promotion.checkout_discount_rules(@cart)
      expect(promotion[:discount_content].length).to eq(1)
      expect(promotion[:total_discount]).to eq(10)
    end
  end
end