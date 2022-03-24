require_relative '../../model/user'
require_relative '../../model/product'
require_relative '../../model/cart'

describe Cart do
  before do
    @user = User.new(1)
    @cart = Cart.new(@user)
    @p_1 = Product.new(1, "飯糰", 30, "鮮食")
    @p_2 = Product.new(2, "麥香奶茶", 10, "飲品")
  end

  context "new cart" do
    it "check cart init values" do
      expect(@cart.user_id).to eq(1)
      expect(@cart.product_list).to eq([])
    end
  end

  context "put products in cart" do
    it "check cart product_list values" do
      @cart << @p_1

      expect(@cart.product_list.first[:id]).to eq(1)
      expect(@cart.product_list.first[:name]).to eq("飯糰")
      expect(@cart.product_list.first[:price]).to eq(30)
    end
  end

  context "put different product in cart" do
    it "check cart product total quantity" do
      @cart << @p_1
      @cart << @p_2

      expect(@cart.product_list.count).to eq(2)
    end
  end

  context "put same products in cart" do
    it "check product qunatity and total_price" do
      @cart << @p_1
      @cart << @p_1

      expect(@cart.product_list.first[:quantity]).to eq(2)
      expect(@cart.product_list.first[:total_price]).to eq(60)
    end
  end
end