module DiscountRule
  class DiscountMoneyOnOrder < Base
    DEFAULT_NAME = '訂單滿 X 元折 Z %,折扣每人只能總共優惠 N 元'
    #預設 滿300 打9折 最多優惠100元
    DEFAULT_ORDER_AMOUNT = 300
    DEFAULT_DISCOUNT_PERSENT = 9
    DEFAULT_DISCOUNT_LIMIT_MOENY = 100

    def initialize(params = {})
      @user_id = params[:user_id]
      @order_price = params[:order_price]
      @order_amount = params[:order_amount] || DEFAULT_ORDER_AMOUNT
      @persent = params[:persent] || DEFAULT_DISCOUNT_PERSENT
      @limit_money = params[:limit_money] || DEFAULT_DISCOUNT_LIMIT_MOENY


      super

      @name ||= DEFAULT_NAME
    end

    private

    def calc_discount_rule
      discount = 0

      if @calc_orignal >= @order_amount
        user_record = $user_limit_money.find {|h| h[:user_id] == @user_id }
        persent = @persent / 10.0
        discount_money = @order_price - ((@order_price * persent).ceil)
 
        money = if user_record
                  user_record[:limit_money]
                else
                  money = @limit_money
                end

        if discount_money >= money
          discount += money
        elsif discount_money <= money
          discount += discount_money
        end

        if user_record
          $user_limit_money.each_with_index do |v, i|
            if v[:user_id] == @user_id
              $user_limit_money[i][:limit_money] -= discount
              break
            end
          end
        else
          $user_limit_money << { user_id: @user_id, limit_money: (@limit_money - discount)}
        end
      end

      if discount > 0
        @discount_content.push("符合訂單滿#{@order_amount}打#{@persent}折(最多折#{@limit_money})，此筆訂單總共折#{discount}")
      end

      discount
    end
  end
end
