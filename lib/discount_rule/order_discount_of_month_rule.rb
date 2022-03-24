require_relative '../../model/calculator'
require_relative '../../model/user'
require_relative '../../model/product'
require_relative '../../model/cart'
require_relative '../../model/promotion'
require_relative 'base'

module DiscountRule
  class OrderDiscountOfMonthRule < Base
    DEFAULT_NAME = '訂單滿 1000 元折 50 元，此折扣每個月折扣上限 200 元'
    #預設 訂單滿 1000 折 50 元 此折扣每個月折扣上限 200 元
    DEFAULT_ORDER_PRICE_RULE = 1000
    DEFAULT_DISCOUNT_MONEY = 50
    DEFAULT_ORDER_USE_MONEY_LIMIT = 200

    def initialize(params = {})
      @user_id = params[:user_id]
      @order_price = params[:order_price]
      @order_price_rule = params[:order_price_rule] || DEFAULT_ORDER_PRICE_RULE
      @discount_money = params[:discount_money] || DEFAULT_DISCOUNT_MONEY
      @order_use_money_limit = params[:order_use_money_limit] || DEFAULT_ORDER_USE_MONEY_LIMIT

      super

      @name ||= DEFAULT_NAME
    end

    private

    def calc_discount_rule
      discount = 0
      discount_money = ((@order_price / @order_price_rule).floor) * @discount_money
      #use month be key of hash
      month = Time.now.strftime("%m").to_sym
      user_record = $user_limit_money_of_month.find {|h| h[:user_id] == @user_id }
      index = $user_limit_money_of_month.index {|h| h[:user_id] == @user_id }

      if @order_price >= @order_price_rule
        if user_record
          #find money balance
          money_balance = user_record[month]
          if money_balance >= discount_money
            $user_limit_money_of_month[index][month] -= discount_money
          else
            $user_limit_money_of_month[index][month] -= money_balance
          end
          discount += money_balance
        else
          discount += if @order_use_money_limit >= discount_money
                        discount_money
                      end
          $user_limit_money_of_month << {user_id: @user_id, "#{month}": @order_use_money_limit - discount}
        end

        @discount_content.push("符合訂單滿#{@order_price_rule}折#{@discount_money}元(最多折#{@order_use_money_limit})，此筆訂單總共折#{discount}") if discount > 0
      end
      
      discount
    end

  end
end

