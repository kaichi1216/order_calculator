module DiscountRule
  class OrderGetFreeItem < Base
    DEFAULT_NAME = '訂單滿兩百送造型玻璃杯'
    #預設 滿200 送造型杯
    DEFAULT_ORDER_PRICE_RULE = 200

    attr_reader :product_id, :discount_money

    def initialize(params = {})
      @order_price_rule = params[:order_price_rule] || DEFAULT_ORDER_PRICE_RULE
      @order_price = params[:order_price]

      super

      @name ||= DEFAULT_NAME
    end

    private

    def calc_discount_rule
      discount = 0

      if @order_price >= @order_price_rule
        @discount_content.push("符合訂單滿#{@order_price_rule}送造型玻璃杯乙個")
      end
      
      discount
    end

  end
end
