module DiscountRule
  class BuyTwoGetOff < Base
    DEFAULT_NAME = '特定商品滿 x 件折 y 元'
    #預設 同商品滿兩件 折10
    DEFAULT_DISCOUNT_MOENY = 10
    DEFAULT_COUNT_RULE = 2

    attr_reader :product_id, :discount_money

    def initialize(params = {})
      @product_id = params[:id]
      @discount_money = params[:discount_money] || DEFAULT_DISCOUNT_MOENY
      @count_rule = params[:count_rule] || DEFAULT_COUNT_RULE

      super

      @name ||= DEFAULT_NAME
    end

    private

    def calc_discount_rule
      discount = 0

      product = cart.product_list.find { |item| item[:id] == product_id }
      if product && product[:quantity] >= @count_rule
        count = (product[:quantity] / @count_rule)
        discount += (count * discount_money)
        @discount_content << "指定商品滿#{@count_rule}件折#{discount_money}元，#{product[:name]}商品符合活動#{count}次，折抵#{discount}元"
      end
      
      discount
    end
  end
end
