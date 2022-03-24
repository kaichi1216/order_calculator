class Cart
  attr_reader :user_id
  attr_accessor :product_list

  def initialize(user)
    @user_id = user.id
    @product_list = []
  end

  def <<(product)
    p = self.product_list.select {|p| p[:id] == product.id }
    if !p.empty?
      self.product_list.each_with_index do |v, i|
        if v[:id] == product.id
          self.product_list[i][:quantity] += 1
          self.product_list[i][:total_price] += v[:price]
        end
      end
    else
      self.product_list.push({id: product.id, name: product.name, price: product.price, quantity: 1, total_price: product.price})
    end
  end

  def total_price
    self.product_list.sum { |item| item[:total_price] }
  end

end