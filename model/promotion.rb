class Promotion
  def self.checkout_discount_rules(cart)
    total_price = cart.total_price
    res = []
    #rules
    res.push(DiscountRule::BuyTwoGetOff.new(cart: cart, id: 1, count_rule: 2, discount_money: 10).perform)
    res.push(DiscountRule::OrderGetFreeItem.new(cart: cart, order_price: cart.total_price, order_price_rule: 200).perform)
    res.push(DiscountRule::PersentDiscountOnOrder.new(cart: cart, order_price: cart.total_price, order_amount: 100, persent: 9).perform)
    res.push(DiscountRule::OrderDiscountRule.new(cart: cart, order_price: cart.total_price, order_price_rule: 400, discount_money: 20, use_count: 1).perform)
    res.push(DiscountRule::DiscountMoneyOnOrder.new(cart: cart, user_id: cart.user_id, order_price: cart.total_price, order_amount: 300, persent: 9, limit_money: 100).perform)

    result = res.each_with_object({total_discount: 0, discount_content:[]}) do |hash,result|
               result[:total_discount] += hash[:discount]
               result[:discount_content] += hash[:content]
             end

    return result
  end
end

 