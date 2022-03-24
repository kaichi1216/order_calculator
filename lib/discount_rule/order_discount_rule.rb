module DiscountRule
  class OrderDiscountRule < Base
    DEFAULT_NAME = '訂單滿 X 元折 Y 元,此折扣在全站限用 N 次'
    #預設 滿400 折20 只能使用一次
    DEFAULT_ORDER_PRICE_RULE = 400
    DEFAULT_DISCOUNT_MONEY = 20
    DEFAULT_USE_COUNT = 1

    attr_reader :product_id, :discount_money

    def initialize(params = {})
      @order_price_rule = params[:order_price_rule] || DEFAULT_ORDER_PRICE_RULE
      @discount_money = params[:discount_money] || DEFAULT_DISCOUNT_MONEY
      @use_count = params[:use_count] || DEFAULT_USE_COUNT
      @order_price = params[:order_price]

      super
      @user_id = @cart.user_id
      @name ||= DEFAULT_NAME
    end

    private

    def calc_discount_rule
      discount = 0

      if @order_price >= @order_price_rule && $user_ids.count(@user_id) < @use_count
        discount += @discount_money
        $user_ids << @user_id
        @discount_content.push("符合訂單滿#{@order_price_rule}折#{@discount_money}元，全站限用一次")
      end

      discount
    end

  end
end