class Calculator
  def self.caculate(cart)
    original = cart.total_price
    result = Promotion.checkout_discount_rules(cart)
    discount = result[:total_discount]
    final = original - discount

    return {original: original, discount: discount, final: final, discount_content: result[:discount_content]}
  end
end
