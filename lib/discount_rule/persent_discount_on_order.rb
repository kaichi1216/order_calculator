module DiscountRule
  class PersentDiscountOnOrder < Base
    DEFAULT_NAME = '訂單滿 x 元打 y 折'
    #預設滿100 打９折
    DEFAULT_ORDER_AMOUNT = 100
    DEFAULT_DISCOUNT_PERSENT = 9

    def initialize(params = {})
      @order_amount = params[:order_amount] || DEFAULT_ORDER_AMOUNT
      @persent = params[:persent] || DEFAULT_DISCOUNT_PERSENT
      @order_price = params[:order_price]

      super

      @name ||= DEFAULT_NAME
    end

    private

    def calc_discount_rule
      discount = 0

      if calc_orignal >= @order_amount
        persent = @persent / 10.0
        discount = @order_price - ((@order_price * persent).ceil)
        @discount_content.push("符合訂單滿#{@order_amount}打#{@persent}折，折扣#{discount}元")
      end
      
      discount
    end
  end
end
